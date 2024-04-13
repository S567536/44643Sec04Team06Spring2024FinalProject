//
//  seeAllTableViewCell.swift
//  QuizyQuiz
//
//  Created by Hema Pradeepthi Gurram on 4/12/24.
//

import UIKit

class seeAllTableViewCell: UITableViewCell {
    static let identifier = "seeAllTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "seeAllTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
