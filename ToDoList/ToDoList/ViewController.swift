//
//  ViewController.swift
//  ToDoList
//
//  Created by Khurshed Umarov on 14.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
      
        print("Model:",isEmptyModel())
        
        print("viewDidLoad")
        title = "CoreData To Do List"
        view.addSubview(tableView)
        getAll()
        tableView.dataSource = self
        tableView.delegate  = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapNext))
    }
    
    func isEmptyModel() -> Bool{
        do{
            models = try context.fetch(ToDoListItem.fetchRequest())
            if(models.count < 1){
                print("model is empty")
                return false
            }else{
                return true
            }
        }catch{
            return false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAll()
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    
    
    @objc private func didTapNext(){
        let storeboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storeboard.instantiateViewController(withIdentifier: "new_item_vc")
        navigationController?.pushViewController(viewController, animated: true)
    
    }
    
//    @objc private func didTapAdd(){
//        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
//        alert.addTextField(configurationHandler: nil)
//        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
//            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
//                return
//            }
//            self?.createItem(name: text)
//        }))
//        present(alert, animated: true)
//    }
    
    //Core Data
    
    func getAll(){
        do {
            models = try context.fetch(ToDoListItem.fetchRequest())
            print("Model: \(models.count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            
        }
        
    }
    
    func createItem(name: String){
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.data = Date()
        
        do{
            try context.save()
            getAll()
        }catch{
            
        }
    }
    
    func deleteItem(item: ToDoListItem){
        context.delete(item)
        do {
            try context.save()
            getAll()
        }catch{
            
        }
    }
    
        func updateItem(item: ToDoListItem, newName: String){
            item.name = newName
            do {
                try context.save()
                getAll()
            }catch{
                
            }
        }
    
=======
        // Do any additional setup after loading the view.
    }


>>>>>>> parent of a579aa3 (ToDoList is completed)
}

