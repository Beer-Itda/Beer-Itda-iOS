//
//  MainCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initBgView()
    }
    
    // MARK: - Functions
    
    private func initBgView() {
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 26
    }

}
