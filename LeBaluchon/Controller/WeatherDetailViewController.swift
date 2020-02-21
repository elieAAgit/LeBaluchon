//
//  WeatherDetailViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 19/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    // MARK: - Outlets and properties
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var weatherCity: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var degre: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    /// Instance of WeatherService
    var weather = WeatherService()

    var forecast: WeatherForecast?
    var lon: String?
    var lat: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        weatherDetailLoading()
    }
}

// MARK: - Loading Apis for selected city weather details and five days previsions
extension WeatherDetailViewController {
    /// To make network calls
    private func weatherDetailLoading() {
        guard let lon = lon else { return }
        guard let lat = lat else { return }

        // Add parameters to url
        weather.weatherParameters(lon: lon, lat: lat)

        /// Weather details network call
        ApiService.shared.getApiResponse(apiUrl: .weatherSingleIdUrl) { (success, city) in
            if success, let city = city as? Weather {
                self.displayWeather(city: city)
                /// Five days previsions network call
                ApiService.shared.getApiResponse(apiUrl: .weatherForecastUrl) { (success, forecast) in
                    if success, let forecast = forecast as? WeatherForecast {
                        self.forecast = forecast
                        self.collectionView.reloadData()
                    } else {
                        Notification.alertPost(alert: .cityForecast)
                    }
                }
            } else {
                Notification.alertPost(alert: .citiesDisplay)
            }
        }
    }

    /// Display the results of the weather details
    private func displayWeather(city: Weather) {
        let icon = weather.weatherIcons(icon: city.weather[0].icon)

        // Decrypts the date format
        weather.sunriseSunset(sunrise: city.sys.sunrise, sunset: city.sys.sunset) { (sunriseTime, sunsetTime, dayTime) in
            sunrise.text = sunriseTime + " GMT"
            sunset.text = sunsetTime + " GMT"
            day.text = dayTime
        }

        // Display results
        cityName.text = city.name
        weatherCity.image = UIImage(named: icon)
        temp.text = String(format: "%.0f", city.main.temp) + " C"
        feelsLike.text = String(format: "%.0f", city.main.feels_like)
        describe.text = city.weather[0].description
        pressure.text = "Pression: " + String(format: "%.0f", city.main.pressure) + " hPa"
        humidity.text = "Humidité: " + String(format: "%.0f", city.main.humidity) + "%"
        wind.text = "Vent: " + String(format: "%.0f", city.wind.speed) + " M/S"
        degre.text = "Nuageux: " + String(format: "%.0f", city.clouds.all) + "%"
    }
}

// MARK: - Collection view
extension WeatherDetailViewController: UICollectionViewDataSource {
    /// Number of section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    /// Number of collectionViewCells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast?.list.count ?? 0
    }

    /// Display the results of the five days prevision
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? CollectionViewCustomCell else {
            return UICollectionViewCell()
        }

        guard let forecast = forecast?.list[indexPath.row] else { return UICollectionViewCell() }

        var date = String()
        var hour = String()
        let temp = String(format: "%.0f", forecast.main.temp)
        let icon = weather.weatherIcons(icon: forecast.weather[0].icon)

        // Decrypts the date format
        weather.previsionDateAndHour(prevision: forecast.dt_txt) { (dateTime, hourTime) in
            date = dateTime
            hour = hourTime + " GMT"
        }

        // Displays the result in the custom cell
        cell.forecast(date: date, hour: hour, weather: icon, temp: temp)

        return cell
    }
}
