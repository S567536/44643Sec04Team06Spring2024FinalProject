//
//  MakingQUiz.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/29/24.
//

import UIKit
import AnimatedGradientView
import FirebaseAuth
import FirebaseFirestore


class MakingQUiz: UIViewController{

    @IBOutlet weak var questionTV: UITextView!
    
    @IBOutlet weak var option1TF: UITextField!
    
    @IBOutlet weak var option1BTN: UIButton!
    
    @IBOutlet weak var option2TF: UITextField!
    
    @IBOutlet weak var option2BTN: UIButton!
    
    @IBOutlet weak var option3TF: UITextField!
    
    @IBOutlet weak var option3BTN: UIButton!
    
    
    @IBOutlet weak var option4TF: UITextField!
    
    
    @IBOutlet weak var option4BTN: UIButton!
    
    @IBOutlet weak var saveBTN: UIButton!
    
    var correct_answer_Tag = -1
    var topic = ""
    var level = ""
    var questions_count = 0
    
    var questions: [[String:Any]]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "quiz4")
                backgroundImage.contentMode = .scaleAspectFill // or .scaleAspectFit, depending on your preference
                backgroundImage.clipsToBounds = true // Ensure the image doesn't extend beyond the view's bounds
                self.view.addSubview(backgroundImage)
                self.view.sendSubviewToBack(backgroundImage)

        // Do any additional setup after loading the view.
        
        questionTV.text = ""
        questionTV.textColor = .lightGray
        questionTV.delegate = self
        
        saveBTN.isEnabled = true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

    @IBAction func correct(_ sender: UIButton) {
        
        option1BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        option2BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        option3BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        option4BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        
        if sender.tag == 0 {
            
            option1BTN.setImage(UIImage(named: "CheckCircle"), for: .normal)
        }else if sender.tag == 1 {
            
            option2BTN.setImage(UIImage(named: "CheckCircle"), for: .normal)
        }else if sender.tag == 2 {
            
            option3BTN.setImage(UIImage(named: "CheckCircle"), for: .normal)
        }else if sender.tag == 3 {
            
            option4BTN.setImage(UIImage(named: "CheckCircle"), for: .normal)
        }
        
        correct_answer_Tag = sender.tag
    }
    
    
    @IBAction func save(_ sender: Any) {
       
        if questions?.count ?? 0 < questions_count {
            
            let remaining = questions_count - (questions?.count ?? 0)
            self.showAlert(str: "\(remaining-1) questions remaining to save this level")
        }else {
            
            let id = Auth.auth().currentUser?.uid ?? ""
            let params = ["user_id": id,
                          "topic": topic,
                          "level": level,
                          "questions": questions!] as [String : Any]
            
            let path = String(format: "%@", "Questions")
            let db = Firestore.firestore()
            
           // self.showProgress()
            db.collection(path).document().setData(params) { err in
                if let err = err {

                   // self.removeProgress()
                    self.showAlert(str: err.localizedDescription)

                } else {

                    //self.removeProgress()
                   let alert = UIAlertController(title: "", message: "Questions saved successfully", preferredStyle: UIAlertController.Style.alert)
                   
                   alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in

//                        self.navigationController?.popViewController(animated: true)

                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        if questionTV.text == "Enter question here" {
            
            self.showAlert(str: "Enter question")
        }else if option1TF.text == "" {
            
            self.showAlert(str: "Enter option1")
        }else if option2TF.text == "" {
            
            self.showAlert(str: "Enter option2")
        }else if option3TF.text == "" {
            
            self.showAlert(str: "Enter option3")
        }else if option4TF.text == "" {
            
            self.showAlert(str: "Enter option4")
        }else if correct_answer_Tag == -1 {
            
            self.showAlert(str: "Select correct answer")
        }else {
            
            var correct = ""
            if correct_answer_Tag == 0 {
                
                correct = option1TF.text!
            }else if correct_answer_Tag == 1 {
                
                correct = option2TF.text!
            }else if correct_answer_Tag == 2 {
                
                correct = option3TF.text!
            }else if correct_answer_Tag == 3 {
                
                correct = option4TF.text!
            }
            
            let dict = ["question": questionTV.text!,
                        "option1": option1TF.text!,
                        "option2": option2TF.text!,
                        "option3": option3TF.text!,
                        "option4": option4TF.text!,
                        "correct": correct]
            
            questions?.append(dict)
            self.reset()
            
            if questions?.count == questions_count {
                
                saveBTN.isEnabled = true
            }
            
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Alert", message: "Do you wish to reset this question?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            
            self.reset()
        }
        alertController.addAction(confirmAction)
        
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present Alert Controller
        present(alertController, animated: true, completion: nil)
    }
    
    
    func reset() -> Void {
        
        questionTV.text = "Enter question here"
        questionTV.textColor = .lightGray
        
        option1TF.text = ""
        option2TF.text = ""
        option3TF.text = ""
        option4TF.text = ""
        
        option1BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        option2BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        option3BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
        option4BTN.setImage(UIImage(named: "UnCheckMark"), for: .normal)
    }
    
    
    func showAlert(str: String) -> Void {
        
        let alert = UIAlertController(title: "Error", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension MakingQUiz: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "Enter question here"
            textView.textColor = .lightGray
        }
    }
}
