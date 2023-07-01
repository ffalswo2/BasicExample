//
//  HomeNavigationViewController.swift
//  NetEx
//
//  Created by 김민재 on 2023/06/29.
//

import UIKit

class HomeNavigationViewController: UINavigationController {

    var effectViewAlpha: CGFloat = 0 {
        didSet {
            visualEffectView.alpha = effectViewAlpha
        }
    }

    private let statusBarHeight = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.statusBarManager?.statusBarFrame.height ?? 0

    private lazy var visualEffectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        effectView.frame = self.navigationBar.frame
            .insetBy(dx: 0, dy: -statusBarHeight)
            .offsetBy(dx: 0, dy: -statusBarHeight)
        effectView.alpha = 0
        return effectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        // NavigationBar를 완전 투명하게 만들 수 있다.
        appearance.configureWithTransparentBackground()

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance

        let logo = UIImage(named: "netflix_logo")
        let logoButton = UIButton()
        logoButton.setImage(logo, for: .normal)
        // 방법 1: navigationBar에 올라가는건 오토레이아웃이 안되기 때문에 frame으로 잡아줘야함
        logoButton.frame = CGRect(x: 15, y: 5, width: 30, height: 30)

        self.navigationBar.addSubview(visualEffectView)
        self.navigationBar.addSubview(logoButton)



    }

}
