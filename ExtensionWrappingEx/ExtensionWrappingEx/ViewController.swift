//
//  ViewController.swift
//  ExtensionWrappingEx
//
//  Created by 김민재 on 2023/09/18.
//

import UIKit

protocol MinjaeCompatible: AnyObject {}

extension MinjaeCompatible {
    var mj: MinjaeWrapper<Self> {
        return MinjaeWrapper(base: self)
    }
}


struct MinjaeWrapper<T> {
    let base: T

    init(base: T) {
        self.base = base
    }
}

extension MinjaeWrapper where T: UILabel {
    func setLabel(text: String) {
        print("set label \(text) !")
    }
}

class ViewController: UIViewController {

    private let label: UILabel = {
        let lb = UILabel()
        lb.mj.setLabel(text: "MINJAE wrapper")
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension UILabel: MinjaeCompatible {}


