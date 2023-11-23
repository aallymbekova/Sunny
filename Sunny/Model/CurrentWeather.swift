//
//  CurrentWeather.swift
//  Sunny
//
//  Created by darmaraht on 22/11/23.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let cityTemprature: Double
    var cityTempratureString: String {
        return String(format: "%.0f", cityTemprature)
    }
    
    let cityFeelsLikeTemprature: Double
    var cityFeelsLikeTempratureString: String {
        return String(format: "%.0f", cityFeelsLikeTemprature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    let description: String
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        cityTemprature = currentWeatherData.main.temp
        cityFeelsLikeTemprature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
        description = DataSource.weatherIDs[currentWeatherData.weather[0].id] ?? ""
    }
    
}
