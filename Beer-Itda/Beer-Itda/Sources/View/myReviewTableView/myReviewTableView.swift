//
//  myReviewTableView.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/12/05.
//

import Foundation
import UIKit

class MyReviewTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        let number = numberOfRows(inSection: 0)
        var height: CGFloat = 0

        for idx in 0..<number {
            guard let cell = cellForRow(at: IndexPath(row: idx, section: 0)) else {
                continue
            }
            height += cell.bounds.height
        }
        
        return CGSize(width: contentSize.width, height: height)
    }
}
