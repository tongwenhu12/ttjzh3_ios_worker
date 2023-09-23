//
//  selectJobViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-12.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import RealmSwift



//+++++++++++ create RealmSwift data object
class MyObject1: Object {
     @objc dynamic var job_code = ""
 }


class selectJobViewController: UIViewController {

    var text:String?
    var yyy:String?
    var zzz:String?
    var xxx:String?
    

    @IBOutlet weak var label: UILabel!
    
    let db = Firestore.firestore()
  
    let Sender = Auth.auth().currentUser?.email

    override func viewDidLoad() {
        super.viewDidLoad()

        if text != nil {
                    label.text = text
            }
        


    }
    
    

    @IBAction func confirmJob(_ sender: Any) {
        
        
        let realm = try! Realm()
        
        let numberToFind = yyy!  //  yyy！ 为 job_code, 经测试确认
        
        
        let results = realm.objects(MyObject1.self).filter("job_code = %@", numberToFind)
  
        
        
 
        if results.count > 0 {
            print("You have applied this job already!")
            
            let alertController = UIAlertController(title: "注意", message: "你已经申请过了这份工作，不需要重复申请。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
            
                              } else {
 
 //++++++++++++++++20230305 working on below
                                  
                let controller = storyboard?.instantiateViewController(identifier: "confirmationViewController") as! confirmationViewController
                                  
                    controller.aaaa = yyy!
                                  
                    
                                  
           //         controller.modalPresentationStyle = .popover
                                  
                    controller.modalPresentationStyle = .fullScreen
                    present(controller, animated: true, completion: nil)
                                  
 
        
        }
        

        
    }
    

    
 
    
    
    
    
    @IBAction func viewApplicants(_ sender: Any) {
 
        
        let controller = storyboard?.instantiateViewController(identifier: "showApplicantsTableViewController") as! showApplicantsTableViewController
 
        controller.yyy = yyy
        
//        controller.modalPresentationStyle = .fullScreen
        controller.modalPresentationStyle = .fullScreen
        
        
        present(controller, animated: true, completion: nil)

     }
    
    
    
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
   
    
    do {
               try Auth.auth().signOut()
               
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
               
               nextViewController.modalPresentationStyle = .fullScreen
               self.present(nextViewController, animated: true, completion: nil)

           }catch let signOutError as NSError{
               print ("Error signing out:%@", signOutError)
           }
    
    }
    
    

}
