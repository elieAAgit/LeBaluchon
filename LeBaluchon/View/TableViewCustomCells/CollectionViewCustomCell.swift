//
//  collectionViewCustomCell.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 20/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class CollectionViewCustomCell: UICollectionViewCell {
    // MARK: - Outlets and Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var weatherForecast: UIImageView!
    @IBOutlet weak var tempForecast: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadius()
    }

    /// Added corner radius to the custom cell
    private func cornerRadius() {
        self.layer.cornerRadius = 15

    }

    /// Display informations in the custom cell
    func forecast(date: String, hour: String, weather: String, temp: String) {
        self.dateLabel.text = date
        self.hour.text = hour
        self.weatherForecast.image = UIImage(named: weather)
        self.tempForecast.text = temp
    }
}
