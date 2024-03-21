//
//  ViewController.swift
//  lab5
//
//  Created by Sarvar Saidazov on 17.03.2024.
//

import UIKit


class ViewController: UIViewController {
    

    @IBOutlet weak var textLabel: UITextField!
    
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "segueToSecondViewController" {
               if let destinationVC = segue.destination as? SecondViewController {
                   destinationVC.receivedText = textLabel.text
               }
           }
       }
    
    
    @IBAction func goToSecondVCButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToSecondViewController", sender: self)
    }
    
}
