//
//  ViewController.swift
//  Starter Sunny
//
//  Created by Евгений Сергеевич on 10.01.2021.
//

import UIKit
// import core location
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    // MARK: VAR AND LET
    // create
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager: CLLocationManager = {
       let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    // MARK: METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // create 
        networkWeatherManager.onHandler = { [weak self] currentWeather in
            // call print method
            guard let self = self else { return }
            self.updateUIWith(weather: currentWeather)
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    
    // MARK: METHOD SEARCH PRESSED
    @IBAction func searchPressed(_ sender: UIButton) {
        // call our method when button pressed and enter arguments
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] city in
            // call method fetch current weather
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    // MARK: METHOD UPDATE UI WITH
    func updateUIWith(weather: CurrentWeather) {
        // add dispatchQueue
        DispatchQueue.main.async {
            //
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeLabel.text = weather.feelsLikeString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

// MARK: EXTENSION FOR VIEW CONTROLLER CL LOCATION MANAGER DELEGATE
extension ViewController: CLLocationManagerDelegate {
    
    //
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
        guard let location = locations.last else { return }
        // get letitude
        let latitude = location.coordinate.latitude
        // get logitude
        let logtitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: logtitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
