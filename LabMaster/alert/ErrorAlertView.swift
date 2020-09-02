//
//  ErrorAlertView.swift
//  LabMaster
//
//  Created by Robert Moryson on 02/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

class ErrorAlertView: AlertView {
    
    // outlets
    @IBOutlet weak var descriptionTextField: NSTextField!
    
    // public func
    public func setErrorView(description: String) {
        self.descriptionTextField.stringValue = description
    }
    
    @IBAction func didTapOkButton(_ sender: NSButton) {
        self.delegate?.hideView()
    }
    
}
