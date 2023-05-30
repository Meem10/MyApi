//
//  WeatherView.swift
//  MyApi
//
//  Created by Mohammed on 10/11/1444 AH.
//

import SwiftUI

struct Weather: Codable {
    let temperature: Double
    let description: String
    let iconName: String

    enum CodingKeys: String, CodingKey {
        case temperature = "main.temp"
        case description = "weather.0.description"
        case iconName = "weather.0.icon"
    }
}

struct WeatherView: View {
    @State var weather = [Weather]()

    var body: some View {
        VStack {
            
//                .font(.system(size: 60))
            
        
        }
        .onAppear {
            fetchWeatherData()
        }
    }
    
    func fetchWeatherData() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Berlin&appid=YOUR_API_KEY&units=metric") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([Weather].self, from: data)
                    DispatchQueue.main.async {
                        self.weather = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            } else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}





struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
