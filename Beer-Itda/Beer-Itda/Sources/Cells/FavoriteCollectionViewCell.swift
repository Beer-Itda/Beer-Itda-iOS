//
//  FavoriteCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/27.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initBgView()
    }
    
    // MARK: - Functions
    
    private func initBgView() {
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 15
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.Black.cgColor
    }
    
    func setCellWithFont(title: String) {
        favoriteLabel.text = title
        favoriteLabel.font = UIFont(name: Const.Font.gmarketSansBold, size: 12)
        labelTopConstraint.constant = 10
        labelBottomConstraint.constant = 10
    }
    
    func setCell(title: String) {
        favoriteLabel.text = title
    }

}
