//
//  Model.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 4/11/24.
//

import Foundation


struct QuizQuestion {
    let id: Int
    let question: String
    let description: String?
    let answers: [String: String?]
    let multipleCorrectAnswers: Bool
    let correctAnswers: [String: Bool]
    let correctAnswer: String?
    let explanation: String?
    let tip: String?
    let tags: [Tag]
    let category: String
    let difficulty: String
}
enum CodingKeys: String, CodingKey {
        case id
        case question
        case description
        case answers
        case multipleCorrectAnswers
        case correctAnswers
        case correctAnswer
        case explanation
        case tip
        case tags
        case category
        case difficulty
    // Add other coding keys as needed
    }

struct Tag {
    let name: String
}

func fetchQuizData(completion: @escaping ([QuizQuestion]?, Error?) -> Void) {
    // Replace "YOUR_API_KEY" with your actual API key
    let apiKey = "YZodkyOZS5T9klegbKDGvfK6xuKpEbkIfJ3QyD5D"
    let urlString = "https://quizapi.io/api/v1/questions?apiKey=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(nil, error)
            return
        }
        
        guard let data = data else {
            completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
            return
        }
        
        do {
            // Decode JSON data manually to see if there are any issues
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonObject)
            
            // Once you've identified the structure of the JSON response, update the QuizQuestion struct accordingly
            
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
}

// Usage:

//fetchQuizData { (questions, error) in
//    if let error = error {
//        print("Error fetching quiz data: \(error)")
//        return
//    }
//    
//    if let questions = questions {
//        print("Fetched \(questions.count) quiz questions.")
//        for question in questions {
//            print("Question: \(question.question)")
//            // Print other properties as needed
//        }
//    } else {
//        print("No quiz questions fetched.")
//    }
//}
