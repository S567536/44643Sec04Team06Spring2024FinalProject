//
//  ProfileVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/8/24.
//

import UIKit
import FirebaseAuth
import AnimatedGradientView
import FirebaseStorage
import SDWebImage

class ProfileVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var pictureView: UIView!
    
    
    @IBOutlet weak var profileIV: UIImageView!
    
    
    @IBOutlet weak var dataTV: UITableView!
    
    
    
    @IBOutlet weak var nameLBL: UILabel!
    var titles = ["Privacy & Settings",
                  "Notifications",
                  "Created Quizes",
                  "Logout"]
    
    
    var icons = ["lock",
                  "bell",
                  "list.clipboard",
                  "figure.walk"]
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "quiz4")
                backgroundImage.contentMode = .scaleAspectFill // or .scaleAspectFit, depending on your preference
                backgroundImage.clipsToBounds = true // Ensure the image doesn't extend beyond the view's bounds
                self.view.addSubview(backgroundImage)
                self.view.sendSubviewToBack(backgroundImage)
        
        pictureView.layer.cornerRadius = pictureView.frame.size.height / 2
        pictureView.clipsToBounds = true
        
        profileIV.layer.cornerRadius = profileIV.frame.size.height / 2
        profileIV.clipsToBounds = true
        
        nameLBL.text = Auth.auth().currentUser?.displayName ?? ""
        
        dataTV.delegate = self
        dataTV.dataSource = self
        dataTV.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        nameLBL.text = Auth.auth().currentUser?.displayName ?? ""
        
        let url = Auth.auth().currentUser?.photoURL
        profileIV.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.circle"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        cell.imageView?.image = UIImage(systemName: icons[indexPath.row])
        cell.textLabel?.text = titles[indexPath.row]
        
        cell.imageView?.tintColor = UIColor.darkGray
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 2 {
            
            self.performSegue(withIdentifier: "createdQuiz", sender: self)
        }
        else if indexPath.row == 3 {
            
            UserDefaults.standard.removeObject(forKey: "recentQuiz")
            UserDefaults.standard.synchronize()
            
            do {
                
                try Auth.auth().signOut()
            } catch {}
            
            
            self.performSegue(withIdentifier: "profileToSplash", sender: self)
        }
    }
    
    @IBAction func imgBtnClicked(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            
            self.selectImageFromGallery()
            
            
        }))

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            
            self.takeImageFromCamera()
            
            
        }))

        self.present(actionSheet, animated: true)
    }
    
    func selectImageFromGallery() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        self.present(pickerController, animated: true)
    }

    func takeImageFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        self.present(imagePicker, animated: true)
    }
    
    func uploadProfileImage(completion: @escaping () -> ()) {
        
        var imageData:Data = selectedImage!.pngData()! as Data
        if imageData.count <= 0 {
            
            imageData = selectedImage!.jpegData(compressionQuality: 1.0)! as Data
        }
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        let name = "\(uid).png"
        
        let storageRef = Storage.storage().reference().child("\(name)")
        
        //self.showProgress()
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("error")
                
                completion()
                
            } else {
                
                storageRef.downloadURL(completion: { (url, error) in
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = url
                    changeRequest?.commitChanges(completion: { (error) in
                        if let error = error {
                            print("Error updating profile: \(error.localizedDescription)")
                            completion()
                            return
                        }
                        
                        print("Profile picture updated successfully")
                    })
                    
                    completion()
                })
            }
        }
    }
}


extension ProfileVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage

        if let image = image {
            
            self.profileIV.image = image
            self.selectedImage = image
            
            self.uploadProfileImage {
                
                //self.removeProgress()
            }
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

    

