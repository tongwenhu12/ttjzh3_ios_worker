//
//  ViewController.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-02-11.
//

import UIKit
import SafariServices




class ViewController: UIViewController {
    
    
    @IBOutlet weak var checkRecentJobs: UIButton!
    
    @IBOutlet weak var training: UIButton!
    @IBOutlet weak var feedback: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var logIn: UIButton!
    
    @IBOutlet weak var appManual: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    @IBAction func seeJobs(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://www.torontojiazheng.com/job_display.php")!)
                present(vc,animated: true)
        
    }
    
    
    @IBAction func training(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://www.torontojiazheng.com/training_2021.html")!)
                present(vc,animated: true)
        
        
    }
    
    
    @IBAction func nanny_feedback(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://www.torontojiazheng.com/nanny_feedback.php")!)
                present(vc,animated: true)
    }
    

    @IBAction func publicNotice(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://torontojiazheng.com/app_public_notice.htm")!)
                present(vc,animated: true)
    }
    
    
    @IBAction func nannyReferral(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://torontojiazheng.com/nanny_referral.htm")!)
                present(vc,animated: true)
    }
    
    @IBAction func employerReferral(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://torontojiazheng.com/employer_referral.htm")!)
                present(vc,animated: true)
    }
    
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "gotoRegisterViewController", sender: self)
        
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "gotoLoginViewController", sender: self)
        
        
    }
    
    
    
    
    @IBAction func appManual(_ sender: Any) {
        
        let vc = SFSafariViewController(url: URL(string: "https://torontojiazheng.com/install_app_how_to_worker.htm")!)
                present(vc,animated: true)
    }
    
    
    
    


}

