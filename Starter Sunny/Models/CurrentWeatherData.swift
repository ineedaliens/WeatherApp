//
//  CurrentWeatherData.swift
//  Starter Sunny
//
//  Created by Евгений Сергеевич on 10.01.2021.
//

import Foundation

// MARK: STRUCT CURRENT WEATHER DATA
// use protocol DECODABLE
struct CurrentWeatherData: Decodable {
    // create constant NAME, MAIN AND WEATHER
    let name: String
    let main: Main
    let weather: [Weather]
    
}

// MARK: STRUCT MAIN
// use protocol DECODABLE
struct Main: Decodable {
    // create constant TEMP AND FEELS LIKE
    let temp: Double
    let feelsLike: Double
    
    // create ENUM
    enum CodingKeys: String, CodingKey {
        // create case temp and feelsLIke with key and use that case in struct main
        case temp
        case feelsLike = "feels_like"
    }
}

// MARK: STRUCT WEATHER
// use protocol DECODABLE
struct Weather: Decodable {
    //create constant ID
    let id: Int
}
