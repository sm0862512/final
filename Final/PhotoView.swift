import SwiftUI

struct Response: Decodable {
    let photos: [Photo]
}

struct Photo: Decodable {
    let id: Int
    let img_src: String
}

struct PhotoView: View {
    
    @State private var photos: [String] = [] // Array to hold photo URLs
    @State private var currentPage: Int = 0 // Index of the currently displayed photo
    
    var body: some View {
        ZStack {
            Color.black
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(photos.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: photos[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView(value: 0.75)
                                    .foregroundColor(.orange)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width)
                            case .failure:
                                Text("Failed to load image")
                                    .foregroundColor(.orange)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                }
                .offset(x: -CGFloat(currentPage) * UIScreen.main.bounds.width)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let horizontalSwipeMagnitude = value.translation.width
                            if horizontalSwipeMagnitude < 0 {
                                // Swiped to the left
                                if currentPage < photos.count - 1 {
                                    currentPage += 1
                                }
                            } else if horizontalSwipeMagnitude > 0 {
                                // Swiped to the right
                                if currentPage > 0 {
                                    currentPage -= 1
                                }
                            }
                        }
                )
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            fetchData() // Call the fetchData function when the view appears
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
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
