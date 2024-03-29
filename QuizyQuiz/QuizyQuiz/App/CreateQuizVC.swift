//
//  CreateQuizVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/8/24.
//

import UIKit

class CreateQuizVC: UIViewController {

    
    @IBOutlet weak var topicName: UITextField!
    
    
    @IBOutlet weak var noOfQuestion: UITextField!
    
    
    @IBOutlet weak var messageLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createQUiz(_ sender: Any) {
        guard let topic = topicName.text, !topic.isEmpty else {
            self.messageLBL.text = "please Enter the topic Name"
            return
        }
        guard let num = noOfQuestion.text, !num.isEmpty else{
            self.messageLBL.text = "Please enter the number of question"
            return
        }
        
        performSegue(withIdentifier: "creatingQuiz", sender: nil)
        
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
