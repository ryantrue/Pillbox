//
//  SettingsTableViewController.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit
class SettingsTableViewController : UITableViewController {
    
    let idSettingsCell = "idSettingsCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .gray
        tableView.separatorStyle = .singleLine
//        tableView.bounces = false
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: idSettingsCell)
       
        
        title = "Settings"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idSettingsCell, for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.text = "Cell"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Tap OptionTableView")
    }
}
