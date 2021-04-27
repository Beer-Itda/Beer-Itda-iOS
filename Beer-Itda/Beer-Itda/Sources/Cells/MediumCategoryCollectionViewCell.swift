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
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initializeBgView()
        //initializeAnimationView()
    }
    
    // TODO: - 다시 pop됐을때도 animation 실행되어야함
    
    // MARK: - Functions
    
    private func initializeBgView() {
        bgView.makeRounded(radius: bgView.frame.height / 2)
    }
    
//    private func initializeAnimationView() {
//        animationView.contentMode = .scaleAspectFill
//        animationView.loopMode = .loop
//        animationView.animationSpeed = 2
//        animationView.play()
//    }
    
//    private func animateLottieAlphaUnhidden() {
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//            self.animationView.alpha = 1.0
//        }, completion: nil)
//    }
//    
//    private func animateLottieAlphaHidden() {
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//            self.animationView.alpha = 0.0
//        }, completion: nil)
//    }

}
