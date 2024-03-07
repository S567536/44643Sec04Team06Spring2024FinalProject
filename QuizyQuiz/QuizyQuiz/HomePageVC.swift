//
//  HomePageVC.swift
//  QuizyQuiz
//
//  Created by Rishik Reddy Endurthy on 2/25/24.
//

import UIKit

class HomePageVC: UIViewController {
    
    let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello"
        navigationItem.searchController =  searchController
        // Do any additional setup after loading the view.
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
