//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 08/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - Outlets and properties
    @IBOutlet weak var cityOne: UIButton!
    @IBOutlet weak var weatherCityOne: UIImageView!
    @IBOutlet weak var minCityOne: UILabel!
    @IBOutlet weak var maxCityOne: UILabel!

    @IBOutlet weak var cityTwo: UIButton!
    @IBOutlet weak var weatherCityTwo: UIImageView!
    @IBOutlet weak var minCityTwo: UILabel!
    @IBOutlet weak var maxCityTwo: UILabel!

    //
    var weather = WeatherService()
    //
    var segueOrigin: SegueIdentifier = .weatherToSearch
    var identifier: Identifier?
    //
    var data: [String: String] = [:]
    var lon: String?
    var lat: String?
    var cityOneLon = String()
    var cityOneLat = String()
    var cityTwoLon = String()
    var cityTwoLat = String()

    var userPreferencesOne = String()
    var userPreferencesTwo = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherLoading()

        /// To display alert if needed
        NotificationCenter.default.addObserver(self, selector: #selector(actionAlert(notification:)), name: .alertName, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        weatherReloading()
    }

    /// Segue to come back to WeatherViewController
    @IBAction func unwindtoWeatherViewController(segue: UIStoryboardSegue) {
    }
}

extension WeatherViewController {
    private func weatherLoading() {
        ApiService.shared.getApiResponse(apiUrl: .weatherMultipleIdUrl) { (success, cities) in
            if success, let cities = cities as? WeatherMultiple {
                self.displayWeather(cities: cities)
            } else {
                Notification.alertPost(alert: .citiesDisplay)
            }
        }
    }

    private func displayWeather(cities: WeatherMultiple) {
        if cities.list.count >= 2 {
            let listOne = cities.list[0]
            let listTwo = cities.list[1]
            let iconOne = weather.weatherIcons(icon: listOne.weather[0].icon)
            let iconTwo = weather.weatherIcons(icon: listTwo.weather[0].icon)

            cityOne.setTitle(listOne.name, for: .normal)
            weatherCityOne.image = UIImage(named: iconOne)
            minCityOne.text = String(format: "%.0f", listOne.main.temp_min)
            maxCityOne.text = String(format: "%.0f", listOne.main.temp_max)

            //
            cityTwo.setTitle(listTwo.name, for: .normal)
            weatherCityTwo.image = UIImage(named: iconTwo)
            minCityTwo.text = String(format: "%.0f", listOne.main.temp_min)
            maxCityTwo.text = String(format: "%.0f", listOne.main.temp_max)

            //
            cityOneLon = String(listOne.coord.lon)
            cityOneLat = String(listOne.coord.lat)
            cityTwoLon = String(listTwo.coord.lon)
            cityTwoLat = String(listTwo.coord.lat)

            //
            userPreferencesOne = listOne.name
            userPreferencesTwo = listTwo.name
        } else {
            Notification.alertPost(alert: .citiesDisplay)
        }
    }

    /// To make network calls
    private func weatherReloading() {
        if data != [:] {
            reloadingToList()
        } else if userPreferencesOne != UserPreferences.cityOne {
            guard let name = UserPreferences.cityOneData["name"] else { return }
            guard let lon = UserPreferences.cityOneData["lon"] else { return }
            guard let lat = UserPreferences.cityOneData["lat"] else { return }
            identifier = .cityOne

            reloadingToPreferences(lon: lon, lat: lat)

            userPreferencesOne = name
        } else if userPreferencesTwo != UserPreferences.cityTwo {
            guard let name = UserPreferences.cityTwoData["name"] else { return }
            guard let lon = UserPreferences.cityTwoData["lon"] else { return }
            guard let lat = UserPreferences.cityTwoData["lat"] else { return }
            identifier = .cityTwo

            reloadingToPreferences(lon: lon, lat: lat)

            userPreferencesTwo = name
        }
    }

    private func reloadingToList() {
        guard let cityName = data["name"] else { return }
        guard let lon = data["lon"] else { return }
        guard let lat = data["lat"] else { return }

        if cityName != self.cityOne.currentTitle || cityName != self.cityTwo.currentTitle {
            // Add parameters to url
            weather.weatherParameters(lon: lon, lat: lat)

            networlCall()
        }
    }
    
    private func reloadingToPreferences(lon: String, lat: String) {
        // Add parameters to url
        weather.weatherParameters(lon: lon, lat: lat)

        networlCall()
    }

    private func networlCall() {
        /// Weather details network call
        ApiService.shared.getApiResponse(apiUrl: .weatherSingleIdUrl) { (success, city) in
            if success, let city = city as? Weather {
                self.displayReload(city: city)
                self.data = [:]
            } else {
                Notification.alertPost(alert: .citiesDisplay)
            }
        }
    }

    private func displayReload(city: Weather) {
        let icon = weather.weatherIcons(icon: city.weather[0].icon)

        if identifier == .cityOne {
            cityOne.setTitle(city.name, for: .normal)
            weatherCityOne.image = UIImage(named: icon)
            minCityOne.text = String(format: "%.0f", city.main.temp_min)
            maxCityOne.text = String(format: "%.0f", city.main.temp_max)
            cityOneLon = String(city.coord.lon)
            cityOneLat = String(city.coord.lat)
        } else if identifier == .cityTwo {
            cityTwo.setTitle(city.name, for: .normal)
            weatherCityTwo.image = UIImage(named: icon)
            minCityTwo.text = String(format: "%.0f", city.main.temp_min)
            maxCityTwo.text = String(format: "%.0f", city.main.temp_max)
            cityTwoLon = String(city.coord.lon)
            cityTwoLat = String(city.coord.lat)
        }
    }
}

extension WeatherViewController {
    @IBAction func cityButtonDidTap(_ sender: UIButton) {
        identifier(sender: sender)

        performSegue(withIdentifier: SegueIdentifier.weatherToSearch.rawValue, sender: self)
    }

    @IBAction func detailButttonDidTap(_ sender: UIButton) {
        sender.animated()

        lonlat(sender: sender)

        performSegue(withIdentifier: SegueIdentifier.weatherToDetail.rawValue, sender: self)
    }

    private func identifier(sender: UIButton) {
        if sender.title(for: .normal) == cityOne.title(for: .normal) {
            identifier = .cityOne
        } else if sender.title(for: .normal) == cityTwo.title(for: .normal) {
            identifier = .cityTwo
        }
    }

    /// Identify longitude and latitude
    private func lonlat(sender: UIButton) {
        // tag 1 = city one, tag 2 = target two
        if sender.tag == 1 {
            lon = cityOneLon
            lat = cityOneLat
        } else if sender.tag == 2 {
            lon = cityTwoLon
            lat = cityTwoLat
        }
    }

    /// Pass identifier to the next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.weatherToDetail.rawValue {
            let weatherDetailViewController = segue.destination as! WeatherDetailViewController
            weatherDetailViewController.lon = lon
            weatherDetailViewController.lat = lat
        } else if segue.identifier == SegueIdentifier.weatherToSearch.rawValue {
            let searchCityViewController = segue.destination as! SearchCityViewController
            searchCityViewController.identifier = identifier
            searchCityViewController.segueOrigin = segueOrigin
        } else {
            Notification.alertPost(alert: .errorData)
        }
    }
}
