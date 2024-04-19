//
//  QuestionsCell.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 4/19/24.
//

import UIKit

class QuestionsCell: UITableViewCell {


    @IBOutlet weak var questionLBL: UILabel!
    
    
    @IBOutlet weak var option1LBL: UILabel!
    
    
    @IBOutlet weak var imgView1: UIImageView!
    
    
    @IBOutlet weak var imgView2: UIImageView!
    
    
    @IBOutlet weak var option2LBL: UILabel!
    
    
    @IBOutlet weak var imgView3: UIImageView!
    
    
    @IBOutlet weak var option3LBL: UILabel!
    
    
    @IBOutlet weak var imgView4: UIImageView!
    
    
    @IBOutlet weak var option4LBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
