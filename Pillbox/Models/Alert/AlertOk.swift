//
//  AlertOk.swift
//  Pillbox
//
//  Created by Rayen on 9/30/21.
//

import UIKit
extension UIViewController {
    func alertOk(title: String, message: String?) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .default)
            
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}
