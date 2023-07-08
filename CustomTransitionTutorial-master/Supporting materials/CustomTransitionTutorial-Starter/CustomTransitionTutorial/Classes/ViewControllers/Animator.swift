//
//  Animator.swift
//  CustomTransitionTutorial
//
//  Created by Tung on 27.11.19.
//  Copyright © 2019 Tung. All rights reserved.
//

import UIKit


// B2 - 8
/// 애니메이션을 구현하는 클래스
final class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    // B2 - 9
    static let duration: TimeInterval = 1.25

    private let type: PresentationType
    private let firstViewController: FirstViewController
    private let secondViewController: SecondViewController
    private let selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect

    // B2 - 10
    init?(type: PresentationType, firstViewController: FirstViewController,
        secondViewController: SecondViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        guard let window = firstViewController.view.window ?? secondViewController.view.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }

        /*
         window의 프레임을 기준으로 셀의 이미지 뷰의 frame을 가져옵니다.
         트랜지션 컨테이너 뷰에서 애니메이션을 적용하려면 컬렉션 뷰의 셀을 적절한 좌표계로 변환해야 하므로 이 단계는 매우 필수적인 단계입니다.
         */
        self.cellImageViewRect = selectedCell.locationImageView.convert(selectedCell.locationImageView.bounds, to: window)
    }

    // B2 - 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    // B2 - 13
    // 모든 전환 로직과 애니메이션은 여기에서 수행됩니다.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // B2 - 18
        let containerView = transitionContext.containerView

        // B2 - 19
        guard let toView = secondViewController.view
        else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        // B3 - 21
        guard let selectedCell = firstViewController.selectedCell,
              let window = firstViewController.view.window ?? secondViewController.view.window,
              let cellImageSnapshot = selectedCell.locationImageView.snapshotView(afterScreenUpdates: true),
              let controllerImageSnapshot = secondViewController.locationImageView.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }

        let isPresenting = type.isPresenting

        // B3 - 22
        let imageViewSnapshot: UIView

        if isPresenting {
            imageViewSnapshot = cellImageSnapshot
        } else {
            imageViewSnapshot = controllerImageSnapshot
        }

        // B3 - 23
        toView.alpha = 0

        // B3 - 24
        [imageViewSnapshot].forEach { containerView.addSubview($0) }

        // B3 - 25
        let controllerImageViewRect = secondViewController.locationImageView.convert(secondViewController.locationImageView.bounds, to: window)

        // B3 - 26
        [imageViewSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }

        // B3 - 27
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                // B3 - 28
                imageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
            }
        }, completion: { _ in
            // B3 - 29
            imageViewSnapshot.removeFromSuperview()

            // B3 - 30
            toView.alpha = 1

            // B3 - 31
            transitionContext.completeTransition(true)
        })

    }
}

// 애니메이터에 전달하여 사용할 애니메이션을 정의하는 데 사용됩니다.
enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
