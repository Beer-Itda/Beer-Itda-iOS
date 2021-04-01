//
//  RoundedSquareCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/01.
//

import UIKit

class RoundedSquareCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOultet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = bgView.bounds.height / 2
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.Black.cgColor
    }
    
    // MARK: - Functions
    
    func setCell(title: String) {
        titleLabel.text = title
    }

}
