//
//  OptionsScheduleTableViewCell.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import UIKit


final class OptionsTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.makeShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameCellLAbel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch: UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    weak var switchRepeatDelegate: SwitchRepeatProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setConstraints()
        updateViewConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellAidKitConfigure(nameArray: [[String]], indexPath: IndexPath, hexColor: String) {
        nameCellLAbel.text = nameArray[indexPath.section][indexPath.row]
        repeatSwitch.isHidden = (indexPath.section == 4 ? false: true)
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        repeatSwitch.onTintColor = color
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath, hexColor: String) {
        nameCellLAbel.text = nameArray[indexPath.section]
        
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
//        if indexPath == [3,0] {
//            backgroundViewCell.backgroundColor = .systemBlue
    }
    
    @objc func switchChange(paramTarget: UISwitch) {
        switchRepeatDelegate?.switchRepeat(value: paramTarget.isOn)
    }
    
    func updateViewConstraints() {
        contentView.addSubview(backgroundViewCell)
        backgroundViewCell.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        }
        contentView.addSubview(nameCellLAbel)
        nameCellLAbel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalTo(backgroundViewCell).inset(5)
    }
        contentView.addSubview(repeatSwitch)
        repeatSwitch.snp.makeConstraints { (make) -> Void in
            make.centerY.equalToSuperview()
            make.right.equalTo(backgroundViewCell).inset(15)
        }
    }
    
}
