//
//  nasaapi.swift
//  Final
//
//  Created by MRAD, SHANE R. on 4/29/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

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
                        }
                    }
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
    }
}

    



//private func getUsers() {
//    guard let apiURL = URL(string: "https://api.weather.gov/alerts/active/count") else { return }
//    let task = URLSession.shared.dataTask(with: apiURL) { data, response, error in
//        if let error = error {
//            print("Error: \(error.localizedDescription)")
//        } else if let data = data {
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(AlertResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.alertResponse = response
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }
//    }
//    task.resume()
//}
