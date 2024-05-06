//
//  LocationView.swift
//  Final
//
//  Created by BALLARD, MATTHEW J. on 4/29/24.
//

import SwiftUI

struct LocationView: View {
    @StateObject private var weatherFetcher = WeatherFetcher()
    @State private var isPulsating = false

    var body: some View {
        Color.black
            .edgesIgnoringSafeArea(.all)
            .overlay(
                NavigationLink(destination: PhotoView()) {
                    ZStack {
                        Text(weatherFetcher.temperatureData.map { "\($0.key): \($0.value)" }.joined(separator: "\n"))
                            .foregroundColor(.orange)
                            .font(.custom("Avenir Next", size: 24))
                            .fontWeight(.bold)
                            .frame(width: 100, height: 100)
                            .position(x: 200, y: 100) // corrected position
                        
                        Text("A Month on Mars")
                            .foregroundColor(.orange)
                            .font(.custom("Avenir Next", size: 24))
                            .fontWeight(.bold)
                            .frame(width: 100, height: 100)

                        Image("mars-11012_1280")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 600, height: 300)

                        Image("MarsRover2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .scaleEffect(isPulsating ? 0.9 : 1.0)
                            .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true))  // Repeating animation
                            .onAppear() {
                                self.isPulsating.toggle() // Start pulsating animation when view appears
                                self.weatherFetcher.fetchLatestMarsWeather() // corrected function call
                            }
                    }
                }
            )
    }
}




#Preview {
    LocationView()
}
