//
//  FireStoreOperations.swift
//  QuizyQuiz
//
//  Created by Veerasekhar Nannapaneni on 16/04/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


struct FireStoreOperations{
    
    static let db = Firestore.firestore()
    
    public static func fetchUserScore(completion: @escaping (ScoreModel?) -> ()){
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("Scores")
            .whereField("user_id", isEqualTo: id)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                
                if querySnapshot?.documents.count == 0 {
                    
                    completion(nil)
                }
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let a = ScoreModel(id: document.documentID,
                                       user_id: data["user_id"] as? String ?? "",
                                       score: data["score"] as? Int ?? 0,
                                       name: data["name"] as? String ?? "",
                                       image: data["image"] as? String ?? "")
                    
                    myScore = a.score
                    myScoreID = a.id
                    completion(a)
                }
            }
        }
    }
    
    public static func createScoreInfo(completion: @escaping (Error?, Bool) -> ()) {
        
        let id = Auth.auth().currentUser?.uid ?? ""
        
        let params = ["user_id": id,
                      "score": 0,
                      "name": Auth.auth().currentUser?.displayName ?? "",
                      "image": Auth.auth().currentUser?.photoURL?.absoluteString ?? ""] as [String : Any]
        
        
        let path = String(format: "%@", "Scores")
        let db = Firestore.firestore()
        
        db.collection(path).document().setData(params) { err in
            if let err = err {
                
                completion(err, false)
            } else {
                
                completion(nil, true)
            }
        }
    }
    
    public static func updateMyScore(completion: @escaping (Error?, Bool) -> ()) {
        
        let db = Firestore.firestore()
        
        let params = ["score": myScore,
                      "name": Auth.auth().currentUser?.displayName ?? "",
                      "image": Auth.auth().currentUser?.photoURL?.absoluteString ?? ""] as [String : Any]
        
        db.collection("Scores").document(myScoreID).updateData(params) { err in
            
        }
    }
    
    public static func getTopScorers(completion: @escaping ([ScoreModel]?) -> ()) {
        let db = Firestore.firestore()
        
        db.collection("Scores")
            .order(by: "score", descending: true)
            .limit(to: 5)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting top scorers: \(error)")
                    completion([])
                } else {
                    
                    var results: [ScoreModel] = []
                    
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        let data = document.data()
                        let a = ScoreModel(id: document.documentID,
                                           user_id: data["user_id"] as? String ?? "",
                                           score: data["score"] as? Int ?? 0,
                                           name: data["name"] as? String ?? "",
                                           image: data["image"] as? String ?? "")
                        
                        results.append(a)
                    }
                    
                    completion(results)
                }
            }
    }
    
    
    public static func getUserScorePosition(completion: @escaping (Int) -> ()) {
        let db = Firestore.firestore()
        
        let id = Auth.auth().currentUser?.uid ?? ""
        db.collection("Scores")
            .order(by: "score", descending: true)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting scores: \(error)")
                    completion(-1)
                } else {
                    var position = 0
                    for (index, document) in querySnapshot!.documents.enumerated() {
                        let data = document.data()
                        if let scoreUsername = data["user_id"] as? String {
                            if scoreUsername == id {
                                position = index + 1 // Index starts from 0, so add 1 to get position
                                break
                            }
                        }
                    }
                    
                    completion(position)
                }
            }
    }
    
    
    public static func fetchMyCreatedQuiz(subject: String, level: String, completion: @escaping ([String:Any]?) -> ()){
        
        let id = Auth.auth().currentUser?.uid ?? ""
        let docRef = db.collection("Questions")
            .whereField("user_id", isEqualTo: id)
            .whereField("subject", isEqualTo: subject)
            .whereField("level", isEqualTo: level)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(nil)
            } else {
                
                if querySnapshot?.documents.count == 0 {
                    
                    completion(nil)
                }
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    completion(data)
                }
            }
        }
    }
}
