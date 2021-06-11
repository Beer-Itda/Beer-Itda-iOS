//
//  BottleShopTableViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/06/10.
//

import UIKit

class BottleShopTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var beerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    private func initViews() {
        // rounding yellow view
        yellowView.makeRounded(radius: yellowView.frame.height / 2)
        
        // rotate beer image - 15 degree
        beerImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * -15 / 180.0))
    }
    
}
