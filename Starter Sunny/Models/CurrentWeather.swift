//
//  CurrentWeather.swift
//  Starter Sunny
//
//  Created by Евгений Сергеевич on 10.01.2021.
//

import Foundation

// MARK: STRUCT CURRENT WEATHER
struct CurrentWeather {
    // create constant
    let cityName: String
    
    let temperature: Double
    // create atributes
    var temperatureString: String {
        // return STRING with method rounded for rounded value
        return String(format: "%.0f", temperature)
    }
    
    let feelsLike: Double
    // create atributes
    var feelsLikeString: String {
        // return STRING with method rounded for rounded value
        return String(format: "%.0f", temperature)
    }
    
    let conditionCode: Int
    // create
    var systemIconNameString: String {
        // create switch
        switch conditionCode {
        // icons for our image weather icon view controller
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 700...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
    
    //
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLike = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
