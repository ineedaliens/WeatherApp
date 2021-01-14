//
//  NetworkWeatherManager.swift
//  Starter Sunny
//
//  Created by Евгений Сергеевич on 10.01.2021.
//

import UIKit
import CoreLocation

// MARK: STRUCT NETWORK WEATHER MANAGER
class NetworkWeatherManager {
    
    // create enum for universaly method
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    // create closure
    var onHandler: ((CurrentWeather) -> Void)?
    
    
    //
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city): urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude): urlString = "https://api.openweathermap.org/data/2.5/find?lat={\(latitude)}&lon={\(longitude)}&cnt={cnt}&appid=\(apiKey)"
        }
        performRequest(withURLString: urlString)
    }
    

    
    // create new method
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        // create session
        let session = URLSession(configuration: .default)
        // create task session
        let task = session.dataTask(with: url) { (data, responce, error) in
            // check data and get json data
            if let data = data {
                // call method parse json with enter argument data
                if let currentWeather = self.parseJSON(withData: data) {
                    // use our closure
                    self.onHandler?(currentWeather)
                }
            }
        }
        // call method resume()
        task.resume()
    }
    
    // MARK: FILE PRIVATE METHOD PARSE JSON
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        // create decoder of JSON
        let decoder = JSONDecoder()
        // use do catch block
        do {
            // create constant and call try and call decode method enter our stuct and data
            let currentWeatherData =  try decoder.decode(CurrentWeatherData.self, from: data)
            // use guard
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            // return current weather
            return currentWeather
        } catch let error as NSError {
            // call method show error
            print(error.localizedDescription)
        }
        // return nil
        return nil
    }
}
