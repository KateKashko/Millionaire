//
//  CustomButton.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 29.02.2024.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor]) {
        
        let gradientLayerName = "gradientLayer"
        let existingLayer = self.layer.sublayers?.first { $0.name == gradientLayerName } as? CAGradientLayer
        
        let gradientLayer: CAGradientLayer
        if let existingLayer = existingLayer {
            gradientLayer = existingLayer
        } else {
            gradientLayer = CAGradientLayer()
            gradientLayer.name = gradientLayerName
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -1, c: 1, d: 0, tx: 0, ty: 1))
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 15
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
