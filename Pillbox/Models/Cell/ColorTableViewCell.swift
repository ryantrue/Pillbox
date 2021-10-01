//
//  ColorSheduleTableViewCell.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfigure(indexPath: IndexPath) {
            switch indexPath.section {
            case 0:
                backgroundViewCell.backgroundColor = .systemRed
            case 1:
                backgroundViewCell.backgroundColor = .systemBlue
            case 2:
                backgroundViewCell.backgroundColor = .systemTeal
            case 3:
                backgroundViewCell.backgroundColor = .systemIndigo
            case 4:
                backgroundViewCell.backgroundColor = .systemOrange
            case 5:
                backgroundViewCell.backgroundColor = .systemYellow
            default:
                backgroundViewCell.backgroundColor = .systemGray
            }
        }
    
    
    func setConstraints() {
        
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  5),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
       
    }
}
