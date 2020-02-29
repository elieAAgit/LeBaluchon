//
//  WeatherServiceTests.swift
//  LeBaluchonTests
//
//  Created by Elie Arquier on 29/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class WeatherServiceTests: XCTestCase {
// MARK: - Prepare tests
    var weather: WeatherService!

    override func setUp() {
        weather = WeatherService()
        ApiKeys.weatherParameters = ""
        ApiKeys.citiesWeatherParameters = ""
    }
}

// MARK: - Test
extension WeatherServiceTests {
    func testGivenAddIcon_WhenIconIsKnown_ThenOperationIsSuccess() {
        let icon = "01d"
        
        let assignIcon = weather.weatherIcons(icon: icon)
        
        XCTAssertEqual(assignIcon, "01d")
    }

    func testGivenAddIcon_WhenIconIsUnknown_ThenOperationFailed() {
        let icon = "test"
        
        let assignIcon = weather.weatherIcons(icon: icon)
        
        XCTAssertEqual(assignIcon, "default")
    }

    func testGivenRequestIsDone_WhenLongitudeAndLatitudeAdded_ThenOperationSucceded() {
        let lon = "2.35"
        let lat = "48.85"

        weather.weatherParameters(lon: lon, lat: lat)
        
        XCTAssertEqual(ApiKeys.weatherParameters, "lat=48.85&lon=2.35")
    }

    func testGivenRequestIsDone_WhenNameCityAdded_ThenOperationSucceded() {
        let city = "Paris"

        weather.citiesSearchParameters(search: city)
        
        XCTAssertEqual(ApiKeys.citiesWeatherParameters, "&namePrefix=Paris")
    }

    func testGivenRequestIsDone_WhenTryDisplaySunHoursAndDay_ThenOperationSucceded() {
        let sunrise = 1582612914.00
        let sunset = 1582651558.00
        var sunriseTime = String()
        var sunsetTime = String()
        var dayTime = String()

        weather.sunriseSunset(sunrise: sunrise, sunset: sunset) { (sunrise, sunset, day) in
            sunriseTime = sunrise
            sunsetTime = sunset
            dayTime = day
        }
        
        XCTAssertEqual(sunriseTime, "07:41")
        XCTAssertEqual(sunsetTime, "06:25")
        XCTAssertEqual(dayTime, "02/25")
    }

    func testGivenRequestIsDone_WhenTryDisplayPrevisionHoursAndDay_ThenOperationSucceded() {
        let prevision = "2020-02-26 03:00:00"
        var dateTime = String()
        var hourTime = String()

        weather.previsionDateAndHour(prevision: prevision) { (date, hour) in
            dateTime = date
            hourTime = hour
        }
        
        XCTAssertEqual(dateTime, "02/26")
        XCTAssertEqual(hourTime, "03")
    }
}
