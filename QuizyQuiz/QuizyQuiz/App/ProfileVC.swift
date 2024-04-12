//
//  ProfileVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/8/24.
//

import UIKit
import FirebaseAuth
import AnimatedGradientView

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradientBackground()

        // Do any additional setup after loading the view.
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
