//
//  SecondViewController.swift
//  lab5
//
//  Created by Sarvar Saidazov on 21.03.2024.
//

import UIKit

class SecondViewController: UIViewController {


    @IBOutlet weak var recieveLabel: UILabel!
    
    var receivedText: String?

        override func viewDidLoad() {
            super.viewDidLoad()

            if let text = receivedText {
                recieveLabel.text = text
            }
        }

}
