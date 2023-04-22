//
//  ViewController.swift
//  Animation-1
//
//  Created by 김민재 on 2023/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func buttonDidTap(_ sender: Any) {
//        animateImageView()
        self.showToast(title: "sdfsadf", backGround: .blue)
    }

    private func animateImageView() {
        UIView.animate(withDuration: 0.5) {
//            self.imageView.transform = CGAffineTransform(
//                translationX: -50,
//                y: 0
//            )
            self.imageView.frame = CGRect(origin: .init(x: self.imageView.frame.minX - 50, y: self.imageView.frame.minY), size: self.imageView.frame.size)
        } completion: { _ in
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }

}

