//
//  previewProfileViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-06-08.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage




class previewProfileViewController: UIViewController {
    
    private let storage = Storage.storage().reference()
    let db = Firestore.firestore()
    var nanny:String? = Auth.auth().currentUser?.email
    var urlString2:String?
    var firebaseData:String?
    
  
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    

    @IBOutlet weak var pp_nannyPhoto: UIImageView!
    
    @IBOutlet weak var pp_name: UITextField!
    @IBOutlet weak var pp_telephone: UITextField!
    @IBOutlet weak var pp_location: UITextField!
    @IBOutlet weak var pp_nackName: UITextField! //***
    @IBOutlet weak var pp_status: UITextField!   //***
    @IBOutlet weak var pp_comeFrom: UITextField!
    @IBOutlet weak var pp_mandarin: UITextField!
    @IBOutlet weak var pp_english3: UITextField! //***
    
    @IBOutlet weak var pp_certificate3: UITextField!
    @IBOutlet weak var pp_cantonese: UITextField!
    @IBOutlet weak var pp_driving: UITextField!
    @IBOutlet weak var pp_live_in: UITextField!
    @IBOutlet weak var pp_cooking: UITextField!
    @IBOutlet weak var pp_childcare: UITextField!
    @IBOutlet weak var pp_cleaning: UITextField!
   
    @IBOutlet weak var pp_otherSkills3: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        spinner.startAnimating()

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
                
                
                self.pp_name.text = text
                self.pp_telephone.text = text1
                self.pp_location.text = text2
                self.pp_nackName.text = text3
 //             self.pp_status.text = text4
                self.pp_comeFrom.text = text5
                self.pp_mandarin.text = text6
                self.pp_english3.text = text7
                self.pp_cantonese.text = text8
                self.pp_driving.text = text9
                self.pp_live_in.text = text10
                self.pp_cooking.text = text11
                self.pp_childcare.text = text12
                self.pp_cleaning.text = text13
                self.pp_otherSkills3.text = text14
                self.pp_certificate3.text = text15
                
                

            } else {
                print("Document does not exist")
            }
        }
        
        
        func fetchDataFromFirebase(completion: @escaping (String) -> Void) {
            let group = DispatchGroup()
            
            group.enter()
            // Fetch data from Firebase
                db.collection("nannies").document(self.nanny!).getDocument { [self] (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    
                    firebaseData = data!["photo1"] as? String
                                   
                    print("Data retrieved from Firebase1:", firebaseData)

                } else {
                    print("Document does not exist")
                }
           
     
                group.leave()
            }

            group.notify(queue: .main) { [self] in
                // Data has been retrieved from Firebase
                completion(firebaseData ?? "https://firebasestorage.googleapis.com/v0/b/tiantianjiazheng2021.appspot.com/o/images%2FPNG_no_inage_available.png?alt=media&token=85b91eb6-2f61-4121-9d7c-34889f044277")

                // Continue executing the rest of your code here
                print("Data retrieved from Firebase2:", firebaseData)            }
        }

        // Usage example
        fetchDataFromFirebase { firebaseData in
            // This closure will be executed when the data is retrieved from Firebase

            // Use the retrieved data
            print("Data retrieved from Firebase3:", firebaseData)

            // Continue executing the rest of your code here"
            
            let url = URL(string: firebaseData)
            
            let task = URLSession.shared.dataTask(with: url!  , completionHandler:  {data, _, error in
                   
                   guard let data = data, error == nil else{
                       return
                   }
                   
                   DispatchQueue.main.async {
                       let image  = UIImage(data:data)
                       self.pp_nannyPhoto.image = image
                       
                       
                       
                       self.spinner.hidesWhenStopped = true
                       self.spinner.stopAnimating()
                       
                   }
                
               })
               
               task.resume()
             
        }
      
        
        
        
        
        
        
        
        
        
////*********** 20230609 below codes show nanny photo
//
//        pp_nannyPhoto.contentMode = .scaleAspectFit
//
//
//    //********************************************************************************************
//
//        db.collection("nannies").document(self.nanny!).getDocument { (document, error) in
//            if let document = document, document.exists {
//                let data = document.data()
//
//                self.urlString2 = data!["photo1"] as? String ?? ""
//
//               } else {
//                print("Document does not exist")
//            }
//        }
//
//
//    //--------------------------------------------------------------------------------------------
//
//
//
//
//        guard
//
////            let urlString = UserDefaults.standard.value(forKey: "url") as? String,
//
//
//                let url = URL(string: urlString2!)
//
//        else {
//            return
//        }
//
//     let task = URLSession.shared.dataTask(with: url, completionHandler:  {data, _, error in
//
//            guard let data = data, error == nil else{
//                return
//            }
//
//            DispatchQueue.main.async {
//                let image  = UIImage(data:data)
//                self.pp_nannyPhoto.image = image
//            }
//
//        })
//
//        task.resume()
//
////----------- 20230609 above codes show nanny photo
 
        
    }
    

    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        
    }


}
