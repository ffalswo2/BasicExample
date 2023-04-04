//
//  ViewController.swift
//  ButtonConfigEx
//
//  Created by 김민재 on 2023/04/02.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    private var isBusyCart = false {
        didSet {
            largeButton.setNeedsUpdateConfiguration()
        }
    }

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.addTarget(
            self,
            action: #selector(stepperValueChange),
            for: .valueChanged
        )
        return stepper
    }()

    private let systemButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("기본 System 버튼", for: .normal)
        return button
    }()

    private let newFilledButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Filled 버튼", for: [])
        return button
    }()

    private let newTintedButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Tinted 버튼"
        return UIButton(configuration: config)
    }()

    private let imageTrailingButon: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "image trailing 버튼"
        config.image = UIImage(systemName: "pencil.circle")
        config.imagePlacement = .trailing
        return UIButton(configuration: config)
    }()

    private let updateHandlerButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "image trailing 버튼"
        config.image = UIImage(systemName: "pencil.circle")
        config.imagePlacement = .trailing
        return UIButton(configuration: config)
    }()

    private lazy var largeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.image = UIImage(systemName: "cart.fill")
        config.imagePlacement = .trailing
        config.title = "Checkout"
        config.background.backgroundColor = .systemPurple
        let button = UIButton(configuration: config)
        button.addTarget(
            self,
            action: #selector(tapDispatch),
            for: .touchUpInside
        )
        return button
    }()

    private let toggleAction = UIAction(title: "Toggle!") { _ in
        print("Action")
    }

    private lazy var toggleButton: UIButton = {
        var config = UIButton.Configuration.gray()
        let button = UIButton(configuration: config, primaryAction: toggleAction)
        button.changesSelectionAsPrimaryAction = true
        return button
    }()

    lazy var colorClosure = { (action: UIAction) in

    }

    private lazy var menuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.background.backgroundColor = .systemCyan
        config.title = "Menu Button !"

        let button = UIButton(configuration: config, primaryAction: nil)
        button.menu = UIMenu(children: [
            UIAction(title: "Bondi Blue", state: .on, handler: colorClosure),
            UIAction(title: "Flower Power", state: .off, handler: colorClosure)
        ])
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            systemButton,
            newFilledButton,
            newTintedButton,
            imageTrailingButon,
            updateHandlerButton,
            largeButton,
            toggleButton,
            menuButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()

    private lazy var stepperStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            numberLabel,
            stepper
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private lazy var totalStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            stepperStack,
            buttonStack
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(totalStack)

        totalStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        setHandler()
    }

    private func setHandler() {
        updateHandlerButton.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            config?.image = button.isHighlighted
            ? UIImage(systemName: "cart.fill.badge.plus")
            : UIImage(systemName: "cart.badge.plus")
            config?.subtitle = numberLabel.text
            button.configuration = config
        }

        largeButton.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            config?.showsActivityIndicator = self.isBusyCart
            button.configuration = config
        }

        toggleButton.configurationUpdateHandler = { button in
            var config = button.configuration
            print("!!", button.isSelected)
            config?.background.backgroundColor = button.isSelected
            ? .systemPurple
            : .systemGray4
            config?.baseForegroundColor = button.isSelected
            ? .white
            : .systemPurple
            button.configuration = config
        }
    }


}

// MARK: Obj-c Methods

private extension ViewController {

    @objc
    func stepperValueChange(_ sender: UIStepper) {
        numberLabel.text = Int(sender.value).description
        updateHandlerButton.setNeedsUpdateConfiguration()
    }

    @objc
    func tapDispatch() {
        self.isBusyCart = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.isBusyCart = false
        }
    }
}
