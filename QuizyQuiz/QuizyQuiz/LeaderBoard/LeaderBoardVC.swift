//
//  LeaderBoardVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/8/24.
//

import UIKit
import AnimatedGradientView

class LeaderBoardVC: UIViewController {
    
    
    @IBOutlet weak var dataSV: UIStackView!
    

    @IBOutlet weak var mypositionLBL: UILabel!
    
    @IBOutlet weak var senView: UIView!
    
    
    @IBOutlet weak var yourView: UIView!
    
    @IBOutlet weak var fourView: UIView!
    
 
    @IBOutlet weak var fifithView: UIView!
    
    @IBOutlet weak var istView: UIView!
    
    
    @IBOutlet weak var thiView: UIView!
    
    
    @IBOutlet weak var thiIV: UIImageView!
    
    
    @IBOutlet weak var istIV: UIImageView!
    
    
    
    @IBOutlet weak var secIV: UIImageView!
    
    
    @IBOutlet weak var fourLBL: UILabel!
    
    
    @IBOutlet weak var fifthLBL: UILabel!
    
    var top5: [ScoreModel] = []
    var myPosition = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                backgroundImage.image = UIImage(named: "quiz4")
                backgroundImage.contentMode = .scaleAspectFill // or .scaleAspectFit, depending on your preference
                backgroundImage.clipsToBounds = true // Ensure the image doesn't extend beyond the view's bounds
                self.view.addSubview(backgroundImage)
                self.view.sendSubviewToBack(backgroundImage)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getData()
    }
    
    func getData() -> Void {
        
        dataSV.isHidden = true
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        //self.showProgress()
//        FireStoreOperations.getTopScorers { resp in
//            
//            self.top5 = resp ?? []
//            dispatchGroup.leave()
//        }
//        
//        dispatchGroup.enter()
//        
//        FireStoreOperations.getUserScorePosition { res in
//            
//            self.myPosition = res
//            dispatchGroup.leave()
//        }
        
        
        
        dispatchGroup.notify(queue: .main) {
            
            self.dataSV.isHidden = false
            //self.removeProgress()
            self.showData()
        }
    }
    
    
    func showData() -> Void {
        
        let str = self.convertToOrdinal(number: myPosition)
        mypositionLBL.text = "You're Ranked \(str)"
        
        istView.isHidden = true
        senView.isHidden = true
        thiView.isHidden = true
        fourView.isHidden = true
        fifithView.isHidden = true
        
        istIV.layer.cornerRadius = istIV.frame.size.height / 2
        istIV.clipsToBounds = true
        
//        senIV.layer.cornerRadius = senIV.frame.size.height / 2
//        senIV.clipsToBounds = true
        
        
        thiIV.layer.cornerRadius = thiIV.frame.size.height / 2
        thiIV.clipsToBounds = true
        
        for i in 0..<top5.count {
            
            let score = top5[i]
            let url = top5[i].image
            if i == 0 {
                
                istView.isHidden = false
                istIV.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "person.circle"))
            }
            
            if i == 1 {
                
                senView.isHidden = false
//                secIV.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "person.circle"))
            }
            
            if i == 2 {
                
                thiView.isHidden = false
                thiIV.sd_setImage(with: URL(string: url), placeholderImage: UIImage(systemName: "person.circle"))
            }
            
            if i == 3 {
                
                fourView.isHidden = false
                fourLBL.text = score.name
            }
            
            
            if i == 4 {
                
                fifithView.isHidden = false
                fifthLBL.text = score.name
            }
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

    func convertToOrdinal(number: Int) -> String {
        // Check if the number is within the range of 11-13 (special cases)
        if (number % 100 >= 11) && (number % 100 <= 13) {
            return "\(number)th"
        }
        
        // For other numbers, handle ordinal suffix based on the last digit
        switch number % 10 {
        case 1:
            return "\(number)st"
        case 2:
            return "\(number)nd"
        case 3:
            return "\(number)rd"
        default:
            return "\(number)th"
        }
    }

    
    
}
