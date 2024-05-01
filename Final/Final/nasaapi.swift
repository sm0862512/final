//
//  nasaapi.swift
//  Final
//
//  Created by MRAD, SHANE R. on 4/29/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var imageData: Data? // Add this line

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2024-1-1&camera=FHAZ&api_key=rEZh4vntktjhQhknCHNJO6nIbzUWm5Qlc5rojMzF"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    if let photos = json["photos"] as? [[String: Any]],
                       let imgSrc = photos.first?["img_src"] as? String,
                       let imgUrl = URL(string: imgSrc),
                       let imageData = try? Data(contentsOf: imgUrl) {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: imageData)
                            self.imageData = imageData // Add this line
                            print(imageData)
                        }
                    }
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}
