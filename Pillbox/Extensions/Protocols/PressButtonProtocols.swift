//
//  PressButtonProtocols.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import Foundation

protocol PressReadyTaskButtonProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}

protocol SwitchRepeatProtocol: AnyObject {
    func switchRepeatTapped(value: Bool)
}
