//
//  Created.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 4/19/24.
//

import UIKit

class Created: UIViewController {
    
    @IBOutlet weak var subjectBTN: UIButton!
    

    @IBOutlet weak var difficultyBTN: UIButton!
    
    var topics: [SubjectModel] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.setLevelPopupButton()
        //self.showProgress()
        Constants.getSubjects { res in
            
           // self.removeProgress()
            self.topics = res
            
            self.setSubjectPopupButton()
        }
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
    
    
    func setSubjectPopupButton() -> Void {
        
        var optionsArray = [UIAction]()
        for subject in topics {
            
            let action = UIAction(title: subject.name ?? "", state: .off, handler: { (action: UIAction) in
                
                print("Pop-up action")
                print(action.title)
                
                if let index = self.topics.firstIndex(where: { $0.name == action.title }) {
                    
                    self.topic = self.topics[index].name ?? ""
                }
            })
            optionsArray.append(action)
        }
        
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        subjectBTN.menu = optionsMenu
        
        if topics.count > 0 {
            
            self.topic = self.topics[0].name ?? ""
        }
    }
    
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "quizez" {
            
            let vc = segue.destination as! QuestionsTVC
            
            vc.level = self.level
            vc.topic = self.topic
        }
    }
    
    
    @IBAction func next(_ sender: Any) {
        self.performSegue(withIdentifier: "quizez", sender: self)
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
