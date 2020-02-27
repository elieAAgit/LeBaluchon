//
//  SearchCityViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 21/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController {
    // MARK: - Outlets and porperties
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchCity: UITextField!
    @IBOutlet weak var searchCityTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    var weather = WeatherService()

    var searchList: CitiesList?
    var identifier: Identifier?
    var segueOrigin: SegueIdentifier?
    //
    var data: [String: String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        searchCity.delegate = self
        searchCityTableView.dataSource = self
        searchCityTableView.delegate = self
        
        searchView.layer.cornerRadius = 15
        searchButton.layer.cornerRadius = 5
    }
}

extension SearchCityViewController {
    @IBAction func buttonSearchDidTap(_ sender: UIButton) {
        sender.animated()

        guard let search = searchCity.text else { return }

        weather.citiesSearchParameters(search: search)

        ApiService.shared.getApiResponse(apiUrl: .citiesListUrl) { (success, cities) in
            guard let cities = cities as? CitiesList else { return }

            self.searchList = cities
            self.searchCityTableView.reloadData()
        }

        hideKeyboard()
    }
}

extension SearchCityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") else {
            return UITableViewCell()
        }

        guard let name = searchList?.data[indexPath.row].name else {
            return UITableViewCell()
        }

        guard let country = searchList?.data[indexPath.row].country else {
            return UITableViewCell()
        }

        cell.textLabel?.text = name + ", " + country

        return cell
    }
}

extension SearchCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lon = searchList?.data[indexPath.row].longitude else { return }
        guard let lat = searchList?.data[indexPath.row].latitude else { return }

        data["name"] = searchList?.data[indexPath.row].name
        data["lon"] = String(lon)
        data["lat"] = String(lat)

        let segueDestination = destination()

        performSegue(withIdentifier: segueDestination, sender: self)
    }

    /// Controller destination is the same as the origin
    private func destination() -> String {
        if segueOrigin == .weatherToSearch {
            return SegueIdentifier.searchToWeather.rawValue
        } else if segueOrigin == .preferencesToSearch  {
            return SegueIdentifier.searchToPreferences.rawValue
        }
        return ""
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.searchToWeather.rawValue {
            let weatherViewController = segue.destination as! WeatherViewController
            weatherViewController.identifier = identifier
            weatherViewController.data = data
        } else if segue.identifier == SegueIdentifier.searchToPreferences.rawValue {
            guard let identifier = identifier else { return }

            userPreferences(identifier: identifier)
        }
    }

    /// Userdefaults data destination
    private func userPreferences(identifier: Identifier) {
        guard let cityName = data["name"] else { return }
        guard let cityLon = data["lon"] else { return }
        guard let cityLat = data["lat"] else { return }

        if identifier == .cityOne {
            UserPreferences.cityOneData["name"] = cityName
            UserPreferences.cityOneData["lon"] = cityLon
            UserPreferences.cityOneData["lat"] = cityLat
            UserPreferences.cityOne = cityName
            userpreferencesCityId(identifier: identifier, lon: cityLon, lat: cityLat)
        } else if identifier == .cityTwo {
            UserPreferences.cityTwoData["name"] = cityName
            UserPreferences.cityTwoData["lon"] = cityLon
            UserPreferences.cityTwoData["lat"] = cityLat
            UserPreferences.cityTwo = cityName
            userpreferencesCityId(identifier: identifier, lon: cityLon, lat: cityLat)
        }
    }

    private func userpreferencesCityId(identifier: Identifier, lon: String, lat: String) {
        // Add parameters to url
        weather.weatherParameters(lon: lon, lat: lat)

        /// Weather details network call
        ApiService.shared.getApiResponse(apiUrl: .weatherSingleIdUrl) { (success, city) in
            if success, let city = city as? Weather {
                if identifier == .cityOne {
                    UserPreferences.cityOneId = String(city.id)
                } else if identifier == .cityTwo {
                    UserPreferences.cityTwoId = String(city.id)
                }
            } else {
                Notification.alertPost(alert: .errorData)
            }
        }
    }
}

// MARK: - Keyboard
extension SearchCityViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()

        return true
    }

    private func hideKeyboard() {
        searchCity.resignFirstResponder()
    }
}
