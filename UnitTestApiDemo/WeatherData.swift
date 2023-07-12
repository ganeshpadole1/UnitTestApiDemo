//
//  WeatherData.swift
//  UnitTestApiDemo
//
//  Created by Ganesh on 12/07/23.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}
