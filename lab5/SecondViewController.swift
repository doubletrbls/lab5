//
//  SecondViewController.swift
//  lab5
//
//  Created by Sarvar Saidazov on 21.03.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    var receivedMessage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let messageRec = receivedMessage {
                    message.text = messageRec
                }
    }

}
