//
//  HeaderCell.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 17/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

//Configuration of the header of the preferences list
class HeaderCell: UITableViewHeaderFooterView {
    // MARK: - Properties
    let view = UIView()
    let title = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configure view and title
    func configureContents() {
        // Background color
        self.backgroundView = view
        view.backgroundColor = UIColor(red: 255/255, green: 152/255, blue: 0/255, alpha: 1)
        //title color and font
        title.textColor = UIColor.white
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(title)

        // Constrain its width and height to 100 points.
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.widthAnchor.constraint(equalToConstant: 100),
            title.heightAnchor.constraint(equalToConstant: 50),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    /// Display section titles
    func sectionsTitles(section: Int) {
        title.text = UserPreferences.sections[section]
    }
}
