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
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        setLabel()
    }
    
    // MARK: - Functions
    
    private func setLabel() {
        beerAwardLabel.font = UIFont(name: "GmarketSansBold", size: 26)
    }

}
