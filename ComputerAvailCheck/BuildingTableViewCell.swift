//
//  BuildingTableViewCell.swift
//  ComputerAvailCheck
//
//  Created by BK on 10/4/15.
//  Copyright © 2015 Bokang Huang. All rights reserved.
//

import UIKit

class BuildingTableViewCell: UITableViewCell {

	@IBOutlet weak var buildingNameLabel: UILabel!
	@IBOutlet weak var windowsCountLabel: UILabel!
	@IBOutlet weak var macCountLabel: UILabel!
	@IBOutlet weak var linuxCountLabel: UILabel!
	
	// Model
	var buildingModel: BuildingModel {
		get {
			return self.buildingModel
		}
		set {
			buildingNameLabel.text = newValue.Building
			windowsCountLabel.text = String(newValue.nWindows)
			macCountLabel.text = String(newValue.nMacintosh)
			linuxCountLabel.text = String(newValue.nLinux)
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
