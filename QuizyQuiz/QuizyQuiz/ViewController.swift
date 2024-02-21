//
//  ViewController.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 2/21/24.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var LaunchLAV: LottieAnimationView!{
        didSet{
                    LaunchLAV.animation = LottieAnimation.named("quiz")
                    LaunchLAV.alpha = 1
                    
                    LaunchLAV.play{ [weak self] _ in
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                            self?.LaunchLAV.alpha = 0.0
                        }
                        
                    }
                }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

