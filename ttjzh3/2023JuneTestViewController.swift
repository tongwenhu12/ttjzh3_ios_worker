//
//  2023JuneTestViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-06-10.
//

import UIKit
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage



class _023JuneTestViewController: UIViewController {
    
    private let storage = Storage.storage().reference()
    let db = Firestore.firestore()
    var nanny:String? = Auth.auth().currentUser?.email
    var urlString2:String?
    var firebaseData:String?
    
    
    
    @IBOutlet weak var nannyPhoto5: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func task(_ sender: Any) {
        
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
                completion(firebaseData!)

                // Continue executing the rest of your code here
                print("Data retrieved from Firebase2:", firebaseData)            }
        }

        // Usage example
        fetchDataFromFirebase { firebaseData in
            // This closure will be executed when the data is retrieved from Firebase

            // Use the retrieved data
            print("Data retrieved from Firebase3:", firebaseData)

            // Continue executing the rest of your code here
            
            let url = URL(string: firebaseData)
            
            let task = URLSession.shared.dataTask(with: url!, completionHandler:  {data, _, error in
                   
                   guard let data = data, error == nil else{
                       return
                   }
                   
                   DispatchQueue.main.async {
                       let image  = UIImage(data:data)
                       self.nannyPhoto5.image = image
                   }
                
               })
               
               task.resume()
             
        }
      
    }
    
}
    
    

