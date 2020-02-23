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
            return SegueIdentifier.toWeather.rawValue
        } else if segueOrigin == .preferencesToSearch  {
            return SegueIdentifier.toChange.rawValue
        }

        return ""
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.toWeather.rawValue {
            let weatherViewController = segue.destination as! WeatherViewController
            weatherViewController.identifier = identifier
            weatherViewController.data = data
        } else if segue.identifier == SegueIdentifier.searchToPreferences.rawValue {
            let preferencesViewController = segue.destination as! UserPreferencesViewController
            preferencesViewController.identifier = identifier
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
