//
//  OptionScheduleViewController.swift
//  Pillbox
//
//  Created by Rayen on 9/29/21.
//

import UIKit

final class AidKitOptionTableViewController : UITableViewController {
    
    let idOptionsAidKitCell = "idOptionsAidKitCell"
    let idOptionsAidKitHeader = "idOptionsAidKitHeader"
    
    let headerNameArray = ["Date and time","pill","pill name","colour","period"]
    
    let cellNameArray = [["Date", "Time"],
                         ["Name", "Dosage", "unit of measurement"],
                         ["Pill name"],
                         [""],
                         ["repear every 7 days"]]
    
    private var aidKitModel = AidKitModel()
    
    var hexColorCell = "5DADE2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsAidKitCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsAidKitHeader)
        
        title = "Option shcedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        
        if aidKitModel.aidKitDate == nil || aidKitModel.aidKitTime == nil || aidKitModel.aidKitName == "Unknown" {
            alertOk(title: "Error", message: "Reuered fileds")
        } else {
            aidKitModel.aidKitColor = hexColorCell
            RealmManager.shared.saveAidKitModel(model: aidKitModel)
            aidKitModel = AidKitModel()
            alertOk(title: "Success", message: nil)
            hexColorCell = "5DADE2"
            tableView.reloadData()
        }
    }
    
    func pushController(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
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
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsAidKitCell, for: indexPath) as! OptionsTableViewCell
        cell.cellAidKitConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.switchRepeatDelegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsAidKitHeader) as! HeaderOptionTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath {
        case [0,0]:
            alertDate(label: cell.nameCellLAbel) {(numberWeekday, date) in
                self.aidKitModel.aidKitDate = date
                self.aidKitModel.aidKitWeekday = numberWeekday
            }
        case [0,1]:
            alertTime(label: cell.nameCellLAbel) { (time) in
                self.aidKitModel.aidKitTime = time
            }
        case [1,0]:
            alertForCellName(label: cell.nameCellLAbel, name: "name", placholder: "Enter name pill") {text in
                self.aidKitModel.aidKitName = text }
        case [1,1]:
            alertForCellName(label: cell.nameCellLAbel, name: "Dosage", placholder: "Enter dosage") {text in
                self.aidKitModel.aidKitDose = text }
        case [1,2]:
            alertForCellName(label: cell.nameCellLAbel, name: "UnitOfMeasurement", placholder: "Enter unit of measurement") {text in
                self.aidKitModel.aidKitUnitOfMeasurment = text}
        case [1,3]:
            alertForCellName(label: cell.nameCellLAbel, name: "mg", placholder: "Enter mg") {text in
                self.aidKitModel.aidKitDose = text }
        case [2,0]:
            pushController(vc: SettingsViewControoler())
        case [3,0]:
            pushController(vc: AidKitColorViewController())
        default:
            print("Tap OptionTableView")
        }
    }
}

extension AidKitOptionTableViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        aidKitModel.aidKitRepeat = value
    }
}
