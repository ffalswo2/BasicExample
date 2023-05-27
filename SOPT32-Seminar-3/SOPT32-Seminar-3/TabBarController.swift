import UIKit

import SnapKit

final class TabBarController: UITabBarController {

    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()

    let realm = RealmService()

    let PostsVC = CarrotViewController()
    
    let settingVC = StorageViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setUpTabBar()
        setNavigation()
        realm.resetDB()
    }

    private func setUpTabBar(){
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white

        PostsVC.title = "리스트"
        settingVC.title = "즐겨찾기"

        let ViewControllers:[UIViewController] = [PostsVC, settingVC]
        self.setViewControllers(ViewControllers, animated: true)

        self.hidesBottomBarWhenPushed = false
        viewWillLayoutSubviews()
    }
    private func setNavigation() {
        self.navigationItem.hidesBackButton = true
    }
}
