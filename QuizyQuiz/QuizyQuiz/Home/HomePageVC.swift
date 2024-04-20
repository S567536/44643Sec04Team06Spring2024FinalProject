//
//  HomePageVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 2/25/24.
//

import UIKit
import AnimatedGradientView
import FirebaseAuth

class HomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var recentLBL: UILabel!
    
    
    @IBOutlet weak var recentView: UIView!
    
    
    @IBOutlet weak var recentQuizLBL: UILabel!
    
    
    @IBOutlet weak var levelLBL: UILabel!
    
    
    
    @IBOutlet weak var topicsTV: UITableView!
    
    
    @IBOutlet weak var questLBL: UILabel!
    var topics: [SubjectModel] = []
    var selectedTopic = ""
    var selectedLevel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questLBL.text = "Hi, \(Auth.auth().currentUser?.displayName ?? "")"

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "quiz4")
                backgroundImage.contentMode = .scaleAspectFill // or .scaleAspectFit, depending on your preference
                backgroundImage.clipsToBounds = true // Ensure the image doesn't extend beyond the view's bounds
                self.view.addSubview(backgroundImage)
                self.view.sendSubviewToBack(backgroundImage)
        self.topicsTV.delegate = self
        self.topicsTV.dataSource = self
        self.topicsTV.clipsToBounds = true
        
        
        Constants.getSubjects { res in
            self.topics = res
            self.topicsTV.reloadData()
            
        }
        
        self.setUserScore()
    }
    
    func setUserScore() -> Void {
        
        FireStoreOperations.fetchUserScore { resp in
            
            if resp == nil {
                
                FireStoreOperations.createScoreInfo { _, _ in
                    
                    self.setUserScore()
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        
        let recent = UserDefaults.standard.value(forKey: "recentQuiz") as? [String:Any] ?? nil
        if recent == nil {
            
            recentLBL.isHidden = true
            recentView.isHidden = true
            
        }else {
            
            recentLBL.isHidden = false
            recentView.isHidden = false
            
            selectedTopic = recent?["subject"] as? String ?? "Linux"
            selectedLevel = recent?["level"] as? String ?? "Easy"
            
            recentQuizLBL.text = selectedTopic
            levelLBL.text = selectedLevel
            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            recentView.addGestureRecognizer(tapGesture)

        }
        
    }
    
    
    // Handler method to respond to the tap gesture
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            
            self.performSegue(withIdentifier: "quiz", sender: self)
            
            // You can add your desired actions here
        }
    
    
    
    //        title = "Hello"
    //        navigationItem.searchController =  searchController
    //        applyGradientBackground()
    // Do any additional setup after loading the view.
    
    //    private func applyGradientBackground(){
    //                let gradientType: CAGradientLayerType = .axial
    //                let direction: AnimatedGradientViewDirection = .down
    //                let animatedGradient = AnimatedGradientView(frame: self.view.bounds)
    //                animatedGradient.animationValues = [
    //                    (colors: ["ffafbd","cc2b5e"],direction,gradientType),
    //                    (colors: ["42275a","bdc3c7"],direction,gradientType),
    //                    (colors: ["de6262","dd5e89"],direction,gradientType),
    //                    (colors: ["06beb6","2193b0"],direction,gradientType),
    //                ]
    //                self.view.insertSubview(animatedGradient, at:0)
    //            }
    //
    //
    //
    //    @IBAction func seeAllBTN(_ sender: UIButton) {
    //        self.performSegue(withIdentifier:"seeAll", sender: sender)
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count > 4 ? 4 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        print(cell)
        let topics = topics[indexPath.row]
        cell.textLabel?.text = topics.name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTopic = topics[indexPath.row].name ?? "Linux"
        self.performSegue(withIdentifier: "quiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quiz"{
            _ = segue.destination as! QuizVC
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
