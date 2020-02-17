//
//  ContentCell.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 11/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var labelCell: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    /// Display right label
    func configureCell(label: String) {
        labelCell.text = label
    }

}
