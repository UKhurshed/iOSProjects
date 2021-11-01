//
//  ViewController.swift
//  info_systems_problem
//
//  Created by Khurshed Umarov on 25.10.2021.
//

//API_KEY = fc9c93a0395d4d82ac5d3c736f184179

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var viewModel = [NewsTableViewCellViewModel]()
    private var articles = [Articles]()
    var sourceStr = ""
    private var flag = false
    private let searchVC = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "News"
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        if NetworkManager.shared.isConnected{
            print("connected")
            fetchTopStories(source: sourceStr)
            searchBar()
        }else{
            print("is not connection")
            fetchCachedData()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(sourceScreen))
    }
    
    private func fetchCachedData(){
        let loadAllData = DataManager.loadAll(APIResponse.self)
        print(loadAllData.last?.articles)
        articles = loadAllData.last?.articles ?? []
        viewModel = articles.compactMap({
            NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description ?? "No description", imageUrl: URL(string: $0.urlToImage ?? ""))
        })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        print("loadView")
        if(viewModel.count == 0){
            print("viewModel is Empty")
            flag = false
        }else{
            print("viewModel is not Empty")
            flag = true
        }
    }
    
    @objc func sourceScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "source_vc")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = UserDefaults.standard.string(forKey: "sourceKey") ?? ""
        print("viewDidAppear worked: \(query)")
        fetchTopStories(source: query)
        
    }
    
    private func fetchTopStories(source: String){
        APICaller.shared.getTopStories(with: source){ [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                
                self?.viewModel = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description ?? "No description", imageUrl: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func searchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    private func emptyAlert(){
        let alert = UIAlertController(title: "Empty Alert", message: "Please choose Source or Search News", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate{
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == true{
            self.emptyAlert()
            return 0
        }else{
            return viewModel.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        
        APICaller.shared.getNewsByQuery(with: text){ [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModel = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description ?? "No description", imageUrl: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
        print(text)
    }
}

