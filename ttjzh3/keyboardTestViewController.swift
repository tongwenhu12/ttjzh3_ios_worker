//
//  keyboardTestViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-04-23.
//

import UIKit
import IQKeyboardManagerSwift


class keyboardTestViewController: UIViewController {
    
   
    @IBOutlet weak var lastRow2: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

      //  IQKeyboardManager.shared.keyboardDistanceFromTextField = keyboardTestView.constant

    }
    

    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
