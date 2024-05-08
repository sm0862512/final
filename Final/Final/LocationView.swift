import SwiftUI

// SwiftUI view to display the location view
struct LocationView: View {
    @StateObject private var weatherFetcher = WeatherFetcher()
    @State private var isPulsating = false

    var body: some View {
        Color.black // Background color
            .edgesIgnoringSafeArea(.all) // Ignore safe area edges
            .overlay( // Overlay navigation link on top of the background color
                NavigationLink(destination: PhotoView()) { // Navigate to PhotoView when tapped
                    ZStack {
                        Text(weatherFetcher.temperatureData.map { "\($0.key): \($0.value)" }.joined(separator: "\n"))
                            .foregroundColor(.orange)
                            .font(.custom("Avenir Next", size: 24))
                            .fontWeight(.bold)
                            .frame(width: 200, height: 100)
                            .position(x: 300, y: 100) // corrected position
                        
                        Text("A Month on Mars")
                            .foregroundColor(.orange)
                            .font(.custom("Avenir Next", size: 24))
                            .fontWeight(.bold)
                            .frame(width: 100, height: 100)
                        
                        // Mars image
                        Image("mars-11012_1280")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 600, height: 300)
                        
                        // Mars rover image with pulsating animation
                        Image("MarsRover2")
                            .resizable()
                            .position() // Position at center
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .scaleEffect(isPulsating ? 0.9 : 1.0) // Scale effect for pulsating animation
                            .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true)) // Repeating animation
                            .onAppear() {
                                self.isPulsating.toggle() // Start pulsating animation when view appears
                                self.weatherFetcher.fetchLatestMarsWeather() // corrected function call
                            }
                    }
                }
            )
    }
}

// Preview for LocationView
#Preview {
    LocationView()
}
