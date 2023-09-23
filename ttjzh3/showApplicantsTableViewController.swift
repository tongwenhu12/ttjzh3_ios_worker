//
//  showApplicantsTableViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-19.
//

import UIKit
import FirebaseFirestore

class showApplicantsTableViewController: UITableViewController {
    
    var yyy:String?
  
    var dataArray = [String]()
    
   
    @IBAction func close2(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Create a reference to your Firestore document
            let db = Firestore.firestore()
            
//*****20230305********  working on below code
            
            let collectionRef = db.collection("jobss")

            // Set the field and its value to search for
            let fieldName = "job_code"
            let fieldValue = yyy
            print("0505")
            print(yyy!)
            

            // Create a query to search for the document that matches the field value
            let query = collectionRef.whereField(fieldName, isEqualTo: fieldValue!)

            // Get the documents that match the query
            query.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in querySnapshot!.documents {
                        // Retrieve the document ID
                        let documentId = document.documentID
                        
                        print("0808")
                        print(documentId)
                        
                        let documentRef = db.collection("jobss").document(documentId)
                        
                        // Download the array field
                        documentRef.getDocument { (document, error) in
                            if let error = error {
                                print("Error getting document: \(error)")
                            } else {
                                // Get the data as an array of strings
//***************************20230629below
                                self.dataArray = document?.data()?["applicants_v2"] as? [String] ?? []
                                
                                // Reload the table view
                                self.tableView.reloadData()
                            }
                        }
                        
                    }
                }
            }

//*****20230305********  working on above code
            
            
            
//            let documentRef = db.collection("jobss").document(yyy!)
//
//            // Download the array field
//            documentRef.getDocument { (document, error) in
//                if let error = error {
//                    print("Error getting document: \(error)")
//                } else {
//                    // Get the data as an array of strings
//                    self.dataArray = document?.data()?["applicants"] as? [String] ?? []
//
//                    // Reload the table view
//                    self.tableView.reloadData()
//                }
//            }
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArray.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Configure the cell with data from the array
            let dataItem = dataArray[indexPath.row]
            cell.textLabel?.text = dataItem
            
            return cell
        }
    
 
    
    
    }


