//
//  BeerTableViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/04/27.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    
    private func initBgView() {
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 26
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
