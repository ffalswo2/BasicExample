//
//  ViewController.swift
//  Animation-2
//
//  Created by 김민재 on 2023/04/28.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {

    //make Enemy
    private let stateLabel = UILabel()
    private let topEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let bottomEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let leadingEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let trailingEnemy = UIImageView(image: UIImage(named: "enemy"))

    var timer: Timer? = nil
    var isPause: Bool = true
    var score = 0

    func startTimer() {
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.3,
                                          target: self,
                                          selector: #selector(self.enemyMove),
                                          userInfo: nil,
                                          repeats: true)
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        self.startTimer()
        // sopt의 minX
    }

    private func setLayout() {
        self.view.addSubview(soptView)
        self.view.addSubview(topEnemy)
        self.view.addSubview(bottomEnemy)
        self.view.addSubview(leadingEnemy)
        self.view.addSubview(trailingEnemy)
        self.view.addSubview(stateLabel)
        
        stateLabel.snp.makeConstraints {
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
                }
        soptView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }

        topEnemy.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        leadingEnemy.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        trailingEnemy.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        bottomEnemy.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }

    @objc private func didImageViewMoved(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: soptView)
        let changedX = soptView.center.x + transition.x
        let changedY = soptView.center.y + transition.y

        self.soptView.center = .init(x: changedX,
                                     y: changedY)
        sender.setTranslation(.zero, in: self.soptView)
    }

    @objc private func enemyMove() {
        var topEnemyY = self.topEnemy.frame.origin.y
        topEnemyY += 10
        self.topEnemy.frame = .init(origin: .init(x: self.topEnemy.frame.origin.x,
                                                  y: topEnemyY),
                                    size: self.topEnemy.frame.size)

        var bottomEnemyY = self.bottomEnemy.frame.origin.y
        bottomEnemyY -= 10
        self.bottomEnemy.frame = .init(origin: .init(x: self.bottomEnemy.frame.origin.x,
                                                     y: bottomEnemyY),
                                       size: self.bottomEnemy.frame.size)

        var leadingEnemyX = self.leadingEnemy.frame.origin.x
        leadingEnemyX += 10
        self.leadingEnemy.frame = .init(origin: .init(x: leadingEnemyX,
                                                      y: self.leadingEnemy.frame.origin.y),
                                        size: self.leadingEnemy.frame.size)

        var trailingEnemyX = self.trailingEnemy.frame.origin.x
        trailingEnemyX -= 10
        self.trailingEnemy.frame = .init(origin: .init(x: trailingEnemyX,
                                                       y: self.trailingEnemy.frame.origin.y),
                                         size: self.trailingEnemy.frame.size)
        self.calculatePositionReached()
    }

    private func calculatePositionReached() {
        if self.soptView.frame.minX <= self.topEnemy.frame.minX &&
            self.soptView.frame.maxX >= self.topEnemy.frame.maxX &&
            self.soptView.frame.minY <= self.topEnemy.frame.minY &&
            self.soptView.frame.maxY >= self.topEnemy.frame.maxY
        {
            self.stateLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }

        if self.soptView.frame.minX <= self.leadingEnemy.frame.minX &&
            self.soptView.frame.maxX >= self.leadingEnemy.frame.maxX &&
            self.soptView.frame.minY <= self.leadingEnemy.frame.minY &&
            self.soptView.frame.maxY >= self.leadingEnemy.frame.maxY
        {
            self.stateLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }

        if self.soptView.frame.minX <= self.trailingEnemy.frame.minX &&
            self.soptView.frame.maxX >= self.trailingEnemy.frame.maxX &&
            self.soptView.frame.minY <= self.trailingEnemy.frame.minY &&
            self.soptView.frame.maxY >= self.trailingEnemy.frame.maxY
        {
            self.stateLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }

        if self.soptView.frame.minX <= self.bottomEnemy.frame.minX &&
            self.soptView.frame.maxX >= self.bottomEnemy.frame.maxX &&
            self.soptView.frame.minY <= self.bottomEnemy.frame.minY &&
            self.soptView.frame.maxY >= self.bottomEnemy.frame.maxY
        {
            self.stateLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
    }


    private lazy var soptView = UIImageView(image: UIImage(named: "soptLogo")).then {
        let gesture = UIPanGestureRecognizer(target: self,
                                             action: #selector(didImageViewMoved(_:)))
        $0.addGestureRecognizer(gesture)
        $0.isUserInteractionEnabled = true
    }

}
