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
        
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 15
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.Black.cgColor
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchXButton(_ sender: Any) {
    }
    
    // MARK: - Functions
    
    func setCell(title: String) {
        titleLabel.text = title
    }

}
