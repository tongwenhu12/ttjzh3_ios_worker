//
//  resetPasswordViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-09-05.
//

import UIKit
import Firebase





class resetPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var resetPassword: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
     
     @IBAction func resetPassword(_ sender: Any) {
         
         let auth = Auth.auth()
         auth.sendPasswordReset(withEmail: email.text!){(error) in
             
             if let error = error {
                 
                 let alertController = UIAlertController(title: "注意", message: "没有成功。", preferredStyle: .alert)
                 let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                     
     //                self.dismiss(animated: true, completion: nil)
                     
                 }
                 alertController.addAction(dismissAction)
                 self.present(alertController, animated: true, completion: nil)
                 
                 
             }
             
             
             let alertController = UIAlertController(title: "注意", message: "成功。", preferredStyle: .alert)
             let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                 
 //                self.dismiss(animated: true, completion: nil)
                 
             }
             alertController.addAction(dismissAction)
             self.present(alertController, animated: true, completion: nil)
             
             
         }
         
     }
     

    
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
