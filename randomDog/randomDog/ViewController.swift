//
//  ViewController.swift
//  randomDog
//
//  Created by Khurshed Umarov on 12.10.2021.
//

import UIKit

class ViewController: UIViewController {
    let urlStr = "https://random.dog/woof.json"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Get Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let colors: [UIColor] = [
        .systemGreen,
        .systemRed,
        .systemBlue,
        .systemYellow,
        .systemPink,
        .systemPurple
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        
        view.addSubview(button)
        randomPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        randomPhoto()
        
        view.backgroundColor = colors.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 20, y: view.frame.height-100-view.safeAreaInsets.bottom, width: view.frame.size.width-50, height: 50)
    }
    
    func randomPhoto(){
        guard let url = URL(string: urlStr) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){ data, _ , error in
            guard let data = data, error == nil else{
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(RandomJson.self, from: data)
                print("Json result: \(jsonResult.url)")
                guard let imageUrl =  URL(string: jsonResult.url) else{
                    return
                }
                DispatchQueue.global().async { [weak self] in
                    guard let self = self else{ return }
                    guard let imageData = try? Data(contentsOf: imageUrl) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.imageView.image = image
                    }
                }
                
            }catch{
                print("Json error: \(error)")
            }
            
        }
        
        task.resume()
    }
    
}

struct RandomJson: Codable {
    let fileSizeBytes: Int
    let url: String
}
