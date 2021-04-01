//
//  UIView+Ex.swift
//  MovieWorld
//
//  Created by Анастасия Корнеева on 1.04.21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
