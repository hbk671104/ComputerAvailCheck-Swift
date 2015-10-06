//
//  RoomTableViewCell.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/6/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

	@IBOutlet weak var roomNumberLabel: UILabel!
	@IBOutlet weak var roomNameLabel: UILabel!
	@IBOutlet weak var windowsCountLabel: UILabel!
	@IBOutlet weak var macCountLabel: UILabel!
	@IBOutlet weak var linuxCountLabel: UILabel!
	
	/*
	var roomModel: RoomModel! {
		didSet {
			roomNumberLabel.text = roomModel.Room
			if let nickname = roomModel.NickName {
				roomNameLabel.text = nickname
			}
		}
	}
	*/
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
