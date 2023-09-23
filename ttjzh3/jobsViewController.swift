//
//  jobsViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-11.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore


class jobsViewController: UIViewController {
    
    
    @IBOutlet weak var jobList: UITableView!
    
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
//****
    var messageSender9 = ""
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.jobList.rowHeight = UITableView.automaticDimension
                self.jobList.estimatedRowHeight = 44
         

                jobList.dataSource = self
                
                jobList.register(UINib(nibName: "MessageCell222", bundle: nil), forCellReuseIdentifier: "ReusableCell")
           
                //  below code (with below extension) let each cell become clickable
                jobList.delegate = self
                
            
                loadMessages()

    }
    
    
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
  
    
    func loadMessages(){
        
         db.collection("jobss")
            .whereField("level", isEqualTo: 5)
//            .order(by: "datefield")
            .addSnapshotListener { (querySnapshot, error ) in
             
             self.messages = []
             if let e = error{
                 print (e)
             }else{
                 
                 if let snapshotDocuments =  querySnapshot?.documents
                 {
                 
                     for doc in snapshotDocuments
                     {
                         let data = doc.data()
                         
                        
                         

                         if let messageSender1 = data["location"] as? String,
                            let messageSender2 = data["main_task"] as? String,
                            let messageSender3 = data["days_week"] as? String,
                            let messageSender4 = data["family"] as? String,
                            let messageSender5 = data["how_long"] as? String,
                            let messageSender6 = data["nanny_type"] as? String,
                            let messageSender7 = data["pet"] as? String,
                            let messageSender8 = data["salary"] as? String,
                            let messageSender9 = data["employer's email"] as? String,
                            let messageSender11 = data["start_date"] as? String,
                            let messageSender10 = data["job_code"] as? String
                                
                                
                                                    {
                             let newMessage = Message(jobDetail:
                                                        
                                                  messageSender10 + "\n" + // 暂时取消“工作编号” 标题
                                     "工作地点：" + messageSender1 + "\n" +
                                     "计划开始上班时间：" + messageSender11 + "\n" +
                                                  messageSender2 + "\n" + // 已经自带标题
                                  "每周工作天数：" + messageSender3 + "\n" +
                                  "雇主家庭成员：" + messageSender4 + "\n" +
                                  "计划雇佣期限：" + messageSender5 + "\n" +
                                     "家政种类：" + messageSender6 + "\n" +
                               "雇主家是否有宠物：" + messageSender7 + "\n" +
                                 "计划支付的工资：" + messageSender8 )
                             
                             
//*****20230305*************
//                             let newMessage = Message(jobDetail:messageSender9 + "\n" + messageSender1 + "\n"
//                             + messageSender2 + "\n" + messageSender3 + "\n"
//                             + messageSender4 + "\n" + messageSender5 + "\n"
//                             + messageSender6 + "\n" + messageSender7 + "\n"
//                             + messageSender8 )

                           self.messages.append(newMessage)
                             
                             DispatchQueue.main.async {
                                 self.jobList.reloadData()
                                 let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                 self.jobList.scrollToRow(at: indexPath, at: .top, animated: true)
                             }
                         }
   
                     }
             }
         }
         
       }

     }


}

extension jobsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        as!MessageCell222
        cell.label.text = messages[indexPath.row].jobDetail
        
        return cell
    }
}

 

//下面选择tableview里的某项，执行code里面的程序(比如print)

extension jobsViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let xxx = indexPath.row
        print(xxx)
        
        
        print (messages[xxx])
        
        
        
        
        
//***** result1 从 messages[xxx].jobDetail 里面截取第一部分 - 雇主email
//***** result2 从 messages[xxx].jobDetail 里面截取其余部分 - 工作详细内容
        
        let str = messages[xxx].jobDetail
        
        let substrings1 = str.components(separatedBy: "\n")
        let result1 = substrings1[0]
        
        
        let substrings2 = str.split(separator: "\n")
        let result2 = substrings2.dropFirst().joined(separator: "\n")
        

        
         
//***** 以下程序展示如何从string中截取部分substring
//        let str = "John-Doe-Smith"
//        let substrings = str.split(separator: "-") // ["John", "Doe", "Smith"]
//        let result = substrings.dropFirst().joined(separator: "-") // "Doe-Smith"
//
//
//        let str = "apple,banana,orange"
//        let substrings = str.components(separatedBy: ",") // ["apple", "banana", "orange"]
//        let firstSubstring = substrings[0] // "apple"
//        let secondSubstring = substrings[1] // "banana"
//        let thirdSubstring = substrings[2] // "orange"
 
//***** 以下程序打开下一个页面（ViewController),并将变量yyy里面的数据传送过去
      
        let controller = storyboard?.instantiateViewController(identifier: "selectJobViewController") as! selectJobViewController
        controller.text = messages[xxx].jobDetail
        
        controller.yyy = result1
   

        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
        
        print(9393)
        print(result1)
 
        
    }
}

