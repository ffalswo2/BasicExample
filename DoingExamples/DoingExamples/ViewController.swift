//
//  ViewController.swift
//  DoingExamples
//
//  Created by 김민재 on 2023/06/26.
//

import UIKit

class ViewController: UIViewController {
    // https://picsum.photos/1000

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()



    }


    @IBAction func buttonDidTap(_ sender: Any) {

        UIView.animate(withDuration: 5) {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
        }


        // URLSession쓰는게 낫지

        DispatchQueue.global().async {
            guard let url = URL(string: "https://picsum.photos/1000"),
                  let data = try? Data(contentsOf: url)
            else { return }

            let image = UIImage(data: data)

            // 섬네일 만들기
            image?.prepareThumbnail(of: .init(width: 100, height: 100), completionHandler: { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
        }

    }


}

