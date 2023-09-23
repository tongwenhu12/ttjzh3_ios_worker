//
//  loginViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-11.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


class loginViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.delegate = self // Set the text field's delegate to self
        
     
        
// *******2023-04-13 working below
                                                   
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "username")
        self.emailTextfield.text = username
                                                   
// *******2023-04-13 working above
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                  // Convert the replacement string to lowercase
                  let lowercaseString = string.lowercased()

                  // Replace the text in the text field with the lowercase string
                  textField.text?.replaceSubrange(Range(range, in: textField.text!)!, with: lowercaseString)

                  // Return false to prevent the original text change
                  return false
              

          // Do any additional setup after loading the view.
      }
    
    
    
    

    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailTextfield.text,let password = passwordTextfield.text{

                  Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                      if let e = error {
                          
                          
//***************
                          self.showToast(message: "请输入电子邮箱和密码。如果您是新用户，请返回，去注册页面。", font: .systemFont(ofSize: 12.0))

 //***************
                          
                    print(e)
                      }else{
              
                         self.performSegue(withIdentifier: "gotoProfileViewController2", sender: self)
 
                      }
          
              }

         }

    }
    
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }

}


extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 250, height: 50))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.numberOfLines = 0
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 10.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
 }
    
}

