//
//  ScheduleColorViewController.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit

final class AidKitColorViewController : UITableViewController {
    
    let idOptionsColorCell = "idOptionsAidKitCell"
    let idOptionsAidKitHeader = "idOptionsAidKitHeader"
    
    let headerNameArray = ["RED","BLUE","TEAL","INDIGO","ORANGE", "YELLOW", "GRAY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: idOptionsColorCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsAidKitHeader)
        
        title = "Color shcedule"
    }
    
    private func setColor(color: String) {
        let aidKitOptions = self.navigationController?.viewControllers[1] as? AidKitOptionTableViewController
        aidKitOptions?.hexColorCell = color
        aidKitOptions?.tableView.reloadRows(at: [[3,0], [4,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        7
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsColorCell, for: indexPath) as! ColorTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
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
        switch indexPath.section {
        case 0: setColor(color: "ED534D")
        case 1: setColor(color: "3392E5")
        case 2: setColor(color: "129A87")
        case 3: setColor(color: "4E60BB")
        case 4: setColor(color: "EC6A36")
        case 5: setColor(color: "ECBD23")
        case 6: setColor(color: "788C94")
        default:
            setColor(color: "FFFFFF")
        }
    }
}
