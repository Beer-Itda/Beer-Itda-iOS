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
        
        initBgView()
    }
    
    // MARK: - Functions
    
    func initBgView() {
        bgView.makeRoundedWithBorder(radius: bgView.bounds.height / 2, color: UIColor.black.cgColor)
    }
    
    func setCell(title: String) {
        titleLabel.text = title
    }
    
    func selectCell() {
        bgView.layer.borderColor = UIColor.Yellow.cgColor
        titleLabel.textColor = UIColor.Yellow
    }
    
    func deselectCell() {
        bgView.layer.borderColor = UIColor.Black.cgColor
        titleLabel.textColor = UIColor.Black
    }
    
    func getTitle() -> String {
        return titleLabel.text!
    }

}
