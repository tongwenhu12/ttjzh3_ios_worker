//
//  confirmationViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-03-05.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import RealmSwift


class confirmationViewController: UIViewController {
    
    
    var aaaa:String?   // 接收从前页传过来的 job_code 数据
    var xxx:String?    // 用于在本页存储 employer's email 数据
    var yyy:String?
     
    let db = Firestore.firestore()
    let Sender = Auth.auth().currentUser?.email
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                   let myCollection = db.collection("jobss")
                   let query = myCollection.whereField("job_code", isEqualTo: aaaa!)
                   print("181818 aaaa")
                   print( aaaa!)
            
                   query.getDocuments() { (querySnapshot, err) in
                       if let err = err {
                           print("Error getting documents: \(err)")
                       } else {
                           for document in querySnapshot!.documents {
                              
                               self.xxx = document.documentID
                                
                           }
                           
                           
                           print( self.xxx!) // self.xxx! 为employer's email 经测试确认

                       }

                       
                   }
  
    }
    

    
    @IBAction func confirm(_ sender: Any) {
 
    let realm = try! Realm()
                     
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    let formattedDate = formatter.string(from: Date())
    print(formattedDate)
    
    //*************************为方便以后修改保存（下面）
        
    //         print (yyy!)
    //         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    //*************************为方便以后修改保存（上面）
    
      

      let nackname222 = UserDefaults.standard.string(forKey: "nackName111")
                        
    db.collection("jobss")
                         
//              .document("0303bem2@1.ca")
                .document(self.xxx!)
                .updateData([
              
                    "applicants":FieldValue.arrayUnion([Sender!]),
                    "applicants_v2":FieldValue.arrayUnion([nackname222!+"，申请时间："+formattedDate+"，系统：Apple"])
                    

        ]) { (error) in
            if let e = error{
                
                print(e)
                
            }else{
                

                let realm = try! Realm()
                let myObject = MyObject1()
                
                myObject.job_code = self.aaaa!
                try! realm.write {
                    realm.add(myObject)
                }
                
                
                print ("Saved!!!")
                print (self.aaaa!)
                
                
            }
        }
    

//*************************   20230922 working on below
        
        
        
        let collectionReference = db.collection("mail")

        // Create a dictionary representing the map (key-value pairs)
        let mapData: [String: Any] = [
            "subject": "*天天家政新保姆应聘*",
            "text": "您好，有新的保姆应聘。请打开天天家政APP查看详细内容。谢谢。"
        ]

        // Create a dictionary with the string and map
        let data: [String: Any] = [
            "to": self.xxx!,
            "message": mapData
        ]

        // Add the data to a new document with an auto-generated ID
        collectionReference.addDocument(data: data) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully with auto-generated ID!")
            }
        }
        
        
 
        
        

//        let documentReference = db.collection("mail").document(self.xxx!)
//
//
//        // Create a dictionary representing the map (key-value pairs)
//        let mapData: [String: Any] = [
//            "subject": "天天家政新保姆应聘",
//            "text": "您好，有新的保姆应聘。请打开天天家政APP查看详细内容。谢谢。"
//        ]
//
//        // Create a dictionary with the string and map
//        let data: [String: Any] = [
//            "to": self.xxx!,
//            "message": mapData
//        ]
//
//        // Update the document with the data (string and map)
//        documentReference.setData(data, merge: true) { error in
//            if let error = error {
//                print("Error updating document: \(error)")
//            } else {
//                print("Document updated successfully!")
//            }
//        }

 
        
//--------------------------   20230922 working on above
        
        
        
            let alertController = UIAlertController(title: "成功！", message: "你已经成功申请过了这份工作，天天家政和雇主审阅您的个人资料后，如果觉得满意，会跟您联系。", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "请点击此处返回", style: .default) { (action) in
                       self.dismiss(animated: true, completion: nil)
                          }
                 alertController.addAction(dismissAction)
            present(alertController, animated: true, completion: nil)
  
        
    }
  

    
    @IBAction func close(_ sender: Any) {
      
            dismiss(animated: true, completion: nil)
       
    }
 
    
}
