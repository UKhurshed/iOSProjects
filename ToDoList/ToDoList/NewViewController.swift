//
//  NewViewController.swift
//  ToDoList
//
//  Created by Khurshed Umarov on 20.10.2021.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet var uiView: UIView!
    @IBOutlet var textLabel: UILabel!
    
    private var uiColor: UIColor
    private var text: String
    
    init(uiColor: UIColor, text: String){
        self.uiColor = uiColor
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        uiView.backgroundColor = self.uiColor
        textLabel.text = self.text

        // Do any additional setup after loading the view.
    }
    
}
