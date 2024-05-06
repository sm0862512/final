//
//  TimelapseView.swift
//  Final
//
//  Created by BALLARD, MATTHEW J. on 5/1/24.
//

import SwiftUI

// Struct to represent the response from the API
struct TimelapseResponse: Decodable {
    let photos: [TimelapsePhoto]
}

// Struct to represent individual photos
struct TimelapsePhoto: Decodable {
    let id: Int
    let img_src: String
}

// SwiftUI view to display photos in a timelapse view
struct TimelapsePhotoView: View {
    
    // State variables to manage UI state
    @State private var photos: [String] = [] // Array to hold photo URLs
    @State private var currentPage: Int = 0 // Index of the currently displayed photo
    @Binding public var selectedDate: Date // Binding to hold selected date
    
    var body: some View {
        ZStack {
            Color.black // Background color
            
            // ScrollView to display photos horizontally
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(photos.indices, id: \.self) { index in
                        // Asynchronously load images from URLs
                        AsyncImage(url: URL(string: photos[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView() // Placeholder while loading
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
            fetchData() // Fetch data when the view appears
            startTimer() // Start the timer when the view appears
        }
    }
    
    // Function to fetch photos from the API based on selected date
    func fetchData() {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(selectedDate)&camera=FHAZ&api_key=rEZh4vntktjhQhknCHNJO6nIbzUWm5Qlc5rojMzF"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data returned: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TimelapseResponse.self, from: data)
                DispatchQueue.main.async {
                    self.photos = response.photos.compactMap { $0.img_src }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // Function to start a timer for automatic photo switching
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            // Increment currentPage index, and reset if it exceeds array bounds
            currentPage = (currentPage + 1) % photos.count
        }
    }
}

//struct TimelapsePhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimelapsePhotoView(selectedDate: )
//    }
//}
