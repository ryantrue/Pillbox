//
//  OptionScheduleViewController.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import UIKit
class ScheduleOptionTableViewController : UITableViewController {
    
    let idOptionsScheduleCell = "idOptionsScheduleCell"
    let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    let headerNameArray = ["Date and time","pill","pill name","colour","period"]
    
    let cellNameArray = [["Date", "Time"],
                         ["Name", "Dosage", "unit of measurement"],
                         ["Pill name"],
                         [""],
                         ["repear every 7 days"]]
    
    private var scheduleModel = ScheduleModel()
    
    var hexColorCell = "FFFFFF"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
        
        title = "Option shcedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        scheduleModel.scheduleColor = hexColorCell
        RealmManager.shared.saveSheduleModel(model: scheduleModel)
        scheduleModel = ScheduleModel()
        alertOk(title: "Success")
        tableView.reloadRows(at: [[0,0],[0,1],[1,0],[1,1],[1,2],[2,0]], with: .none)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 3
        case 2: return 1
        case 3: return 1
        default: return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath)
        let color = UIColor().colorFromHex(hexColorCell)
        cell.backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        cell.switchRepeatDelegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleHeader) as! HeaderOptionTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLAbel) {(numberWeekday, date) in
                self.scheduleModel.scheduleDate = date
                self.scheduleModel.scheduleWeekday = numberWeekday
            }
        case [0,1]:
            alertTime(label: cell.nameCellLAbel) { (time) in
                self.scheduleModel.scheduleTime = time
            }
        case [1,0]:
            alertForCellName(label: cell.nameCellLAbel, name: "name", placholder: "Enter name pill") {text in
                self.scheduleModel.schedulePillName = text }
        case [1,1]:
            alertForCellName(label: cell.nameCellLAbel, name: "Dosage", placholder: "Enter dosage") {text in
                self.scheduleModel.scheduleDose = text }
        case [1,2]:
            alertForCellName(label: cell.nameCellLAbel, name: "UnitOfMeasurement", placholder: "Enter unit of measurement") {text in
                self.scheduleModel.scheduleUnitOfMeasurment = text}
        case [1,3]:
            alertForCellName(label: cell.nameCellLAbel, name: "mg", placholder: "Enter mg") {text in
                self.scheduleModel.scheduleDose = text }
            
        case [2,0]:
            pushController(vc: TeachersViewController())
        case [3,0]:
            pushController(vc: ScheduleColorViewController())
        default:
            print("Tap OptionTableView")
        }
    }
    func pushController(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ScheduleOptionTableViewController: SwitchRepeatProtocol {
    func switchRepeatTapped(value: Bool) {
        scheduleModel.scheduleRepeat = value
    }
}
