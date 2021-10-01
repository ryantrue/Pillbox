//
//  SheduleTableViewCell.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import UIKit

class SheduleTableViewCell: UITableViewCell {
    
    let pillImageView: UIImageView = {
        let pillImageView = UIImageView()
        pillImageView.image = UIImage(systemName: "pills.fill")?.withRenderingMode(.alwaysTemplate)
        pillImageView.tintColor = .systemBlue
        pillImageView.contentMode = .scaleAspectFill
        pillImageView.clipsToBounds = true
        pillImageView.backgroundColor = .black
        pillImageView.translatesAutoresizingMaskIntoConstraints = false
        return pillImageView
    }()
    
    let pillName = UILabel(text: "Pill Name", font: .proDisplay20())
    let timePill = UILabel(text: "Time", font: .proText20(), alignment: .right)
    let countPills = UILabel(text: "Count", font: .proText14())
    let admissionCondition = UILabel(text: "admission Condition", font: .proText14(), alignment: .right)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ScheduleModel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        pillName.text = model.scheduleName
        timePill.text = dateFormatter.string(from: model.scheduleTime)
        countPills.text = model.scheduleDose
        admissionCondition.text = model.scheduleUnitOfMeasurment
        backgroundColor = UIColor().colorFromHex("\(model.scheduleColor)")
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        pillImageView.layer.cornerRadius = pillImageView.frame.height / 2
    }
    func setConstraints() {
        self.selectionStyle = .none
        
        let topStackView = UIStackView(arrangedSubviews: [pillName,timePill], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(pillImageView)
        NSLayoutConstraint.activate([
            pillImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            pillImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            pillImageView.widthAnchor.constraint(equalToConstant: 70),
            pillImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: pillImageView.trailingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let bottomStackView = UIStackView(arrangedSubviews: [countPills, admissionCondition], axis: .horizontal, spacing: 10, distribution: .fillProportionally)
        
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: pillImageView.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
