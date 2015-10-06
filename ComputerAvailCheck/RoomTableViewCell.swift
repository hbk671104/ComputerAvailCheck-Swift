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
	
	var roomModel: RoomModel! {
		didSet {
			roomNumberLabel.text = roomModel.Room
			if !roomModel.NickName.isEmpty {
				roomNameLabel.text = roomModel.NickName
			} else {
				roomNameLabel.text = roomModel.RoomType
			}
			windowsCountLabel.text = String(roomModel.nWindows)
			macCountLabel.text = String(roomModel.nMacintosh)
			linuxCountLabel.text = String(roomModel.nLinux)
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
