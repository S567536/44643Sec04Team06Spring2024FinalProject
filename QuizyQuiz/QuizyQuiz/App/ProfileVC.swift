//
//  ProfileVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/8/24.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Logout(_ sender: Any) {
        
        ShowAlert()
        
        
        
    }
    
    func ShowAlert(){
        let alert = UIAlertController(title: "Logout", message: "Would you like to logout", preferredStyle: .alert)
        let action1 = UIAlertAction(title:"cancel",style: .cancel)
        let action2 = UIAlertAction(title: "Confirm", style: .default){ _ in
            do{
                try  AuthenticationManager.shared.signOut()
                self.performSegue(withIdentifier: "productsToLogin", sender: nil)
            }catch{
                print("error")
            }}
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        present(alert,animated: true,completion: nil)
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
