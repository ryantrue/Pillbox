//
//  ColorTaskTableiewController.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit
final class ColorTaskTableiewController : UITableViewController {
    
    let idTaskColorCell = "idTaskColorCell"
    let idTaskAidKitHeader = "idTaskAidKitHeader"
    
    let headerNameArray = ["RED","BLUE","TEAL","INDIGO","ORANGE", "YELLOW", "GRAY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: idTaskColorCell)
        tableView.register(HeaderOptionTableViewCell.self, forHeaderFooterViewReuseIdentifier: idTaskAidKitHeader)
        
        title = "Color tasks"
    }
    
    private func setColor(color: String) {
        let taskOptions = self.navigationController?.viewControllers[1] as? TaskOptionTabbleViewController
        taskOptions?.hexColorCell = color
        taskOptions?.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTaskColorCell, for: indexPath) as! ColorTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idTaskAidKitHeader) as! HeaderOptionTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
