//
//  tabelaTableViewCell.swift
//  tabelaParanaense
//
//  Created by Fernando Cani on 5/10/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

import UIKit

class tabelaTableViewCell: UITableViewCell {

    @IBOutlet var lblPosition:  UILabel!
    @IBOutlet var imgShield:    UIImageView!
    @IBOutlet var lblClub:      UILabel!
    @IBOutlet var lblPoints:    UILabel!
    @IBOutlet var lblVictories: UILabel!
    @IBOutlet var lblDraw:      UILabel!
    @IBOutlet var lblLoses:     UILabel!
    @IBOutlet var lblGoals:     UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
