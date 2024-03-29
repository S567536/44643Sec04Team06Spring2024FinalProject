//
//  MakingQUiz.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 3/29/24.
//

import UIKit
import AnimatedGradientView


class MakingQUiz: UIViewController {

        let questionLabel = UILabel()
        let optionsStackView = UIStackView()
        let saveButton = UIButton(type: .system)

        var optionsButtons: [UIButton] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            // Set up the question label
            questionLabel.text = "Question"
            questionLabel.font = UIFont.boldSystemFont(ofSize: 20)
            questionLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(questionLabel)

            // Set up the options stack view
            optionsStackView.axis = .horizontal
            optionsStackView.distribution = .fillEqually
            optionsStackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(optionsStackView)

            // Set up the options buttons
            let option1Button = createOptionButton(withTitle: "Option 1")
            let option2Button = createOptionButton(withTitle: "Option 2")
            let option3Button = createOptionButton(withTitle: "Option 3")
            let option4Button = createOptionButton(withTitle: "Option 4")

            // Add the buttons to the options stack view
            optionsStackView.addArrangedSubview(option1Button)
            optionsStackView.addArrangedSubview(option2Button)
            optionsStackView.addArrangedSubview(option3Button)
            optionsStackView.addArrangedSubview(option4Button)

            // Add the buttons to the optionsButtons array
            optionsButtons.append(option1Button)
            optionsButtons.append(option2Button)
            optionsButtons.append(option3Button)
            optionsButtons.append(option4Button)

            // Set up the save button
            saveButton.setTitle("Save", for: .normal)
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(saveButton)

            // Set up the constraints
            NSLayoutConstraint.activate([
                questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                optionsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
                optionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                optionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                saveButton.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 16),
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
            ])
        }

        func createOptionButton(withTitle title: String) -> UIButton {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(optionTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }

        @objc func optionTapped(_ sender: UIButton) {
            // Add action for option buttons
        }

        @objc func saveButtonTapped(_ sender: UIButton) {
            // Add action for save button
        }

        func addOptionButton() {
            let newButton = createOptionButton(withTitle: "Option \(optionsButtons.count + 1)")
            optionsStackView.addArrangedSubview(newButton)
            optionsButtons.append(newButton)
        }

        func removeOptionButton(at index: Int) {
    optionsStackView.removeArrangedSubview(optionsButtons[index])
            optionsButtons[index].removeFromSuperview()
            optionsButtons.remove(at: index)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
