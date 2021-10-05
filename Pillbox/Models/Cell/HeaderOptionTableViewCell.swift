//
//  HeaderOptionScheduleTableViewCell.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import UIKit
import SnapKit

final class HeaderOptionTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "", font: .proText14())
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headerLabel.textColor = .black
        
        self.contentView.backgroundColor = .white
        updateViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    
    func updateViewConstraints() {
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
}
