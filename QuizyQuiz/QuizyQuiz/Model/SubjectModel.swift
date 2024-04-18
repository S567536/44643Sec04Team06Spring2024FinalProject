//
//  SubjectModel.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 04/14/2024.
//

import Foundation
import Alamofire
import UIKit

struct SubjectModel: Codable {
    
    var id: Int?
    var name: String?
    
    init() {}
}


var myScore = 0
var myScoreID = ""

struct Constants {
    
    static let apiKey = "YZodkyOZS5T9klegbKDGvfK6xuKpEbkIfJ3QyD5D"
    
    static var subjects: [SubjectModel] = []
    static private let decoder = JSONDecoder()
    
    static func getSubjects(completion: @escaping ([SubjectModel]) -> ()) {
        
        let urlString = "https://quizapi.io/api/v1/categories?apiKey=\(apiKey)"
        
        AF.request(urlString,
                   method: .get,
                   headers: nil)
        .validate()
        .responseDecodable(of: [SubjectModel].self) { response in
            switch response.result {
            case .success(let products):
                print(products)
                completion(products)
            case .failure(let error):
                print(error)
                completion([])
                // Handle the error
            }
        }
    }
    
    
    static func getSubjectQuiz(subject: String, level: String, completion: @escaping ([QuizModel]) -> ()) {
        
        let urlString = "https://quizapi.io/api/v1/questions?apiKey=\(apiKey)&category=\(subject)&difficulty=\(level)&multiple_correct_answers=false"
        
        AF.request(urlString,
                   method: .get,
                   headers: nil)
        .validate()
        .responseDecodable(of: [QuizModel].self) { response in
            switch response.result {
            case .success(let products):
                print(products)
                completion(products)
            case .failure(let error):
                print(error)
                completion([])
                // Handle the error
            }
        }
    }
}
