//
//  UIView+Ext.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
