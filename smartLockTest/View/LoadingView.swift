//
//  LoadingView.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 02.01.2023.
//

import UIKit

class LoadingView: UIView {
    
    init() {
        super.init(frame: .zero)
        layer.addSublayer(circleLayer)
        startAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startAnimation() {
        circleLayer.add(strokeAnimationGroup, forKey: nil)
        circleLayer.add(rotationAnimation, forKey: nil)
    }
    
    private var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint.zero,
                                      radius: Constant.radius,
                                      startAngle:  -CGFloat.pi / 2,
                                      endAngle: -CGFloat.pi / 2 + (2 * CGFloat.pi),
                                      clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor(named: "spinner_color")?.cgColor
        circleLayer.lineWidth = 1.5
        circleLayer.fillColor = UIColor.clear.cgColor
        return circleLayer
    }()
    
    private lazy var strokeAnimationGroup: CAAnimationGroup = {
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 2
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.animations = [strokeStartAnimation,
                                           strokeEndAnimation]
        return strokeAnimationGroup
    }()
    
    private lazy var strokeStartAnimation: CABasicAnimation = {
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.beginTime = 0.5
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.duration = 1.5
        strokeStartAnimation.timingFunction = .init(name: .easeInEaseOut)
        return strokeStartAnimation
    }()
    
    private lazy var strokeEndAnimation: CABasicAnimation = {
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 1.5
        strokeEndAnimation.timingFunction = .init(name: .easeInEaseOut)
        return strokeEndAnimation
    }()
    
    private lazy var rotationAnimation: CABasicAnimation = {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = 3
        rotationAnimation.repeatCount = .infinity
        return rotationAnimation
    }()
    
    private enum Constant {
        static let radius: CGFloat = 10
    }
}

