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
    
    var body: some View {
        Color.black
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                fetchData() // Call the fetchData function when the view appears
            }
            .overlay {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                        ForEach(photos, id: \.self) { photoURL in
                            AsyncImage(url: URL(string: photoURL)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                case .failure:
                                    Text("Failed to load image")
                                        .foregroundStyle(.blue)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 150, height: 150) // Adjust size as needed
                            .padding()
                        }
                    }
                    .padding()
                }
            }
    }
    
    func fetchData() {
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2024-1-1&camera=FHAZ&api_key=rEZh4vntktjhQhknCHNJO6nIbzUWm5Qlc5rojMzF"
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
