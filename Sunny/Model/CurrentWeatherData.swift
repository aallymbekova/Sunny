//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by darmaraht on 22/11/23.
//

import Foundation

struct CurrentWeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
}


// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
}
