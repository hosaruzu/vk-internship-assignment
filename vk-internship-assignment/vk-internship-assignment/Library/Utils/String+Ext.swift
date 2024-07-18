//
//  String+Ext.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

extension String {
    func defineWidth() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 15, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attributes).width
    }

    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
