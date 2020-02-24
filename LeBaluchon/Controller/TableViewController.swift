//
//  TableViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 11/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    // MARK: - Outlets and properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    // Properties to pass data between controller
    var segueOrigin: SegueIdentifier?
    var identifier: Identifier?
    var passData: String?

    // properties use with searBar for filtering results of search
    var filtered: [String] = []
    var isFiltering = false

    // Values loading in the tableView
    var table: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        searchBar.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        passData = nil

        loadingTable(identifier: identifier)
    }
}

// MARK: - Loading datas on table
extension TableViewController {
    /// Loading the right table function of User actions
    private func loadingTable(identifier: Identifier?) {
        guard let identifier = identifier else { return }

        // Display languages list
        if identifier == .languageOne || identifier == .languageTwo {
            if LanguageStorage.languageKey.isEmpty {
                // Loading API only if not already loaded
                ApiService.shared.getApiResponse(apiUrl: .languagesUrl) { (success, nil) in
                    if success {
                        self.table = LanguageStorage.languageKey
                        self.tableView.reloadData()
                    } else {
                        Notification.alertPost(alert: .languagesList)
                    }
                }
            } else {
                table = LanguageStorage.languageKey
                tableView.reloadData()
            }

        // Display currencies list
        } else if identifier == .currencyOne || identifier == .currencyTwo {
            // Loading API only if not already loaded
            if CurrencyStorage.currenciesKeys.isEmpty {
                // Currencies name network call
                ApiService.shared.getApiResponse(apiUrl: .currencyListUrl) { (success, nil) in
                    if success {
                        self.table = CurrencyStorage.currenciesKeys
                        self.tableView.reloadData()
                    } else {
                        Notification.alertPost(alert: .currenciesList)
                    }
                }
            } else {
                table = CurrencyStorage.currenciesKeys
                tableView.reloadData()
            }
        }
    }
}

// MARK: - Configure TableView
extension TableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Return all datas or only those resulting from user actions in searchbar
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtered.count
        } else {
            return table.count
        }
    }

    /// Display the result in each cell of the table or filtered table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as? ContentCell else {
            return UITableViewCell()
        }

        var label = ""

        if isFiltering {
            label = filtered[indexPath.row]
        } else {
            label = table[indexPath.row]
        }

        cell.configureCell(label: label)

        return cell
    }
}

// MARK: - Prepare Segue
extension TableViewController: UITableViewDelegate {
    /// Passing data between TableView and origin controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContentCell
        passData = cell.labelCell.text

        let segueDestination = destination()
    
        performSegue(withIdentifier: segueDestination, sender: self)
    }

    /// Controller destination is the same as the origin
    private func destination() -> String {
        if segueOrigin == .translationToList  {
            return SegueIdentifier.listToTranslation.rawValue
        } else if segueOrigin == .changeToList  {
            return SegueIdentifier.ListToChange.rawValue
        } else if segueOrigin == .preferencesToList {
            return SegueIdentifier.listToPreferences.rawValue
        }

        return ""
    }

    /// Prepare segue to pass data and identifier between controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let passData = passData else { return }

        // To translation controller
        if segue.identifier == SegueIdentifier.listToTranslation.rawValue {
            let translationViewController = segue.destination as! TranslationViewController
            translationViewController.identifier = identifier
            translationViewController.passData = passData
        // To change controller
        } else if segue.identifier == SegueIdentifier.ListToChange.rawValue {
            let changeViewController = segue.destination as! ChangeViewController
            changeViewController.identifier = identifier
            changeViewController.passData = passData
        // To user preferences controller: data not passed controller but directly to Userdefaults
        } else if segue.identifier == SegueIdentifier.listToPreferences.rawValue {
            guard let identifier = identifier else { return }

            userPreferences(identifier: identifier)
        } else {
            Notification.alertPost(alert: .errorData)
        }
    }

    /// Userdefaults data destination
    private func userPreferences(identifier: Identifier) {
        guard let passData = passData else { return }
        
        if identifier == .languageOne {
            UserPreferences.languageOne = passData
        } else if identifier == .languageTwo {
            UserPreferences.languageTwo = passData
        } else if identifier == .currencyOne {
            UserPreferences.currencyOne = passData
        } else if identifier == .currencyTwo {
            UserPreferences.currencyTwo = passData
        }
    }
}

// MARK: - SearchBar
extension TableViewController: UISearchBarDelegate {
    /// Preparation of filtering in the searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = table.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased() })
            isFiltering = true
            tableView.reloadData()
    }
}

// MARK: - Keyboard
extension TableViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()

        return true
    }
}
