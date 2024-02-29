//
//  CustomButton.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 29.02.2024.
//

import UIKit

extension UIView {
    func applyGradient(colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = [0, 0.5, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -1, c: 1, d: 0, tx: 0, ty: 1))
        gradient.frame = self.bounds
        gradient.cornerRadius = 15
        self.layer.insertSublayer(gradient, at: 0)
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
