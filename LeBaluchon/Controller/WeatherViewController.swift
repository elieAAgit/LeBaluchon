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
    var weatherIcon = WeatherService()
    //
    var lon: String?
    var lat: String?
    var cityOneLon = String()
    var cityOneLat = String()
    var cityTwoLon = String()
    var cityTwoLat = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        /// To display alert if needed
        NotificationCenter.default.addObserver(self, selector: #selector(actionAlert(notification:)), name: .alertName, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        weatherLoading()
    }

    /// Segue to come back to WeatherViewController
    @IBAction func unwindtoChangeViewController(segue: UIStoryboardSegue) {
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
        let listOne = cities.list[0]
        let listTwo = cities.list[1]
        let iconOne = weatherIcon.weatherIcons(icon: listOne.weather[0].icon)
        let iconTwo = weatherIcon.weatherIcons(icon: listTwo.weather[0].icon)

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
    }
}

extension WeatherViewController {
    @IBAction func detailButttonDidTap(_ sender: UIButton) {
        sender.animated()

        lonlat(sender: sender)

        performSegue(withIdentifier: SegueIdentifier.weatherToDetail.rawValue, sender: self)
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
        } else {
            Notification.alertPost(alert: .errorData)
        }
    }
}
