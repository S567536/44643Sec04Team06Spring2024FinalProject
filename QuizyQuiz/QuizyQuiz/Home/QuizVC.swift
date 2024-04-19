//
//  QuizVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 4/17/24.
//

import UIKit

class QuizVC: UIViewController {
    
    
    @IBOutlet weak var questionLBL: UILabel!
    
    @IBOutlet weak var option1BTN:UIButton!
    
    
    @IBOutlet weak var option2LBL: UIButton!
    
    
    @IBOutlet weak var option3LBL: UIButton!
    
    
    
    @IBOutlet weak var option4LBL: UIButton!
    
    
    @IBOutlet weak var option5LBL: UIButton!
    
    
    @IBOutlet weak var option6LBL: UIButton!
    
    
    @IBOutlet weak var scoreLBL: UIBarButtonItem!
    
    var topics = ""
    var questions: [QuizModel] = []
    var score = 0
    var level = ""
    var index = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recent = ["topics": topics , "level" : "Easy"]
        
        scoreLBL.title = "Score : \(score)"
        self.hideAll()
        getQuiz(level: "easy")
        // Do any additional setup after loading the view.
    }
    
    func hideAll() -> Void{
        questionLBL.isHidden = true
        option1BTN.isHidden = true
        option2LBL.isHidden = true
        option3LBL.isHidden = true
        option4LBL.isHidden = true
        option5LBL.isHidden = true
        option6LBL.isHidden = true
    }
    
    
    func getQuiz(level: String) -> Void {
        Constants.getSubjectQuiz(subject: topics, level: level) {
            res in
            
            self.questions = res
            self.setQuestion()
        }
    }
    
    
    func setQuestion() -> Void{
        self.questionLBL.isHidden = false
        let question = questions[index]
        questionLBL.text = question.question ?? ""
        
        let answer = question.answers
        let option1 = answer?.answer_a
        if option1 != nil{
            option1BTN.isHidden = false
            option1BTN.setTitle(option1 ?? "", for: .normal)
        }
        let option2 = answer?.answer_b
        if option2 != nil{
            option2LBL.isHidden = false
            option2LBL.setTitle(option2 ?? "", for: .normal)
        }
        let option3 = answer?.answer_c
        if option3 != nil{
            option3LBL.isHidden = false
            option3LBL.setTitle(option3 ?? "", for: .normal)
        }
        let option4 = answer?.answer_d
        if option4 != nil{
            option4LBL.isHidden = false
            option4LBL.setTitle(option4 ?? "", for: .normal)
        }
        let option5 = answer?.answer_e
        if option5 != nil{
            option5LBL.isHidden = false
            option5LBL.setTitle(option5 ?? "", for: .normal)
        }
        let option6 = answer?.answer_f
        if option6 != nil{
            option6LBL.isHidden = false
            option6LBL.setTitle(option6 ?? "", for: .normal)
        }
    }
    
    
    
    @IBAction func answer(_ sender: Any){
        
        let question = questions[index]
        questionLBL.text = question.question ?? ""
        
        let correct_answer = question.correct_answers
        
        
        if (sender as AnyObject).tag == 0 && correct_answer?.answer_a_correct == "true"{
            score += 10
            myScore += 10
        }
        if (sender as AnyObject).tag == 1 && correct_answer?.answer_b_correct == "true"{
            score += 10
            myScore += 10
        }
        if (sender as AnyObject).tag == 2 && correct_answer?.answer_c_correct == "true"{
            score += 10
            myScore += 10
        }
        if (sender as AnyObject).tag == 3 && correct_answer?.answer_d_correct == "true"{
            score += 10
            myScore += 10
        }
        if (sender as AnyObject).tag == 4 && correct_answer?.answer_e_correct == "true"{
            score += 10
            myScore += 10
        }
        if (sender as AnyObject).tag == 5 && correct_answer?.answer_f_correct == "true"{
            score += 10
            myScore += 10
        }
        
        scoreLBL.title = "Score: \(score)"
        
        if index < questions.count - 1{
            index += 1
            self.setQuestion()
        }else{
            showAlert(message: "Congratulations! You've completed all questions for this level")
        }
        
    }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "Level Completed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
        }))
        present(alert, animated: true , completion:  nil)
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
