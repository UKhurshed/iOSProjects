//
//  AddNewItemController.swift
//  ToDoList
//
//  Created by Khurshed Umarov on 16.10.2021.
//

import UIKit

class AddNewItemController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func backtToMain(){
//        let storeboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storeboard.instantiateViewController(withIdentifier: "view_controller")
//        navigationController?.pushViewController(viewController, animated: true)
        
        let detailViewController = NewViewController(uiColor: UIColor.green, text: "SomeText")
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @IBAction func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            self?.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    
    func createItem(name: String){
        let items = ["item1", "item2", "item3"]
        for item in items{
            let newItem = ToDoListItem(context: context)
            newItem.name = item
            newItem.data = Date()
        }
        do{
            try context.save()
        }catch{
            
        }
    }
    
}
