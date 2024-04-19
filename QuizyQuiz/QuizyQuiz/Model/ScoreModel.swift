//
//  ScoreModel.swift
//  QuizyQuiz
//
//  Created by Veerasekhar Nannapaneni on 16/04/2024.
//

import Foundation

struct ScoreModel: Codable {
    
    var id: String
    var user_id: String
    var score: Int
    var name: String
    var image: String
}
