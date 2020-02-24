//
//  SalientButton.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 30/01/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

class SalientButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 25
    }
}
