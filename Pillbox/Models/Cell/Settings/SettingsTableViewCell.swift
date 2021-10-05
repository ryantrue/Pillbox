//
//  SettingsTableViewCell.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit


final class SettingsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
