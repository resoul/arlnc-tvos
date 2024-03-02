//
//  TabBarController.swift
//  arlnc-tvOS
//
//  Created by resoul on 02.03.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = ViewController()
        vc.view.backgroundColor = UIColor.black
        vc.tabBarItem.title = "Home"
        let vc2 = ViewController()
        vc2.view.backgroundColor = UIColor.blue
        vc2.tabBarItem.title = "Favourites"
        let vc3 = ViewController()
        vc3.view.backgroundColor = UIColor.red
        vc3.tabBarItem.title = "Settings"
        
        viewControllers = [vc, vc2, vc3]
    }
}
