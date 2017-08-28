//
//  BaseCell.swift
//  Battlecats v2
//
//  Created by Enrique Rodríguez Castañeda on 12/12/16.
//  Copyright © 2016 Swifticats. All rights reserved.
//

import Cocoa

class BaseCell: NSTableCellView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        needsLayout = false
        layout()
        
        // Set the selection style to None.
    }
    
}
