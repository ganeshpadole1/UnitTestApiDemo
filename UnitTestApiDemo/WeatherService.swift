//
//  WeatherService.swift
//  UnitTestApiDemo
//
//  Created by Ganesh on 12/07/23.
//

import Foundation

enum WeatherDataError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case jsonParsingError
}

protocol WeatherServiceable {
    func getTemperatureFromCity(_ cityName: String, completion: @escaping (Result<Double, WeatherDataError>) -> Void)
}

struct WeatherService: WeatherServiceable {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getTemperatureFromCity(_ cityName: String, completion: @escaping (Result<Double, WeatherDataError>) -> Void) {
        let weatherApiUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(Constants.apiKey.rawValue)")
        
        guard let weatherApiUrl = weatherApiUrl else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.loadData(from: weatherApiUrl) { data, statusCode, error in
            if let _ = error {
                completion(.failure(.invalidURL))
                return
            }
            
            guard (200...299).contains(statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData.main.temp))
            } catch {
                completion(.failure(.jsonParsingError))
            }
        }
    }
}
