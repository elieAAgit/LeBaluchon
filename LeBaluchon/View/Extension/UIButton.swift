//
//  UIButton.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 30/01/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

extension UIButton {

    func animated() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            self.transform = .identity
        }
    }
}
