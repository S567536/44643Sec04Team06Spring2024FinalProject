//
//  QuestionsTVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 4/19/24.
//

import UIKit

class QuestionsTVC: UITableViewController {

    

    var topic = ""
    var level = ""
    
    var questions: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FireStoreOperations.fetchMyCreatedQuiz(subject: topic, level: level) { res in
            
            self.navigationItem.title = res?["subject"] as? String ?? ""
            self.questions = res?["questions"] as? [[String:Any]] ?? []
            
            self.tableView.reloadData()
        }
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.questions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath) as! QuestionsCell
        
        let question = self.questions[indexPath.row]
        cell.questionLBL.text = question["question"] as? String ?? ""
        
        let option1 = question["option1"] as? String ?? ""
        let option2 = question["option2"] as? String ?? ""
        let option3 = question["option3"] as? String ?? ""
        let option4 = question["option4"] as? String ?? ""
        
        cell.option1LBL.text = option1
        cell.option2LBL.text = option2
        cell.option3LBL.text = option3
        cell.option4LBL.text = option4
        
        
        let correct = question["correct"] as? String ?? ""
        cell.imgView1.image = UIImage(named: "UnCheckMark")
        cell.imgView2.image = UIImage(named: "UnCheckMark")
        cell.imgView3.image = UIImage(named: "UnCheckMark")
        cell.imgView4.image = UIImage(named: "UnCheckMark")
        
        if correct == option1 {
            
            cell.imgView1.image = UIImage(named: "CheckCircle")
        }else if correct == option2 {
            
            cell.imgView2.image = UIImage(named: "CheckCircle")
        }else if correct == option3 {
            
            cell.imgView3.image = UIImage(named: "CheckCircle")
        }else if correct == option4 {
            
            cell.imgView4.image = UIImage(named: "CheckCircle")
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
