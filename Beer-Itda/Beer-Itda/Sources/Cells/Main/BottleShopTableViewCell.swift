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
        yellowView.makeRounded(radius: 12)
        yellowView.addShadow()
    }
    
}
