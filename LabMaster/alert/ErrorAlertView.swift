//
//  ErrorAlertView.swift
//  LabMaster
//
//  Created by Robert Moryson on 02/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

class ErrorAlertView: NSView {
    
    // properties
    var delegate: AlertViewDelegate?
    
    // outlets
    @IBOutlet weak var descriptionTextField: NSTextField!
    
    // lifecycle
    override func awakeFromNib() {
        wantsLayer = true
        layer?.backgroundColor = .init(gray: 0.95, alpha: 1)
        layer?.cornerRadius = 10
    }
    
    // public func
    public func setErrorView(description: String) {
        self.descriptionTextField.stringValue = description
    }
    
    @IBAction func didTapOkButton(_ sender: NSButton) {
        self.delegate?.hideView()
    }
    
}
