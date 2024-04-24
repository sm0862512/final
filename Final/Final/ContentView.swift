//
//  ContentView.swift
//  Final
//
//  Created by SANDERS, CADEN P. on 4/24/24.
//

import SwiftUI




private func getData() {
    guard let apiURL = URL(string: "https://api.nasa.gov/insight_weather/?api_key=rEZh4vntktjhQhknCHNJO6nIbzUWm5Qlc5rojMzF&feedtype=json&ver=1.0") else { return }
    let task = URLSession.shared.dataTask(with: apiURL) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        } else if let data = data {
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(AlertResponse.self, from: data)//need to add struct up top then redefine 'AlertResponse'
                DispatchQueue.main.async {
                    self.alertResponse = response //once struct is added this should be resolved
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
    }
    task.resume()
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Test")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
