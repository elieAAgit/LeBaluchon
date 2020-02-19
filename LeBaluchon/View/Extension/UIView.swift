//
//  UIView.swift
//  LeBaluchon
//
//  Created by Elie Arquier on 18/02/2020.
//  Copyright © 2020 Elie. All rights reserved.
//

import UIKit

extension UIView {
    /// Creating round corner  on part of the view
    func roundCorners(corners: UIRectCorner, radius: Int) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}
