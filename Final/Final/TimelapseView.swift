
//
//  TimelapseView.swift
//  Final
//
//  Created by BALLARD, MATTHEW J. on 5/1/24.
//

import SwiftUI

struct TimelapseResponse: Decodable {
    let photos: [TimelapsePhoto]
}

struct TimelapsePhoto: Decodable {
    let id: Int
    let img_src: String
}

struct TimelapsePhotoView: View {
    
    @State private var photos: [String] = [] // Array to hold photo URLs
    @State private var currentPage: Int = 0 // Index of the currently displayed photo
    
    var body: some View {
        ZStack {
            Color.black
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(photos.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: photos[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width)
                            case .failure:
                                Text("Failed to load image")
                                    .foregroundColor(.blue)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                }
                .offset(x: -CGFloat(currentPage) * UIScreen.main.bounds.width)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            fetchData() // Call the fetchData function when the view appears
            startTimer() // Start the timer when the view appears
        }
    }
    
    func fetchData() {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2023-1-19&camera=FHAZ&api_key=rEZh4vntktjhQhknCHNJO6nIbzUWm5Qlc5rojMzF"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data returned: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.photos = response.photos.compactMap { $0.img_src }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            
                // Increment currentPage index, and reset if it exceeds array bounds
                currentPage = (currentPage + 1) % photos.count
            
        }
    }
}


struct TimelapsePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        TimelapsePhotoView()
    }

}
