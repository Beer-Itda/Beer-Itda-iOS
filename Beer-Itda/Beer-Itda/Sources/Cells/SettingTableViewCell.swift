//
//  SettingTableViewCell.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/06/13.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let identifier = "settingTableViewCell"
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
