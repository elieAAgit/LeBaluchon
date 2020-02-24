//
//  UserPreferencesViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 15/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class UserPreferencesViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var languageOne: UILabel!
    @IBOutlet weak var languageTwo: UILabel!
    @IBOutlet weak var currencyOne: UILabel!
    @IBOutlet weak var currencyTwo: UILabel!
    @IBOutlet weak var cityOne: UILabel!
    @IBOutlet weak var cityTwo: UILabel!

    // Properties to pass data between controller
    var segueOrigin: SegueIdentifier?
    var identifier: Identifier?
    var passData: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the custom header view
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")

        /// To display alert if needed
        NotificationCenter.default.addObserver(self, selector: #selector(actionAlert(notification:)), name: .alertName, object: nil)

        loadingPreferences()
    }

    override func viewDidAppear(_ animated: Bool) {
        loadingPreferences()
    }

    /// Segue to come back to PreferencesPreferencesUserViewController
    @IBAction func unwindtoPreferencesViewController(segue: UIStoryboardSegue) {
    }
}

// MARK: - Loading preferences and APIs
extension UserPreferencesViewController {
    /// Display the user's preferred items
    private func loadingPreferences() {
        languageOne.text = UserPreferences.languageOne
        languageTwo.text = UserPreferences.languageTwo
        currencyOne.text = UserPreferences.currencyOne
        currencyTwo.text = UserPreferences.currencyTwo
        cityOne.text = UserPreferences.cityOne
        cityTwo.text = UserPreferences.cityTwo
    }
}

// MARK: - Custom header sections
extension UserPreferencesViewController {
    /// Custom header sections
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as? HeaderCell else {
            return UITableViewHeaderFooterView()
        }

        // Display title of each sections
        header.sectionsTitles(section: section)

        return header
    }

    /// Custom height header sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: - Prepare Segues
extension UserPreferencesViewController {
    /// prepare segue 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }

        let segueDestination = assignIdentifierAndSegueDestination(cell: cell)

        performSegue(withIdentifier: segueDestination, sender: self)
    }

    /// Selected the right identifier for the segue to TableViewController
    private func assignIdentifierAndSegueDestination(cell: UITableViewCell) -> String {
        guard let cellLabel = cell.textLabel?.text else { return "" }
        
        if cellLabel == "Langue 1" {
            identifier = .languageOne
        } else if cellLabel == "Langue 2" {
            identifier = .languageTwo
        } else if cellLabel == "Devise 1" {
            identifier = .currencyOne
        } else if cellLabel == "Devise 2" {
            identifier = .currencyTwo
        } else if cellLabel == "Ville 1" {
            identifier = .cityOne
        } else if cellLabel == "Ville 2" {
            identifier = .cityTwo
        }

        switch identifier {
            case .languageOne, .languageTwo, .currencyOne, .currencyTwo:
                segueOrigin = SegueIdentifier.preferencesToList
                return SegueIdentifier.preferencesToList.rawValue
            case .cityOne, .cityTwo:
                segueOrigin = SegueIdentifier.preferencesToSearch
                return SegueIdentifier.preferencesToSearch.rawValue
            case .none:
                return ""
        }
    }

    /// Pass identifiers to the next controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.preferencesToList.rawValue {
            let tableViewController = segue.destination as! TableViewController
            tableViewController.identifier = identifier
            tableViewController.segueOrigin = segueOrigin
        } else if segue.identifier == SegueIdentifier.preferencesToSearch.rawValue {
            let searchViewController = segue.destination as! SearchCityViewController
            searchViewController.identifier = identifier
            searchViewController.segueOrigin = segueOrigin
        } else {
            Notification.alertPost(alert: .errorData)
        }
    }
}
