//
//  HeaderOptionScheduleTableViewCell.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import UIKit

class HeaderOptionTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "", font: .proText14())
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headerLabel.textColor = .black
        
        self.contentView.backgroundColor = .lightGray
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])

        
    }
}
