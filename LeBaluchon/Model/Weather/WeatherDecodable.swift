//
//  Weather.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 09/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import Foundation

/// Structure for request with one id
struct Weather: Decodable {
    var coord: Coord
    var weather: [WeatherInner]
    var base: String
    var main: Main
    var visibility: Double
    var wind: Wind
    var clouds: Clouds
    var dt: Double
    var sys: Sys
    var timezone: Double
    var id: Double
    var name: String
    var cod: Double
}

/// Structure for request with multiple id
struct WeatherMultiple: Decodable {
    let cnt: Double
    let list: [WeatherList]
}

/// Structure for five days previsions
struct WeatherForecast: Decodable {
    var cod: String
    var message: Int
    var cnt: Int
    var list: [previsionList]
    var city: City
}

// MARK: - Single request in one network call
struct Coord: Decodable {
    let lon: Double
    let lat: Double
}


struct WeatherInner: Decodable  {
    let id: Double
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let humidity: Double
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
}

struct Clouds: Decodable {
    let all: Double
}

struct Sys: Decodable {
    let type: Double
    let id: Double
    let country: String
    let sunrise: Double
    let sunset: Double
}

// MARK: - Multiple requests in one network call adaptations
struct WeatherList: Decodable {
    var coord: Coord
    var sys: SysMulti
    var weather: [WeatherInner]
    var main: Main
    var visibility: Double
    var wind: Wind
    var clouds: Clouds
    var dt: Double
    var id: Double
    var name: String
}

struct SysMulti: Decodable {
    let country: String
    let timezone: Double
    let sunrise: Double
    let sunset: Double
}

// MARK: -
struct previsionList: Decodable {
    let dt: Int
    let main: MainPrevision
    let weather: [WeatherInner]
    let clouds: Clouds
    let wind: Wind
    let sys: SysPrevision
    let dt_txt: String
}

struct MainPrevision: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double
    let sea_level: Double
    let grnd_level: Double
    let humidity: Double
    let temp_kf: Double
}

struct SysPrevision: Decodable {
    let pod: String
}

struct City: Decodable {
    var id: Int
    var name: String
    var coord: Coord
    let country: String
    var population: Double
    var timezone: Int
    var sunrise: Int
    var sunset: Int
}
