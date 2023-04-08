//
//  ViewController.swift
//  PreSeminar-2
//
//  Created by 김민재 on 2023/04/07.
//

import UIKit

import SnapKit

final class ZigZagViewController: UIViewController {

    private enum Size {
        static let halfScreenWidth = UIScreen.main.bounds.width / 2
        static let quarterScreenHeight = UIScreen.main.bounds.height / 4
    }

    private let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    private let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setLayout()
    }

    func style() {
        view.backgroundColor = .white
    }

    func setLayout() {
        [
            yellowView,
            greenView,
            blackView,
            blueView
        ].forEach {
            view.addSubview($0)
        }

        yellowView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(Size.halfScreenWidth)
            make.height.equalTo(Size.quarterScreenHeight)
        }

        greenView.snp.makeConstraints { make in
            make.leading.equalTo(yellowView.snp.trailing)
            make.top.equalTo(yellowView.snp.bottom)
            make.trailing.equalToSuperview()
            make.height.equalTo(Size.quarterScreenHeight)
        }

        blackView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(greenView.snp.leading)
            make.height.equalTo(Size.quarterScreenHeight)
        }

        blueView.snp.makeConstraints { make in
            make.top.equalTo(blackView.snp.bottom)
            make.trailing.equalToSuperview()
            make.leading.equalTo(blackView.snp.trailing)
            make.height.equalTo(Size.quarterScreenHeight)
        }


    }


}

