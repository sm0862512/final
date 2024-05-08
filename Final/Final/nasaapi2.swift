import Foundation

class WeatherFetcher: ObservableObject {
    @Published var temperatureData: [String: Double] = [:]

    func fetchLatestMarsWeather() {
        let weatherUrlString = "https://mars.nasa.gov/rss/api/?feed=weather&category=insight_temperature&feedtype=json&ver=1.0"
        guard let weatherUrl = URL(string: weatherUrlString) else { return }

        URLSession.shared.dataTask(with: weatherUrl) { (data, response, error) in
            guard let data = data else { return }
            var latestTemperature: Double?
            do {
                if let weatherJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any],
                   let solKeys = weatherJson["sol_keys"] as? [String] {
                    let sortedSolKeys = solKeys.sorted(by: >) // sort in descending order
                    for sol in sortedSolKeys {
                        if let temperatureData = weatherJson[sol] as? [String: Any],
                           let atmosphericTemperature = temperatureData["AT"] as? [String: Double],
                           let averageTemperature = atmosphericTemperature["av"] {
                            latestTemperature = averageTemperature
                            break // break after getting the latest temperature
                        }
                    }
                }
            } catch let jsonErr {
                print("Error fetching Mars weather data:", jsonErr)
            }
            DispatchQueue.main.async {
                self.temperatureData = ["Latest Temp": latestTemperature ?? 0.0]
            }
        }.resume()
    }

}
