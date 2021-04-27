//
//  SelectedFilterCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/29.
//

import UIKit

class SelectedFilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOultet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initBgView()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchXButton(_ sender: Any) {
    }
    
    // MARK: - Functions
    
    func initBgView() {
        bgView.makeRoundedWithBorder(radius: 15, color: UIColor.Black.cgColor)
    }
    
    func setCell(title: String) {
        titleLabel.text = title
    }

}
