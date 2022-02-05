//
//  RoundedSquareCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/01.
//

import UIKit

class RoundedSquareCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var aroma: Aroma = Aroma(id: -1, aroma: "", isSelected: false)
    var style: StyleSmall = StyleSmall(id: -1, smallName: "", midStyleID: -1, isSelected: false)
    
    // MARK: - @IBOultet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initBgView()
        initSelectedState()
    }
    
    // MARK: - Functions
    
    func initBgView() {
        bgView.makeRoundedWithBorder(radius: bgView.bounds.height / 2, color: UIColor.black.cgColor)
    }
    
    func initSelectedState() {
        if isSelected {
            selectCell()
        } else {
            deselectCell()
        }
    }
    
    func setAromaCell(aroma: Aroma) {
        titleLabel.text = aroma.aroma
        self.aroma = aroma
    }
    
    func setStyleCell(style: StyleSmall) {
        titleLabel.text = style.smallName
        self.style = style
    }
    
    func selectCell() {
        self.isSelected = true
        bgView.layer.borderColor = UIColor.Yellow.cgColor
        titleLabel.textColor = UIColor.Yellow
    }
    
    func deselectCell() {
        self.isSelected = false
        bgView.layer.borderColor = UIColor.Black.cgColor
        titleLabel.textColor = UIColor.Black
    }
    
    func getTitle() -> String {
        return titleLabel.text!
    }

}
