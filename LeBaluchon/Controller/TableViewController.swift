//
//  TableViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 11/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    //
    var segueName: String?
    var identifier: Identifier?
    var passData: String?

    // properties use with searBar for filtering results of search
    var filtered: [String] = []
    var isFiltering = false

    //
    var table: [String] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

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

extension TableViewController {
    private func loadingTable(identifier: Identifier?) {
        guard let identifier = identifier else { return }

        if identifier == .languageOne || identifier == .languageTwo {
            table = LanguageStorage.languageKey
            segueName = SegueIdentifier.toTranslation.rawValue
        } else if identifier == .currencyOne || identifier == .currencyTwo {
            table = CurrencyStorage.currenciesKeys
        } else {
            // Alert
        }
    }
}

extension TableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtered.count
        } else {
            return table.count
        }
    }
    
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

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ContentCell
        passData = cell.labelCell.text

        guard let segueName = segueName else { return }

        performSegue(withIdentifier: segueName, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let passData = passData else { return }

        if segue.identifier == SegueIdentifier.toTranslation.rawValue {
            let translationViewController = segue.destination as! TranslationViewController
            translationViewController.identifier = identifier
            translationViewController.passData = passData
        } else {
            // Alert
        }
    }
}

extension TableViewController: UISearchBarDelegate {
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
