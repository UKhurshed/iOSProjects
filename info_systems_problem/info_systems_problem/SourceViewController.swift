//
//  SourceViewController.swift
//  info_systems_problem
//
//  Created by Khurshed Umarov on 28.10.2021.
//

import UIKit

class SourceViewController: UIViewController {
    
    @IBOutlet var chooseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func businessBtn(_ sender: UIButton) {
        self.chooseLabel.text = "Business"
        UserDefaults.standard.set("business", forKey: "sourceKey")
    }
    
    @IBAction func entertainmentBtn(_ sender: UIButton) {
        self.chooseLabel.text = "Entertainment"
        UserDefaults.standard.set("entertainment", forKey: "sourceKey")
    }
    
    @IBAction func generalBtn(_ sender: UIButton) {
        self.chooseLabel.text = "General"
        UserDefaults.standard.set("general", forKey: "sourceKey")
    }
    
    @IBAction func healthBtn(_ sender: UIButton) {
        self.chooseLabel.text = "Health"
        UserDefaults.standard.set("health", forKey: "sourceKey")
        
    }
    
    @IBAction func scienceBtn(_ sender: UIButton) {
        self.chooseLabel.text = "Science"
        UserDefaults.standard.set("science", forKey: "sourceKey")
    }
    
    @IBAction func sportsBtn(_ sender: UIButton) {
        self.chooseLabel.text = "Sports"
        UserDefaults.standard.set("sports", forKey: "sourceKey")
    }
    
    @IBAction func technologyBtn(_ sender: UIButton) {
        self.chooseLabel.text = "Technology"
        UserDefaults.standard.set("technology", forKey: "sourceKey")
    }
    
//    @IBAction func mainPageBtn(){
////        let sourceItem = chooseLabel.text ?? ""
////        if sourceItem.isEmpty || sourceItem.contains("None"){
////            print("source was not choose")
////        }else{
////            print("Item: \(sourceItem)")
////            mainPage(sourceItem)
////        }
////
////
//    }
    
//    private func emptyAlert(){
//        let alert = UIAlertController(title: "Source not selected", message: "Please select source", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
//        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//
//        self.present(alert, animated: true)
//    }
//
//    private func mainPage(_ str: String){
////        print("chooseLabel txt: \(str)")
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "main_vc") as? ViewController else{
////            return
////        }
////        mainVC.sourceStr = chooseLabel.text ?? ""
////        self.navigationController?.pushViewController(mainVC, animated: true)
//    }
    /*
     Sources:
     business
     entertainment
     general
     health
     science
     sports
     technology
     */
    
}

