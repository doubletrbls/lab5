//
//  PrimaryViewController.swift
//  lab5
//
//  Created by Sarvar Saidazov on 27.03.2024.
//

import UIKit

class PrimaryViewController: UIViewController {
    
    private let btn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemGreen
        btn.setTitle("Sign IN", for: .normal)
        btn.setTitleColor(.yellow, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flupify"
        view.backgroundColor = .systemMint
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btn.frame = CGRect(
            x: 20,
            y: view.height - 50-view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50)
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completion = {[weak self] success in
            DispatchQueue.main.async {
                self?.singIn(success:success)
            }
            
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func singIn(success:Bool) {
        guard success else {
            let errorAlert = UIAlertController(title: "ERROR", message: "404 SIGN ERROR", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            present(errorAlert,animated: true)
            return
        }
        
        let mainAppTabbarVC = TabBarViewController()
        mainAppTabbarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabbarVC,animated: true)
    }
    
    
}
