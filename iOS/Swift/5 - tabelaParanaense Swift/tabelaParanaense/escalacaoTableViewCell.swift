//
//  escalacaoTableViewCell.swift
//  tabelaParanaense
//
//  Created by Fernando Cani on 5/10/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

import UIKit

class escalacaoTableViewCell: UITableViewCell {

    @IBOutlet var imgPlayer:            UIImageView!
    @IBOutlet var lblPlayerName:        UILabel!
    @IBOutlet var lblPlayerPosition:    UILabel!
    @IBOutlet var lblPlayerNumber:      UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}