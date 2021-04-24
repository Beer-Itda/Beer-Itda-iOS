//
//  UICollectionViewCell+Extensions.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/02.
//

import UIKit

extension UICollectionViewCell {

    /// Get the string identifier for this class.
    ///
    /// - Returns: String
    class var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

}
