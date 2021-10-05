//
//  Shadow.swift
//  Pillbox
//
//  Created by Rayen on 02.10.2021.
//
import UIKit

extension UIView {
    func makeShadow() {
        self.layer.shadowColor = UIColor().colorFromHex("2B8ADF").cgColor
        self.layer.shadowOpacity = 100
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
    }
}
