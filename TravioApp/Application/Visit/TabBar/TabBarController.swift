//
//  TabBarController.swift
//  TravioApp
//
//  Created by Şevval Çakıroğlu on 29.08.2023.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UITabBar.appearance()
        self.navigationController?.isNavigationBarHidden = true

        appearance.tintColor = Color.turquoise.color
        appearance.backgroundColor = Color.lightGray.color

        let vc1 = HomeVC()
        let nav1 = UINavigationController(rootViewController: vc1)
        let img = UIImage(named: "Home")

        vc1.tabBarItem = UITabBarItem(title: "Home", image: img, tag: 0)

        let vc2 = VisitsVC()
        let nav2 = UINavigationController(rootViewController: vc2)
        let img2 = UIImage(named: "Visits")

        vc2.tabBarItem = UITabBarItem(title: "Visits", image: img2, tag: 1)

        let vc3 = MapVC()
        let nav3 = UINavigationController(rootViewController: vc3)
        let img3 = UIImage(named: "Map")

        vc3.tabBarItem = UITabBarItem(title: "Map", image: img3, tag: 2)

        let vc4 = SettingsVC()
        let nav4 = UINavigationController(rootViewController: vc4)
        let img4 = UIImage(named: "Menu")

        vc4.tabBarItem = UITabBarItem(title: "Menu", image: img4, tag: 3)

        self.viewControllers = [nav1, nav2, nav3, nav4]
    }
}

