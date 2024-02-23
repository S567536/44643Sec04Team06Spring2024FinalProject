//
//  ViewController.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 2/21/24.
//

import UIKit
import Lottie
import AnimatedGradientView

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
        applyGradientBackground()
        // Do any additional setup after loading the view.
    }
    private func applyGradientBackground(){
            let gradientType: CAGradientLayerType = .axial
            let direction: AnimatedGradientViewDirection = .down
            let animatedGradient = AnimatedGradientView(frame: self.view.bounds)
            animatedGradient.animationValues = [
                (colors: ["ffafbd","cc2b5e"],direction,gradientType),
                (colors: ["42275a","bdc3c7"],direction,gradientType),
                (colors: ["de6262","dd5e89"],direction,gradientType),
                (colors: ["06beb6","2193b0"],direction,gradientType),
            ]
            self.view.insertSubview(animatedGradient, at:0)
        }

}
