//
//  Response.swift
//  lab5
//
//  Created by Sarvar Saidazov on 08.04.2024.
//

import Foundation

struct Response:Codable {
    let access_token:String
    let expires_in:Int
    let refresh_token:String?
    let scope:String
    let token_type:String
}
