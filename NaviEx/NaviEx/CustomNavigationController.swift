//
//  CustomNavigationController.swift
//  NaviEx
//
//  Created by 김민재 on 2023/07/09.
//

import UIKit

class CustomNavigationController: UINavigationController {

    private var type: NaviType? {
        didSet {
            guard let type else { return }
            setItems(type: type)
        }
    }

    /// 첫번째 아이콘 클릭
    var rightFirstIconTapped: (() -> Void)?

    /// 두번째 아이콘 클릭
    var rightSecondIconTapped: (() -> Void)?

    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()

    private lazy var rightFirstIcon: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(rightFirstIconDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var rightSecondIcon: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(rightSecondIconDidTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
    }

    private func setAppearance() {
        let appearance = UINavigationBarAppearance()

        // Navigation bar 투명하게 만들기
        appearance.configureWithTransparentBackground()

        appearance.backgroundColor = .black

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.compactScrollEdgeAppearance = appearance

        // 방법 1. frame설정하고 addSubView (오토레이아웃 사용불가능)
//        label.frame = .init(x: 0, y: 0, width: 50, height: 50)
//        self.navigationBar.addSubview(label)
    }

    private func setItems(type: NaviType) {
        switch type {
        case .main:
            setMainItems()
        case .myPage:
            setMyPageItems()
        }
    }

    private func setMainItems() {
        // 방법 2. topItem으로 넣게 되면 Frame은 적용되지 않는다.
        // 하지만 오토레이아웃 가능.
        navigationTitleLabel.text = "메인"
        self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleLabel)

        addRightBarItems()
    }

    private func addRightBarItems() {
        rightFirstIcon.setImage(UIImage(systemName: "bookmark"), for: .normal)

        rightSecondIcon.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)

        let stackView = UIStackView(arrangedSubviews: [rightFirstIcon, rightSecondIcon])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10

        self.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: stackView)
        // autolayout으로 설정해줘야한다. not frame

    }

    private func setMyPageItems() {
        navigationTitleLabel.text = "마이페이지"
        self.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleLabel)
    }

    @discardableResult
    func setType(type: NaviType) -> Self {
        self.type = type
        return self
    }

}


private extension CustomNavigationController {
    @objc func rightFirstIconDidTap() {
        rightFirstIconTapped?()
    }

    @objc func rightSecondIconDidTap() {
        rightSecondIconTapped?()
    }

}

@frozen
enum NaviType {
    case main
    case myPage
}
