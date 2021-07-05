//
//  UIButton+Extensions.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import UIKit

extension UIButton {
    func setCornerRadius() {
        //self.tintColor = AppStyleColor.themeColor
        self.layer.borderWidth = 1.0
       // self.layer.borderColor = AppStyleColor.themeColor.cgColor
        self.layer.cornerRadius = self.layer.frame.height/2
    }
}
