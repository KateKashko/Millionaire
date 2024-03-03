//
//  UIView+Ext.swift
//  Millionaire
//
//  Created by Mikhail Ustyantsev on 14.02.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
}
