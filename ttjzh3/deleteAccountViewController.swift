//
//  deleteAccountViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-04-25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class deleteAccountViewController: UIViewController {
    
    
    @IBOutlet weak var confirmDeleteAccount: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func close10(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        
        
      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
      nextViewController.modalPresentationStyle = .fullScreen
      self.present(nextViewController, animated: true, completion: nil)
        
    
        
    }
   
    
    @IBAction func confirmDeleteAccount(_ sender: Any) {
        
//    //following code: sign user out and go back to the first page
//
//        do {
//                   try Auth.auth().signOut()
//
//                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//
//                   nextViewController.modalPresentationStyle = .fullScreen
//                   self.present(nextViewController, animated: true, completion: nil)
//
//               }catch let signOutError as NSError{
//                   print ("Error signing out:%@", signOutError)
//               }
//     //above code: sign user out and go back to the first page
        
     //following code: delete user in firebase
        
        let user = Auth.auth().currentUser
        var user2:String? = Auth.auth().currentUser?.email
        
        user?.delete { error in
          if let error = error {
            // An error happened.
          } else {
            // Account deleted.
          }
        }
     //above code: delete user in firebase
        
     //following code: delete user's corresponding firestore document
        
        let db = Firestore.firestore()
        let docRef = db.collection("nannies").document(user2!)

        docRef.delete() { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                
                let alertController = UIAlertController(title: "", message: "你的个人账户已经被删除。以后可以重新注册并使用天天家政APP。", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "请点击此处关闭弹窗。", style: .default) { (action) in
                    
//                               self.dismiss(animated: true, completion: nil)
                       
                }
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
     // above code: delete user's corresponding firestore document. //.isEnabled = false
        
        
        
        confirmDeleteAccount.isEnabled = false
        
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "username")
    }
    
 

}
