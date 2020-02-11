//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 08/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    var weatherIcon = WeatherIcons()

    //
    @IBOutlet weak var cityOne: UIButton!
    @IBOutlet weak var weatherCityOne: UIImageView!
    @IBOutlet weak var minCityOne: UILabel!
    @IBOutlet weak var maxCityOne: UILabel!
    //
    @IBOutlet weak var cityTwo: UIButton!
    @IBOutlet weak var weatherCityTwo: UIImageView!
    @IBOutlet weak var minCityTwo: UILabel!
    @IBOutlet weak var maxCityTwo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherLoading()
    }
}

extension WeatherViewController {
    private func weatherLoading() {
        ApiService.shared.getApiResponse(apiUrl: .weatherMultipleIdUrl) { (success, cities) in
            if success, let cities = cities as? WeatherMultiple {
                self.displayWeather(cities: cities)
            } else {
                // Alert
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
    }
}
