//
//  profileViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-11.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import RealmSwift




class profileViewController: UIViewController {
    
    let db = Firestore.firestore()
    var nanny:String? = Auth.auth().currentUser?.email
    var nanny_summary:String?
    var nanny_code:String?
    var nanny_code9:String?
    
    let defaults = UserDefaults.standard
    
    
    
    @IBOutlet weak var tt_name: UITextField!
    @IBOutlet weak var tt_telephone: UITextField!
    @IBOutlet weak var tt_location: UITextField!
    @IBOutlet weak var tt_nackName: UITextField! //***
    @IBOutlet weak var tt_status: UITextField!   //***
    @IBOutlet weak var tt_comeFrom: UITextField!
    @IBOutlet weak var tt_mandarin: UITextField!
    @IBOutlet weak var tt_english3: UITextField! //***
    
    @IBOutlet weak var tt_cantonese: UITextField!
    @IBOutlet weak var tt_driving: UITextField!
    @IBOutlet weak var tt_live_in: UITextField!
    @IBOutlet weak var tt_cooking: UITextField!
    @IBOutlet weak var tt_childcare: UITextField!
    @IBOutlet weak var tt_cleaning: UITextField!
    @IBOutlet weak var tt_otherSkills: UITextView! //***
    @IBOutlet weak var tt_certificate: UITextField!
    
    
    @IBOutlet weak var applyJobButton: UIButton!
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
                 
               db.collection("nannies").document(self.nanny!).getDocument { (document, error) in
                   if let document = document, document.exists {
                       let data = document.data()
                       
                       let text = data!["name"] as? String ?? ""
                       let text1 = data!["telephone"] as? String ?? ""
                       let text2 = data!["location"] as? String ?? ""
                       let text3 = data!["nackName"] as? String ?? ""
                       let text4 = data!["status"] as? String ?? ""
                       let text5 = data!["comeFrom"] as? String ?? ""
                       let text6 = data!["mandarin"] as? String ?? ""
                       let text7 = data!["english3"] as? String ?? ""
                       let text8 = data!["cantonese"] as? String ?? ""
                       let text9 = data!["driving"] as? String ?? ""
                       let text10 = data!["live_in"] as? String ?? ""
                       let text11 = data!["cooking"] as? String ?? ""
                       let text12 = data!["childcare"] as? String ?? ""
                       let text13 = data!["cleaning"] as? String ?? ""
                       let text14 = data!["otherSkills"] as? String ?? ""
                       let text15 = data!["certificate"] as? String ?? ""
                       
                       self.nanny_code9 = data!["nanny_code"] as? String ?? ""
                       
                       self.tt_name.text = text
                       self.tt_telephone.text = text1
                       self.tt_location.text = text2
                       self.tt_nackName.text = text3
                       self.tt_status.text = text4
                       self.tt_comeFrom.text = text5
                       self.tt_mandarin.text = text6
                       self.tt_english3.text = text7
                       self.tt_cantonese.text = text8
                       self.tt_driving.text = text9
                       self.tt_live_in.text = text10
                       self.tt_cooking.text = text11
                       self.tt_childcare.text = text12
                       self.tt_cleaning.text = text13
                       self.tt_otherSkills.text = text14
                       self.tt_certificate.text = text15
                       
                       

                   } else {
                       print("Document does not exist")
                   }
               }

//******20230420 working on below
        
