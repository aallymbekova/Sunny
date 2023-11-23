//
//  ViewController.swift
//  Sunny
//
//  Created by darmaraht on 21/11/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    @IBOutlet weak var cityFeelsLikeTemperature: UILabel!
    @IBOutlet weak var cityDescription: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    lazy var locationManager = CLLocationManager()

    override func viewDidLoad() {
        
        startLocationManager()
        
        networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterfaceWith(weather: currentWeather)

        }
    }
    
    func updateInterfaceWith(weather: CurrentWeather) {
        DispatchQueue.main.async {
            
            self.cityName.text = weather.cityName
            self.cityTemperature.text = weather.cityTempratureString + "ºC"
            self.cityFeelsLikeTemperature.text = weather.cityFeelsLikeTempratureString + "ºC"
            self.cityDescription.text = ""
            self.cityImageView.image = UIImage(systemName: weather.systemIconNameString)
            self.cityDescription.text = weather.description
        }
    }
    
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
}
//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
