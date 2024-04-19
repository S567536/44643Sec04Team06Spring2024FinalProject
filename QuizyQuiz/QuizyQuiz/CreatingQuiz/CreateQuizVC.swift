//
//  CreateQuizVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/8/24.
//

import UIKit

class CreateQuizVC: UIViewController {

    

    @IBOutlet weak var topicsBTN: UIButton!
    
    @IBOutlet weak var difficultyBTN: UIButton!
    
    
    @IBOutlet weak var questionLBL: UITextField!
    
    
    var topics: [ SubjectModel] = []
    
    let levels = ["Easy",
                  "Medium",
                  "Hard",
                  "Beginner",
                  "Intermediate",
                  "Advanced",
                  "Novice",
                  "Expert",
                  "Basic",
                  "Challenging"]
    
    var topic = ""
    var level = ""
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLevelPopupButton()
        Constants.getSubjects{res in
            self.topics = res
            self.setTopicPopupButton()
        }
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "quiz4")
                backgroundImage.contentMode = .scaleAspectFill // or .scaleAspectFit, depending on your preference
                backgroundImage.clipsToBounds = true // Ensure the image doesn't extend beyond the view's bounds
                self.view.addSubview(backgroundImage)
                self.view.sendSubviewToBack(backgroundImage)

        // Do any additional setup after loading the view.
    }
    
    
    func setLevelPopupButton() -> Void {
        
        var optionsArray = [UIAction]()
        for level in levels {
            
            let action = UIAction(title: level, state: .off, handler: { (action: UIAction) in
                
                print("Pop-up action")
                print(action.title)
                
                if let index = self.levels.firstIndex(of: action.title)  {
                    
                    self.level = self.levels[index]
                }
            })
            optionsArray.append(action)
        }
        
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        difficultyBTN.menu = optionsMenu
        
        if levels.count > 0 {
            
            self.level = self.levels[0]
        }
    }
    
    
    func setTopicPopupButton() -> Void {
        
        var optionsArray = [UIAction]()
        for topic in topics {
            
            let action = UIAction(title: topic.name ?? "", state: .off, handler: { (action: UIAction) in
                
                print("Pop-up action")
                print(action.title)
                
                if let index = self.topics.firstIndex(where: { $0.name == action.title }) {
                    
                    self.topic = self.topics[index].name ?? ""
                }
            })
            optionsArray.append(action)
        }
        
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        topicsBTN.menu = optionsMenu
        
        if topics.count > 0 {
            
            self.topic = self.topics[0].name ?? ""
        }
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "createQuestion" {
            
            let vc = segue.destination as! MakingQUiz

            vc.level = self.level
            vc.topic = self.topic
            vc.questions_count = Int(self.questionLBL.text ?? "0") ?? 0
        }
   }
    
    
    
    @IBAction func next(_ sender: Any) {
        if questionLBL.text == "" {
            
            self.showAlert(str: "Enter total questions")
        }
        self.performSegue(withIdentifier: "createQuestion", sender: self)
    }
    
    func showAlert(str: String) -> Void {
        
        let alert = UIAlertController(title: "Error", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
