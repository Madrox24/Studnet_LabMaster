//
//  AlertView.swift
//  LabMaster
//
//  Created by Robert Moryson on 02/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

protocol AlertViewDelegate {
    func hideView()
}

class AlertView: NSView {
    
    // properties
    var delegate: AlertViewDelegate?
   
    // lifecycle
    override func awakeFromNib() {
        wantsLayer = true
        layer?.backgroundColor = .init(gray: 0.95, alpha: 1)
        layer?.cornerRadius = 10
    }
    
}
