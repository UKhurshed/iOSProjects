//
//  ViewController.swift
//  onlym
//
//  Created by Khurshed Umarov on 13.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageTitle: UIImageView!
    
    @IBOutlet weak var labelTxt: UILabel!
    //    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageTitle.contentMode = .scaleAspectFill
        imageTitle.backgroundColor = .black
        
        labelTxt.textColor = .red
        getData()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func getData(){
        guard let url = URL(string: "https://onlym.ru/api_test/test.json") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let jsonResult = try JSONDecoder().decode(OnlymJSON.self, from: data)
                print("Json result: \(jsonResult)")
                
//                DispatchQueue.main.async {
//                    self.imageView.backgroundColor = self.hexStringToUIColor(hex: "#ffffff")
//                }
                //                self.imageView.backgroundColor =
            }catch{
                print("Json error: \(error)")
            }
        }
        task.resume()
    }
    
    struct User: Decodable {
        var first_name: String
        var last_name: String
        var country: String
    }
    
    struct OnlymJSON: Codable {
        let banners: [Banner]
        let articles: [Article]
    }
    
    struct Article: Codable {
        let title, text: String
    }
    
    struct Banner: Codable {
        let name, color: String
        let active: Bool
    }
    
    let jsonData = """
    {
       "articles":[
          {
             "title":"text 1",
             "text":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce fringilla arcu a ipsum iaculis placerat. Vestibulum quis interdum neque. Nullam diam dui, fermentum ut tempus venenatis, volutpat vitae leo. Nulla facilisi. Aliquam convallis id urna sed vestibulum. Nunc nec mauris eleifend, feugiat lacus vitae, consequat nisi. Suspendisse gravida, metus sed tincidunt fringilla, odio velit ornare augue, id dapibus neque odio in enim. Phasellus id felis purus. Proin porttitor eros eu arcu hendrerit venenatis. Nullam feugiat egestas tortor, vel sollicitudin ante ultricies eget. Nunc malesuada et nibh vel sollicitudin. \n Morbi dapibus, elit eget rhoncus consectetur, arcu dui dignissim turpis, ac convallis ante metus ut tortor. Nunc et hendrerit nibh, quis ornare sapien. Maecenas imperdiet eget tortor sagittis maximus. Duis augue sapien, commodo ac maximus vitae, gravida eget odio. Suspendisse iaculis leo et mi mollis vehicula. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam fringilla malesuada maximus. Etiam ultricies, neque ac tristique rhoncus, urna enim lobortis elit, porttitor dictum mauris enim ut libero. Sed augue velit, interdum faucibus lectus non, auctor mattis dolor. Fusce pellentesque ornare est sed ultrices. Suspendisse finibus mi fermentum turpis scelerisque, et mattis erat lacinia. Aenean augue urna, blandit eget aliquet ut, hendrerit nec quam.\n Phasellus aliquet porttitor eros, eu ullamcorper odio ultricies sit amet. Praesent placerat nibh quis nulla iaculis, eu maximus tortor ultricies. Vivamus et elit sed nulla porta ultricies ut blandit elit. Praesent molestie ac risus nec euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut eget elit quis ipsum accumsan dictum. Cras purus erat, faucibus in nisi non, tempor laoreet sapien."
          },
          {
             "title":"text 2",
             "text":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce fringilla arcu a ipsum iaculis placerat. Vestibulum quis interdum neque. Nullam diam dui, fermentum ut tempus venenatis, volutpat vitae leo. Nulla facilisi. Aliquam convallis id urna sed vestibulum. Nunc nec mauris eleifend, feugiat lacus vitae, consequat nisi. Suspendisse gravida, metus sed tincidunt fringilla, odio velit ornare augue, id dapibus neque odio in enim. Phasellus id felis purus. Proin porttitor eros eu arcu hendrerit venenatis. Nullam feugiat egestas tortor, vel sollicitudin ante ultricies eget. Nunc malesuada et nibh vel sollicitudin. \n Morbi dapibus, elit eget rhoncus consectetur, arcu dui dignissim turpis, ac convallis ante metus ut tortor. Nunc et hendrerit nibh, quis ornare sapien. Maecenas imperdiet eget tortor sagittis maximus. Duis augue sapien, commodo ac maximus vitae, gravida eget odio. Suspendisse iaculis leo et mi mollis vehicula. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam fringilla malesuada maximus. Etiam ultricies, neque ac tristique rhoncus, urna enim lobortis elit, porttitor dictum mauris enim ut libero. Sed augue velit, interdum faucibus lectus non, auctor mattis dolor. Fusce pellentesque ornare est sed ultrices. Suspendisse finibus mi fermentum turpis scelerisque, et mattis erat lacinia. Aenean augue urna, blandit eget aliquet ut, hendrerit nec quam."
          },
          {
             "title":"text 3",
             "text":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce fringilla arcu a ipsum iaculis placerat. Vestibulum quis interdum neque. Nullam diam dui, fermentum ut tempus venenatis, volutpat vitae leo. Nulla facilisi. Aliquam convallis id urna sed vestibulum. Nunc nec mauris eleifend, feugiat lacus vitae, consequat nisi. Suspendisse gravida, metus sed tincidunt fringilla, odio velit ornare augue, id dapibus neque odio in enim. Phasellus id felis purus. Proin porttitor eros eu arcu hendrerit venenatis. Nullam feugiat egestas tortor, vel sollicitudin ante ultricies eget. Nunc malesuada et nibh vel sollicitudin. \nPhasellus aliquet porttitor eros, eu ullamcorper odio ultricies sit amet. Praesent placerat nibh quis nulla iaculis, eu maximus tortor ultricies. Vivamus et elit sed nulla porta ultricies ut blandit elit. Praesent molestie ac risus nec euismod. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut eget elit quis ipsum accumsan dictum. Cras purus erat, faucibus in nisi non, tempor laoreet sapien."
          }
       ]
    }
    """
    
    
}

