//
//  UserCell.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 12/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

class UserCell: NSCell{

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var textLabel: NSTextFieldCell!
    
    @IBOutlet weak var detailTextLabel: NSTextFieldCell!
}