        if (tt_name.text == "" || tt_nackName.text == "" || tt_telephone.text == "" ){
            
            applyJobButton.isEnabled = false
            
        } else {
            applyJobButton.isEnabled = true
            
        }
        
             
//******20230420 working on above
      
       
     
        
        
    }
    

  
    
    

    @IBAction func uploadModify(_ sender: Any) {
        
        if ( self.nanny_code9 == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请联系天天家政在系统中设置员工号码才能进行下一步申请工作", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
                //                self.dismiss(animated: true, completion: nil)
                
                self.applyJobButton.isEnabled = false
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
    
            
        }
        
        
        if (tt_name.text == "" || tt_nackName.text == "" || tt_telephone.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：姓名，称呼和联系电话 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        if (tt_location.text == "" || tt_status.text == "" || tt_comeFrom.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：居住位置，身份和哪里人 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if (tt_mandarin.text == "" || tt_english3.text == "" || tt_cantonese.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：普通话，英语和广东话能力 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if (tt_driving.text == "" || tt_live_in.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：是否会开车，是否可以住家 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if (tt_cooking.text == "" || tt_childcare.text == "" || tt_cleaning.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：做饭，照顾儿童和家居清洁经验 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        


        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate = formatter.string(from: Date())
        
        if let name = tt_name.text,
           let telephone = tt_telephone.text,
           let location = tt_location.text,
           let nackName = tt_nackName.text,
           let comeFrom = tt_comeFrom.text,
           let status = tt_status.text,
           let mandarin = tt_mandarin.text,
           let english3 = tt_english3.text,
           let cantonese = tt_cantonese.text,
           let driving = tt_driving.text,
           let live_in = tt_live_in.text,
           let cooking = tt_cooking.text,
           let childcare = tt_childcare.text,
           let cleaning = tt_cleaning.text,
           let otherSkills = tt_otherSkills.text,
           let certificate = tt_certificate.text,
             
           let messageSender = Auth.auth().currentUser?.email{
            
                    nanny_summary = "姓名：" + name + " 称呼：" + nackName +
                                    " 哪里人：" + comeFrom + " 电话：" + telephone +
                                    " 身份：" + status + " 居住位置：" + location +
                                    " 是否住家：" + live_in + " 驾驶技能：" + driving +
                                    " 普通话：" + mandarin + " 英语：" + english3 +
                                    " 广东话：" + cantonese + " 做饭经验：" + cooking +
                                    " 清洁经验：" + cleaning + " 护理经验：" + childcare +
                                    " 证书：" + certificate + " 其它技能：" + otherSkills
            
            
               
                     db.collection("nannies")
                       .document(messageSender)
                       .updateData([
           //                .setData([
                       
                       "name":name,
                       "telephone":telephone,
                       "location":location,
                       
                       "nackName":nackName,
                       "comeFrom":comeFrom,
                       "status":status,
                       "mandarin":mandarin,
                       "english3":english3,
                       "cantonese":cantonese,
                       "driving":driving,
                       "live_in":live_in,
                       "cooking":cooking,
                       "childcare":childcare,
                       "cleaning":cleaning,
                       "otherSkills":otherSkills,
                       "certificate":certificate,
                       "nanny_summary":nanny_summary ?? "",
                       
                       "date_updated":formattedDate
                       
  
                   ]) { (error) in
                       if let e = error{
                            print(e)
                       }else{
                           print ("Saved!")
                           
//*****************
                           UserDefaults.standard.set(self.tt_nackName.text,forKey: "nackName111")
                 
                           let alertController = UIAlertController(title: "", message: "你的个人信息已经成功上传，修改或确认。", preferredStyle: .alert)
                           let dismissAction = UIAlertAction(title: "请点击此处关闭弹窗。", style: .default) { (action) in
                               
//                               self.dismiss(animated: true, completion: nil)
                                  
                           }
                           alertController.addAction(dismissAction)
                           self.present(alertController, animated: true, completion: nil)
                     
                           
                       }
                   }
                   
               }
        
 
// oooooooooooooooooooooooooo   modify realm 本地存储    以下待修改 20230219
        let realm = try! Realm()
        
        let myObject = MyObject3()
        myObject.nackName = tt_nackName.text!
        
        realm.beginWrite()
        realm.add(myObject)
        try!realm.commitWrite()

 // oooooooooooooooooooooooooo   modify realm 本地存储 以上待修改 20230219
        
//******20230420 working on below
        applyJobButton.isEnabled = true
        
//******20230420 working on above
        
        
        
    }
    
 
    
    @IBAction func applyJob(_ sender: Any) {
 
        
        if (tt_name.text == "" || tt_nackName.text == "" || tt_telephone.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：姓名，称呼和联系电话 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        if (tt_location.text == "" || tt_status.text == "" || tt_comeFrom.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：居住位置，身份和哪里人 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if (tt_mandarin.text == "" || tt_english3.text == "" || tt_cantonese.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：普通话，英语和广东话能力 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if (tt_driving.text == "" || tt_live_in.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：是否会开车，是否可以住家 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
        
        
        if (tt_cooking.text == "" || tt_childcare.text == "" || tt_cleaning.text == "" ){
            
            let alertController = UIAlertController(title: "注意", message: "请检查：做饭，照顾儿童和家居清洁经验 - 需要填写。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                
//                self.dismiss(animated: true, completion: nil)
                
            }
            alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
        }
 
        
        
        self.performSegue(withIdentifier: "gotoJobsViewController", sender: self)
  
    }
 
    
    
    
    
    
   
    @IBAction func close(_ sender: Any) {
 
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
        
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
    
    
    
    @IBAction func goToDeleteAccount(_ sender: Any) {
        
        
        // Declare Alert
                let dialogMessage = UIAlertController(title: "请确认", message: "是否真的要从系统中删除自己的账号?", preferredStyle: .alert)

                // Create OK button with action handler
                let ok = UIAlertAction(title: "确认删除账号", style: .default, handler: { (action) -> Void in
                    
                    
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

                               
                               
//***************************************************************************以下一行代码及最下面相关function可能没有用
                               self.showToast2(message: "您的账户已经被删除。", font: .systemFont(ofSize: 12.0))
//---------------------------------------------------------------------------以上一行代码及最下面相关function可能没有用
                               

                           }
                       }
                       
                    // above code: delete user's corresponding firestore document. //.isEnabled = false
                    
//  follwoing codes return to MainActivity
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    
                    nextViewController.modalPresentationStyle = .fullScreen
                    self.present(nextViewController, animated: true, completion: nil)
                    
//  above codes return to MainActivity
                    
                    
                    
                    
                     
                })

                // Create Cancel button with action handlder
                let cancel = UIAlertAction(title: "不删除账号", style: .cancel) { (action) -> Void in
                    print("Cancel button click...")
                }

                //Add OK and Cancel button to dialog message
                dialogMessage.addAction(ok)
                dialogMessage.addAction(cancel)

                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
        
        
        
        
        
        
//        let controller = storyboard?.instantiateViewController(identifier: "deleteAccountViewController") as! deleteAccountViewController
//
//        controller.modalPresentationStyle = .fullScreen
//
//        present(controller, animated: true, completion: nil)
//
        
    }
    
    
    func showToast2(message : String, font: UIFont) {

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
