//
//  TimerViewController.swift
//  Animation-2
//
//  Created by 김민재 on 2023/04/28.
//

import UIKit

class TimerViewController: UIViewController {

    var timer: Timer? = nil
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        startTimer()
        stopTimer()
        // Do any additional setup after loading the view.
    }

    private func startTimer() {
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(start), userInfo: nil, repeats: true)

    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
//        self.scoreLabel.text = "내 점수는요 : \(self.score)"
    }

    @objc
    private func start() {
        self.label.transform = CGAffineTransform(rotationAngle: .pi)
    }

    private let label = UILabel().then {
        $0.text = "ddd"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
