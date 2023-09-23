//
//  t4TableViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-19.
//

import UIKit
import FirebaseFirestore




class t4TableViewController: UITableViewController {

    var dataArray = [String]()
        
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
                    self.dataArray = document?.data()?["applicants"] as? [String] ?? []
                    
                    // Reload the table view
                    self.tableView.reloadData()
                }
            }
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



