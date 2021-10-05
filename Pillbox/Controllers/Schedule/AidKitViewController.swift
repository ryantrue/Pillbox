//
//  AidKitViewController.swift
//  Pillbox
//
//  Created by Rayen on 23.09.2021.
//

import UIKit
import FSCalendar
import RealmSwift
import SnapKit

final class AidKitViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var calendarHeightConstraint: NSLayoutConstraint!
    
    private var calendar: FSCalendar = {
        
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.scope = .week
        calendar.backgroundColor = .white
        
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        calendar.appearance.weekdayTextColor = UIColor.systemBackground
        calendar.appearance.selectionColor = .white
        calendar.appearance.todayColor = .systemBlue
        calendar.appearance.titleTodayColor =  .white
        calendar.appearance.titleSelectionColor = .systemBlue
        calendar.appearance.eventDefaultColor = .black.withAlphaComponent(0.3)
        calendar.appearance.titleWeekendColor = .black.withAlphaComponent(0.3)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = .black
        calendar.placeholderType = .none
        
        func selectDay() {
            calendar.appearance.titleTodayColor = .systemBlue
            calendar.appearance.todayColor = .white
            calendar.appearance.selectionColor = .systemBlue
            calendar.appearance.titleSelectionColor = .white
        }
        selectDay()
        
        calendar.clipsToBounds = true
        return calendar
    }()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private lazy var testDatesWithEvent = ["1999-12-01", "1998-12-01"]
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let localRealm = try! Realm()
    var aidKitArray: Results<AidKitModel>!
    
    let aidKitID = "aidKitID"
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        return panGesture
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AidKit"
        view.backgroundColor = .white
        calendar.delegate = self
        calendar.dataSource = self
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        tableView.register(AidKitTableViewCell.self, forCellReuseIdentifier: aidKitID)
        //        setConstraints()
        aidKitOnDay(date: Date())
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtomTapped))
        //        navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance
        
    }
    
    @objc func addButtomTapped() {
        let aidKitOption = AidKitOptionTableViewController()
        navigationController?.pushViewController(aidKitOption, animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            @unknown default:
                fatalError()
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateFormatter.string(from: date)
        if self.testDatesWithEvent.contains(dateString) {
            return 1
        }
        return 0
    }
    
    private func aidKitOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return}
        print(weekday)
        
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second:  -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        
        let predicateRepeat = NSPredicate(format: "aidKitWeekday = \(weekday) AND aidKitRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "aidKitRepeat = false AND aidKitDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        aidKitArray = localRealm.objects(AidKitModel.self).filter(compound).sorted(byKeyPath: "aidKitTime")
        tableView.reloadData()
    }
}

extension AidKitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aidKitArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: aidKitID, for: indexPath) as! AidKitTableViewCell
        let model = aidKitArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = aidKitArray[indexPath.row]
        let deletAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, comletionHendler in
            RealmManager.shared.deleteAidKitModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deletAction])
    }
}

//MARK: -FSCalendarDataSource, FSCalendarDelegate

extension AidKitViewController: FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint?.constant = bounds.height
        view.layoutIfNeeded()
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        aidKitOnDay(date: date)
    }
}

//MARK: - setConstraints
extension AidKitViewController {
    
        func setConstraints() {
    
            view.addSubview(calendar)
    
            calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
            calendar.addConstraint(calendarHeightConstraint)
    
            NSLayoutConstraint.activate([
                calendar.topAnchor.constraint(equalTo: view.topAnchor,constant: 90),
                calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
    
            view.addSubview(tableView)
    
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor,constant: 10),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        }
    
//    override func updateViewConstraints() {
//        view.addSubview(calendar)
//        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
//        calendar.addConstraint(calendarHeightConstraint)
//
//        //
//
//        calendar.snp.makeConstraints { (calendar) -> Void in
//            calendar.height.equalTo(600)
//            calendar.top.equalToSuperview()
//            calendar.left.right.equalToSuperview()
//        }
//        self.view.addSubview(tableView)
//        tableView.snp.makeConstraints { (make) -> Void in
//            make.right.left.bottom.equalTo(0)
//            if calendarHeightConstraint.constant <= 300 {
//                make.top.equalTo(calendar).inset(300)
//            }
//        }
//    }
}

