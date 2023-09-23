//
//  registerViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-11.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import RealmSwift
import IQKeyboardManagerSwift


//oooooooooooooooooooooooooo下面几行代码是用于realm本地存储
class MyObject3: Object {
    @objc dynamic var nanny_code = ""
    @objc dynamic var nackName = ""
 
}



class registerViewController: UIViewController, UITextFieldDelegate{
    
    let db = Firestore.firestore()
    
   
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
// *******BELOW ADDED ON 2023-04-13
    
    
    
    
    
    
// *******ABOVE ADDED ON 2023-04-13
    
    
    
    
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email1 = emailTextField.text,let password1 = passwordTextField.text{

        Auth.auth().createUser(withEmail: email1, password: password1) { authResult, error in
            if let e = error{
 
                print (e)
                
//start ****************** 和下面的 extension 一起，产生 toast message
                                
                self.showToast1(message: "请使用电子邮箱作为用户名，密码必须至少六位数字或英文字母。", font: .systemFont(ofSize: 12.0))
               
//end *******************
  
            }else{
                
                self.performSegue(withIdentifier: "gotoProfileViewController1", sender: self)
                
                
//start ********** 新客户注册完毕后，专门做一个document, 并将 level 起始数值设为 零
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                let formattedDate = formatter.string(from: Date())
                
                
                let nanny:String? = Auth.auth().currentUser?.email
                self.db.collection("nannies")
                    .document(nanny!)
                    // .updateData([
                               .setData([
                            
                            "date_registered":formattedDate,
                            "level":0,
                            "nanny_code":"",
                            "customer_comment":[],
                            "ttjzh_comment":[],
                            "nanny's email":nanny,
                            "viewed":[],
                            "interviewed":[],
                            "hired":[],
                            "rejected":[]
                            
                            
                            
                        ]) { (error) in
                            if let e = error{
                                
                                print(e)
                            }else{
                                
               
                                print ("Saved!")

                            }
                        }
                   

//end *************
                
// *******2023-04-13 working below
                                           
       let defaults = UserDefaults.standard
       defaults.set(email1, forKey: "username") // Set a string value for key "username"

                                       
                                           
// *******2023-04-13 working above
                                           
                
                
                

            }

          }

        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        emailTextField.delegate = self // Set the text field's delegate to self
             }

            // UITextFieldDelegate method
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                // Convert the replacement string to lowercase
                let lowercaseString = string.lowercased()

                // Replace the text in the text field with the lowercase string
                textField.text?.replaceSubrange(Range(range, in: textField.text!)!, with: lowercaseString)

                // Return false to prevent the original text change
                return false
            

        // Do any additional setup after loading the view.
    }
    

    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
 

}


extension UIViewController {

func showToast1(message : String, font: UIFont) {

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
