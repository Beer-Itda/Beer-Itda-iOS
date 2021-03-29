//
//  MediumCategoryCollectionViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/03/29.
//

import UIKit
import Lottie

class MediumCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var animationView: AnimationView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initializeBgView()
        initializeAnimationView()
    }
    
    // MARK: - Functions
    
    private func initializeBgView() {
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = bgView.frame.height / 2
    }
    
    private func initializeAnimationView() {
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        animationView.play()
    }

}
