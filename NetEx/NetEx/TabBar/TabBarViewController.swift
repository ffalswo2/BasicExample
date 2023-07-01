//
//  TabBarViewController.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/29.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeNavigationViewController(rootViewController: HomeViewController())
        homeVC.tabBarItem.title = "홈"
        homeVC.tabBarItem.image = UIImage(systemName: "house")

        let newHotVC = NewHotViewController()
        newHotVC.tabBarItem.title = "NEW & HOT"
        newHotVC.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")

        let naviVC = UINavigationController(rootViewController: newHotVC)

        let appearance = UINavigationBarAppearance()
        // NavigationBar를 완전 투명하게 만들 수 있다.
        appearance.configureWithTransparentBackground()

        naviVC.navigationBar.standardAppearance = appearance
        naviVC.navigationBar.scrollEdgeAppearance = appearance
        naviVC.navigationBar.compactAppearance = appearance
        naviVC.navigationBar.compactScrollEdgeAppearance = appearance

        self.viewControllers = [homeVC, naviVC]

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .black

        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.iconColor = .gray
        tabBarItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.gray]

        tabBarItemAppearance.selected.iconColor = .white
        tabBarItemAppearance.selected.titleTextAttributes = [.foregroundColor : UIColor.white]


        tabBarAppearance.compactInlineLayoutAppearance = tabBarItemAppearance // 회전시 가로로 길게
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        // 아이폰 기본

        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }

}
