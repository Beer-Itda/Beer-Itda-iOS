//
//  BeerAwardHeaderView.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/24.
//

import UIKit

class BeerAwardHeaderView: UIView {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var beerAwardLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var circleView1: UIView!
    @IBOutlet weak var circleView2: UIView!
    @IBOutlet weak var circleView3: UIView!
    @IBOutlet weak var beerImageView: UIImageView!
    
    // circle view constraints
    @IBOutlet weak var circle1Top: NSLayoutConstraint!
    @IBOutlet weak var circle1Leading: NSLayoutConstraint!
    @IBOutlet weak var circle2Leading: NSLayoutConstraint!
    @IBOutlet weak var circle2Bottom: NSLayoutConstraint!
    @IBOutlet weak var circle3Top: NSLayoutConstraint!
    @IBOutlet weak var circle3Trailing: NSLayoutConstraint!
    
    // beer image constraints
    @IBOutlet weak var beerImageTop: NSLayoutConstraint!
    @IBOutlet weak var beerImageTrailing: NSLayoutConstraint!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        initLabel()
        initBgView()
        initCircleViewRounding()
    }
    
    override func layoutSubviews() {
        initCircleViewRounding()
        initCircleViewConstraints()
        initBeerImage()
    }
    
    // MARK: - Functions
    
    private func initLabel() {
        beerAwardLabel.font = UIFont(name: "GmarketSansBold", size: 26)
    }
    
    private func initBgView() {
        bgView.makeRounded(radius: ( 26 * bgView.frame.height ) / 180 )
    }
    
    private func initCircleViewRounding() {
        circleView1.makeRoundedWithBorder(radius: circleView1.frame.height / 2, color: UIColor.Yellow.cgColor)
        circleView2.makeRoundedWithBorder(radius: circleView2.frame.height / 2, color: UIColor.Yellow.cgColor)
        circleView3.makeRoundedWithBorder(radius: circleView3.frame.height / 2, color: UIColor.Yellow.cgColor)
    }
    
    private func initCircleViewConstraints() {
        circle1Top.constant = -( 29 * circleView1.frame.height ) / 63
        circle1Leading.constant = -( 11 * circleView1.frame.width ) / 63
        
        circle2Bottom.constant = -( 65 * circleView2.frame.height ) / 155
        circle2Leading.constant = ( 30 * circleView2.frame.width ) / 155
        
        circle3Top.constant = -( 20 * circleView3.frame.height ) / 128
        circle3Trailing.constant = -( 18 * circleView3.frame.width ) / 128
    }
    
    private func initBeerImage() {
        beerImageTop.constant = ( 16 * beerImageView.frame.height ) / 204
        beerImageTrailing.constant = ( 72 * beerImageView.frame.height ) / 204
    }

}
