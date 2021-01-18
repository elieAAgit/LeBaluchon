//
//  WeatherServices.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 18/01/2021.
//  Copyright © 2021 Elie. All rights reserved.
//

import Foundation

class WeatherService {
    let icons = ["01d", "01n", "02d", "02n", "03d", "03n", "04d", "04n", "09d", "09n", "10d", "10n", "11d", "11n", "13d", "13n", "50d", "50n"]

    /// Using only to prevent icon missing to replace by default icon
    func weatherIcons(icon: String) -> String {
        var assign: String

        if icons.contains(icon) {
            assign = icon
        } else {
            assign = "default"
        }

        return assign
    }
}

extension WeatherService {
    func weatherParameters(lon: String, lat: String) {
        ApiKeys.weatherParameters = "lat=\(lat)&lon=\(lon)"
    }
}

extension WeatherService {
    func citiesSearchParameters(search: String) {
        //let searchTreated = search.trimmingCharacters(in: .whitespaces)
        let searchTreated = search.replacingOccurrences(of: " ", with: "+")
        ApiKeys.citiesWeatherParameters = "&namePrefix=\(searchTreated)"
    }
}

extension WeatherService {
    func sunriseSunset(sunrise: Double, sunset: Double, completion: (String, String, String) -> Void) {
        let day = dayTime(dateTime: sunrise)
        let sunrise = sunTime(dateTime: sunrise)
        let sunset = sunTime(dateTime: sunset)

        completion(sunrise, sunset, day)
    }

    func previsionDateAndHour(prevision: String, completion: (String, String) -> Void) {
        let date = dateTime(dateTime: prevision)
        let hour = hourTime(dateTime: prevision)

        completion(date, hour)
    }

    private func dayTime(dateTime: Double) -> String {
        let sunTime = dateConvert(dateTime: dateTime)
        var sun: [String] {
            return sunTime.split(separator: " ").map { "\($0)" }
        }

        var sunDate: [String] {
            return sun[0].split(separator: "-").map { "\($0)" }
        }

        return sunDate[1] + "/" + sunDate[2]
    }

    private func sunTime(dateTime: Double) -> String {
        let sunTime = dateConvert(dateTime: dateTime)

        var sun: [String] {
            return sunTime.split(separator: " ").map { "\($0)" }
        }

        var sunDate: [String] {
            return sun[1].split(separator: ":").map { "\($0)" }
        }

        return sunDate[0] + ":" + sunDate[1]
    }

    private func hourTime(dateTime: String) -> String {
        var sun: [String] {
            return dateTime.split(separator: " ").map { "\($0)" }
        }

        var sunDate: [String] {
            return sun[1].split(separator: ":").map { "\($0)" }
        }

        return sunDate[0]
    }

    private func dateTime(dateTime: String) -> String {
        var sun: [String] {
            return dateTime.split(separator: " ").map { "\($0)" }
        }

        var sunDate: [String] {
            return sun[0].split(separator: "-").map { "\($0)" }
        }

        return sunDate[1] + "/" + sunDate[2]
    }

    private func dateConvert(dateTime: Double) -> String {
        let dateTime = Date(timeIntervalSince1970: dateTime)
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: dateTime)

        return now
    }
}
