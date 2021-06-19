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
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initBgView()
    }
    
    // MARK: - Functions
    
    private func initBgView() {
        bgView.makeRounded(radius: 26)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchLikeButton(_ sender: Any) {
        // TODO: - 로직 수정해야됨 셀 queue에 넣을 때 이상해짐
        likeButton.isSelected = !isSelected
        if(likeButton.isSelected) {
            likeButton.setImage(UIImage(named: "btnLike"), for: .selected)
        } else {
            likeButton.setImage(UIImage(named: "btnUnlike"), for: .normal)
        }
    }
    
}
