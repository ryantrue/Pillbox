//
//  ViewController.swift
//  Pillbox
//
//  Created by Rayen on 23.09.2021.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let sheduleViewController = createNavController(vc: SсheduleViewController(), itemName: "Schedule", itemImage: "calendar.badge.clock")
        let tasksViewControoler = createNavController(vc: TasksViewController(), itemName: "Tasks", itemImage: "hourglass.badge.plus")
        let settingsViewControoler = createNavController(vc: SettingsTableViewController(), itemName: "Settings", itemImage: "gearshape")
        
        viewControllers = [sheduleViewController, tasksViewControoler, settingsViewControoler]
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage) , tag: 0)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        
        return navController
    }
    
}

