//
//  BeerAwardHeaderView.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/24.
//

import UIKit

class BeerAwardHeaderView: UIView {
    
    // MARK: - Properties
    
    var beer: Beer = Beer(id: 0, name: "", brewery: "", abv: 0.0, country: "", beerStyle: "", aroma: [], thumbnailImage: "", rateAvg: 0, reviewCount: 0, favoriteFlag: false) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var beerAwardLabel: UILabel!
    @IBOutlet weak var korNameLabel: UILabel!
    @IBOutlet weak var engNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var shadowView: UIView!
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
        getBeerAward()
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
        
        // init shadow
        shadowView.makeRounded(radius: ( 26 * bgView.frame.height ) / 180 )
        shadowView.layer.shadowRadius = 40
        shadowView.layer.shadowOpacity = 0.12
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowView.layer.masksToBounds = false
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
    
    private func updateUI(beer: Beer) {
        self.korNameLabel.text = beer.name
        // TODO: - 영어이름
        self.engNameLabel.text = beer.name
        self.ratingLabel.text = String(beer.rateAvg)
        // TODO: - 맥주 이미지 global queue
    }

}

extension BeerAwardHeaderView {
    
    func getBeerAward() {
        
        // TODO: - startDate, endDate, limit
        
        BeerAwardAPI.shared.getBeerAward(startDate: "2021-01-01%2000:00:00", endDate: "2021-08-07%2000:00:00", limit: 1) { (response) in
            switch response {
            case .success(let beerList):
                if let data = beerList as? BeerList {
                    
                    self.beer = data.beers[0]
                    self.updateUI(beer: self.beer)
                   
                }
            case .requestErr(let message):
                print(message)
                print("requestErr in BeerAwardHeaderView getBeerAward")
                
            case .pathErr:
                print("pathErr in BeerAwardHeaderView getBeerAward")
                
            case .networkFail:
                print("networkFail in BeerAwardHeaderView getBeerAward")
                
            case .serverErr:
                print("serverErr in BeerAwardHeaderView getBeerAward")
            }
        }
    }
}
