//
//  AuthService.swift
//  lab5
//
//  Created by Sarvar Saidazov on 27.03.2024.
//

import Foundation

final class AuthService {
    static let shared = AuthService()
    
    let clientId = "49c56765d67b44b6b7798ffc9777d840"
    let clientPass = "ef59527ae1f442818ad5041fe0d9edd7"
    let tokenApi = "https://accounts.spotify.com/api/token"
    
    private init() {
        
    }
    
    public var singUrl:URL? {
        let scope = "user-read-private"
        let homePage = "https://accounts.spotify.com/authorize"
        let url = "\(homePage)?response_type=code&client_id=\(clientId)&scope=\(scope)&redirect_uri=\("https://www.goat.com")&show_dialog=TRUE"
        return URL(string: url)
    }
    
    var isSigned:Bool {
        return token != nil
    }
    
    private var token:String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var updateToken:String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var exparationTokenDate:Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var needRefresh:Bool {
        guard let expirationDate = exparationTokenDate else {
            return false
        }
        let curentDate = Date()
        let fiveMinutes:TimeInterval = 300
        return curentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    
    public func exchangeCode(
        code:String,
        completion:@escaping ((Bool) -> Void)
    ) {
        guard let url = URL(string: tokenApi) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.goat.com")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = clientId+":"+clientPass
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                self.cacheToken(result:result)
            
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
    }
    
    public func refreshToken(completion:@escaping (Bool) -> Void) {
        guard needRefresh else {
            completion(true)
            return
        }
        guard let refreshToken = self.updateToken else {
            return
        }
        
        guard let url = URL(string: tokenApi) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = clientId+":"+clientPass
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data,
                  error == nil else {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                self.cacheToken(result:result)
            
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
        
    }
    
    
    
    private func cacheToken(result:Response) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token  = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    
    
    
}
