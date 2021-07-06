//
//  UIButton+Extensions.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import UIKit

extension UIButton {
    func setCornerRadius() {
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
    }
}
