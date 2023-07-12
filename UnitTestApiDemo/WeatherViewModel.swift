//
//  WeatherViewModel.swift
//  UnitTestApiDemo
//
//  Created by Ganesh on 12/07/23.
//

import Foundation

final class WeatherViewModel {
    private let defaultCity = Constants.localCity.rawValue
    private let weatherService: WeatherServiceable
    
    var temperatureChanged: ((String) -> Void)?
    
    init(weatherService: WeatherServiceable) {
        self.weatherService = weatherService
    }
    
    func onStart() {
        temperatureChanged?("The current temperature in \(defaultCity) is unknown atm.")
    }
    
    func getCurrentTemperature() {
        weatherService.getTemperatureFromCity(defaultCity) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let temperature):
                self.temperatureChanged?("The current temperature in \(self.defaultCity) is \(temperature) °C.")
            case .failure(let error):
                self.temperatureChanged?("The current temperature in \(self.defaultCity) is unknown due to \(error).")
            }
        }
    }
}
