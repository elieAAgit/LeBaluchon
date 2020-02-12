//
//  TableViewController.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 11/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        searchBar.delegate = self
    }
}

extension TableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }
}

// MARK: - Keyboard
extension TableViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()

        return true
    }
}
