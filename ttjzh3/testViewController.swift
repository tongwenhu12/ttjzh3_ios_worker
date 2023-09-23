//
//  testViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-15.
//

import UIKit
import RealmSwift
import FirebaseFirestore





// 下面几行代码是用于realm本地存储
class MyObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}




class testViewController: UIViewController {
    
    let realm = try! Realm()

    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create a reference to your Firestore document
        let db = Firestore.firestore()
        let documentRef = db.collection("jobss").document("1616@1616.ca")

        // Download the array field
        documentRef.getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
            } else {
                // Get the data as an array of strings
                let dataArray = document?.data()?["applicants"] as? [String] ?? []
                
                // Store the data in a variable
                let yourVariable = dataArray
                
                // Use the data as needed
                print("Array downloaded: \(yourVariable)")
            }
        }
        
   
        
        
        
        
        
        
// Obtain a reference to the default Realm instance. You can do this by calling Realm() or try! Realm().
        
        let realm = try! Realm() // Get the default Realm instance

        
 // Create an instance of your data model, set its properties, and add it to the Realm.
        
        let myObject = MyObject()
        myObject.id = 1
        myObject.name = "BB"
        myObject.age = 2

        try! realm.write {
            realm.add(myObject)
        }
        
        
 // To retrieve data from a Realm database in Swift and print it out, you can use the Realm query language to fetch the data, and then loop through the results to print out the values.
        
        let realm2 = try! Realm() // Get the default Realm instance

        let objects = realm2.objects(MyObject.self) // Get all MyObject objects in the database

        for obj in objects {
            print("id: \(obj.id), name: \(obj.name), age: \(obj.age)")
        }

        
   
        
        
    }
  
    @IBAction func showAlertWithDismiss(_ sender: Any) {
     
                let alertController = UIAlertController(title: "My Alert", message: "This is an alert message.This is an alert message. This is an alert message. is an alert message. an alert message.", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
                alertController.addAction(dismissAction)
                present(alertController, animated: true, completion: nil)
  
    }
 

    @IBAction func printDate(_ sender: Any) {
        
        let currentDate = Date()
        print(currentDate)
        
        print("******")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = formatter.string(from: Date())
        print(formattedDate)
        
        print("******")
        
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let formattedDate2 = formatter.string(from: Date())
        print(formattedDate2)
    }

  
    
    @IBAction func showApplicants(_ sender: Any) {
        
    }
    
 
    
    @IBAction func userDefaultDeleteKey(_ sender: Any) {
        
        // Remove a value for a given key from UserDefaults
        UserDefaults.standard.removeObject(forKey: "myKey")

        // Synchronize UserDefaults to save changes
        UserDefaults.standard.synchronize()

    }
    
    
    @IBAction func realmDeleteAll(_ sender: Any) {
        
       
        // Delete all objects from the database
        try! realm.write {
            realm.deleteAll()
        }

        
    }

  
}











