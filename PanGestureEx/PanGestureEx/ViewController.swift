//
//  ViewController.swift
//  PanGestureEx
//
//  Created by 김민재 on 2023/04/16.
//

import UIKit

class ViewController: UIViewController {

    private let imageView = UIImageView(image: UIImage(systemName: "square.and.arrow.up.circle.fill"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
        setGesture()
    }

    private func setLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)


        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setGesture() {
        let gesture = UIPanGestureRecognizer(
            target: self, action: #selector(handleGesture)
        )
        imageView.addGestureRecognizer(gesture)
    }

    @objc
    private func handleGesture(_ sender: UIPanGestureRecognizer) {
        
    }
}

