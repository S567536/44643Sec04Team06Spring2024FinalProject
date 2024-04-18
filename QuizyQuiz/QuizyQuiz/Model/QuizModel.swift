//
//  EventModel.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 04/15/2024.
//

import Foundation
import Alamofire

struct QuizModel: Codable {
    
    let id : Int?
    let question : String?
    let description : String?
    let answers : Answers?
    let multiple_correct_answers : String?
    let correct_answers : Correct_answers?
    let correct_answer : String?
    let explanation : String?
    let tip : String?
    let tags : [Tags]?
    let category : String?
    let difficulty : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case question = "question"
        case description = "description"
        case answers = "answers"
        case multiple_correct_answers = "multiple_correct_answers"
        case correct_answers = "correct_answers"
        case correct_answer = "correct_answer"
        case explanation = "explanation"
        case tip = "tip"
        case tags = "tags"
        case category = "category"
        case difficulty = "difficulty"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        answers = try values.decodeIfPresent(Answers.self, forKey: .answers)
        multiple_correct_answers = try values.decodeIfPresent(String.self, forKey: .multiple_correct_answers)
        correct_answers = try values.decodeIfPresent(Correct_answers.self, forKey: .correct_answers)
        correct_answer = try values.decodeIfPresent(String.self, forKey: .correct_answer)
        explanation = try values.decodeIfPresent(String.self, forKey: .explanation)
        tip = try values.decodeIfPresent(String.self, forKey: .tip)
        tags = try values.decodeIfPresent([Tags].self, forKey: .tags)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        difficulty = try values.decodeIfPresent(String.self, forKey: .difficulty)
    }
}


struct Answers : Codable {
    
    let answer_a : String?
    let answer_b : String?
    let answer_c : String?
    let answer_d : String?
    let answer_e : String?
    let answer_f : String?

    enum CodingKeys: String, CodingKey {

        case answer_a = "answer_a"
        case answer_b = "answer_b"
        case answer_c = "answer_c"
        case answer_d = "answer_d"
        case answer_e = "answer_e"
        case answer_f = "answer_f"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        answer_a = try values.decodeIfPresent(String.self, forKey: .answer_a)
        answer_b = try values.decodeIfPresent(String.self, forKey: .answer_b)
        answer_c = try values.decodeIfPresent(String.self, forKey: .answer_c)
        answer_d = try values.decodeIfPresent(String.self, forKey: .answer_d)
        answer_e = try values.decodeIfPresent(String.self, forKey: .answer_e)
        answer_f = try values.decodeIfPresent(String.self, forKey: .answer_f)
    }
}

struct Correct_answers : Codable {
    
    let answer_a_correct : String?
    let answer_b_correct : String?
    let answer_c_correct : String?
    let answer_d_correct : String?
    let answer_e_correct : String?
    let answer_f_correct : String?

    enum CodingKeys: String, CodingKey {

        case answer_a_correct = "answer_a_correct"
        case answer_b_correct = "answer_b_correct"
        case answer_c_correct = "answer_c_correct"
        case answer_d_correct = "answer_d_correct"
        case answer_e_correct = "answer_e_correct"
        case answer_f_correct = "answer_f_correct"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        answer_a_correct = try values.decodeIfPresent(String.self, forKey: .answer_a_correct)
        answer_b_correct = try values.decodeIfPresent(String.self, forKey: .answer_b_correct)
        answer_c_correct = try values.decodeIfPresent(String.self, forKey: .answer_c_correct)
        answer_d_correct = try values.decodeIfPresent(String.self, forKey: .answer_d_correct)
        answer_e_correct = try values.decodeIfPresent(String.self, forKey: .answer_e_correct)
        answer_f_correct = try values.decodeIfPresent(String.self, forKey: .answer_f_correct)
    }

}


struct Tags : Codable {
    
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
