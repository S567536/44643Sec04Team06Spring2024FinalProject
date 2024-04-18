//
//  QuizTopicsVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 4/17/24.
//

import UIKit

class QuizTopicsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var topics : [SubjectModel] = []
    
    
    @IBOutlet weak var topicsTV: UITableView!
    
    var selectedTopics: SubjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topicsTV.delegate = self
        self.topicsTV.dataSource = self
        self.topicsTV.clipsToBounds = true
        
        
        Constants.getSubjects{ res in
            self.topics = res
            
            self.topicsTV.reloadData()
    
        }

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        
        let topics = topics[indexPath.row]
        cell.textLabel?.text = topics.name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTopics = topics[indexPath.row]
        self.performSegue(withIdentifier: "quiz", sender: self)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "quiz"{
//            
//            let vc = segue.destination as! QuizVC
//            //vc.topics = selectedTopics?.name ?? "Linux"
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
