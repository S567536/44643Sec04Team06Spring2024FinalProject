//
//  SignUpVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 2/23/24.
//

import UIKit
import AVFoundation
import AnimatedGradientView
import Firebase

class SignUpVC: UIViewController {

 
    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBOutlet weak var fullNameTF: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var confirmTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()
        // Do any additional setup after loading the view.
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.subviews.first?.frame = self.view.bounds
    }
    
    private func applyGradientBackground(){
                let gradientType: CAGradientLayerType = .axial
                let direction: AnimatedGradientViewDirection = .down
                let animatedGradient = AnimatedGradientView(frame: self.view.bounds)
                animatedGradient.animationValues = [
                    (colors: ["ffafbd","cc2b5e"],direction,gradientType),
                    (colors: ["42275a","bdc3c7"],direction,gradientType),
                    (colors: ["de6262","dd5e89"],direction,gradientType),
                    (colors: ["06beb6","2193b0"],direction,gradientType),
                ]
                self.view.insertSubview(animatedGradient, at:0)
            }
    
    
    @IBAction func SignUpBTN(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1152)
        guard let email = emailTF.text, !email.isEmpty else {return}
        guard let password = password.text else{return}
        guard let name = fullNameTF.text else {return}
        if(password == confirmTF.text){
                Auth.auth().createUser(withEmail: email, password: password){
                firebaseResult , error in
                if let e = error{
                    print("error")
                }
                else{
                    //Go to home Screen
                    self.performSegue(withIdentifier: "goToNext", sender: self)
                }
            }
                    
        }

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
