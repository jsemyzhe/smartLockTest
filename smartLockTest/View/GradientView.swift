//
//  GradientView.swift
//  smartLockTest
//
//  Created by Julia Semyzhenko on 01.01.2023.
//

import UIKit

class GradientView: UIView {
    
    var topColor: UIColor = .clear
    var bottomColor: UIColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    var startPointX: CGFloat = 1
    var startPointY: CGFloat = 0
    var endPointX: CGFloat = 1
    var endPointY: CGFloat = 1
    
    
    override func layoutSubviews () {
        let gradientLayer = CAGradientLayer ()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
} // for blurred bottom of the screen
