//
//  uploadPhotosViewController2.swift
//  ttjzh3
//
//  Created by WENHU TONG on 2023-06-07.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore





class uploadPhotosViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nannyPhoto: UIImageView!
    
    var nannyPhotoName:String? = Auth.auth().currentUser?.email
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var spinner2: UIActivityIndicatorView!
    
    
    
    private let storage = Storage.storage().reference()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        spinner2.isHidden = true
        spinner2.startAnimating()
        
        nannyPhoto.contentMode = .scaleAspectFit
        
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String,
        let url = URL(string: urlString)
    
        else {
            return
        }
        
     let task = URLSession.shared.dataTask(with: url, completionHandler:  {data, _, error in
            
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async {
                
                
                
                let image  = UIImage(data:data)
                self.nannyPhoto.image = image
            }
         
        })
        
        task.resume()
        
        
        
        self.spinner2.hidesWhenStopped = true
        self.spinner2.stopAnimating()
        
        
        
    
    }
    

    
    @IBAction func selectPhoto(_ sender: Any) {
        
        spinner2.isHidden = false
        spinner2.startAnimating()
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
     
    }
    
    
    
    
    
    
    //************ below 2 functions are related with image picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        
 //     storage.child("images/file.png").putData(imageData, metadata: nil , completion: { _,
        
//****************************20230628下行改为Images/（原来是images/)
        storage.child("Images/"+nannyPhotoName!+".png").putData(imageData, metadata: nil , completion: { [self] _,
            error in
            
            guard error == nil else {
                print("Failed to upload.")
                return
            }
//          self.storage.child("images/file.png").downloadURL(completion: { url, error in
//****************************20230628下行改为Images/（原来是images/)
            self.storage.child("Images/"+nannyPhotoName!+".png").downloadURL(completion: { [self] url, error in
                
                guard let url = url, error == nil else{
                    return
                }
                let urlString = url.absoluteString
  
                DispatchQueue.main.async {
                     self.nannyPhoto.image = image
                    
                    self.spinner2.hidesWhenStopped = true
                    self.spinner2.stopAnimating()
                }
         
                print("Download URL: \(urlString)")
                UserDefaults.standard.setValue(urlString, forKey: "url")
                
                
//********************************20230609 working on below
                
                
                if let messageSender = Auth.auth().currentUser?.email{
                       
                             db.collection("nannies")
                               .document(messageSender)
                               .updateData([
                         
                               "photo1":urlString,
    
                           ]) { (error) in
                               if let e = error{
                                    print(e)
                               }else{
                                   print ("Saved!")

                               }
                           }
                           
                       }
                
                
 //---------------------------------20230609 working on above
                
                
                
                
                
                
 //*******below added on 2023-06-08
                
                let alertController = UIAlertController(title: "", message: "你的照片已经成功上传。", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "请点击此处关闭弹窗。", style: .default) { (action) in
                    
//                               self.dismiss(animated: true, completion: nil)
                       
                }
                alertController.addAction(dismissAction)
                self.present(alertController, animated: true, completion: nil)
                
                
//--------- above added on 2023-06-08
                
                
                
                
                
                
                
             })
            
        })

    }
    
 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        picker.dismiss(animated: true, completion: nil)
        
    }
 
    //************ above 2 functions are related with image picker
    
 
    
    
    
    
    
    
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
