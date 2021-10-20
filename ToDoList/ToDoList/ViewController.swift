//
//  ViewController.swift
//  ToDoList
//
//  Created by Khurshed Umarov on 14.10.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: {_ in
            let alert = UIAlertController(title: "Edit Item", message: "Edit item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newText = field.text, !newText.isEmpty else{
                    return
                }
                self?.updateItem(item: item, newName: newText)
            }))
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
    
}

