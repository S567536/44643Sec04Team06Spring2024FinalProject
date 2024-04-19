//
//  ResetpasswordVC.swift
//  QuizyQuiz
//
//  Created by manikanta on 3/27/24.
//

import UIKit
import FirebaseAuth
import AnimatedGradientView

class ResetpasswordVC: UIViewController {

    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var MessageLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendLink(_ sender: Any) {
        Task { @MainActor in
            
            guard let email = EmailTF.text, !email.isEmpty else{MessageLBL.text="IPlease enter the email"; return
                
            }
            do{
                try await resetPassword(email: email)
            }catch{
            MessageLBL.text = "Error"
            }
        
            
            
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
//        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    func resetPassword(email :String) async throws{
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                print("Password reset email sent successfully.")
            } catch {
                print("Error sending password reset email: \(error.localizedDescription)")
                throw error
            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
