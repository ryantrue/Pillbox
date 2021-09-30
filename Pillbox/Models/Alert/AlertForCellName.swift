//
//  AlertForCellName.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit
extension UIViewController {
    func alertForCellName(label: UILabel, name: String, placholder: String, completioHendler: @escaping (String) -> Void) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .default) { (action) in
            
            let textFieldAlert = alert.textFields?.first
            guard let text = textFieldAlert?.text else {return}
            label.text = (text != "" ? text: label.text)
            completioHendler(text)
        }
        alert.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = placholder
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
