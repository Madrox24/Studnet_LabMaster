//
//  ErrorAlertViewController.swift
//  LabMaster
//
//  Created by Robert Moryson on 02/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

class ErrorAlertViewController: NSViewController {
    
    // properties
    public var delegate: AlertViewControllerDelegate?
    
    // outlets
    @IBOutlet var contentView: ErrorAlertView!
    
    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.delegate = self
    }
    
    // public functions
    public func setErrorView(description: String) {
        self.contentView.setErrorView(description: description)
    }
    
}

extension ErrorAlertViewController: AlertViewDelegate {
    func hideView() {
        self.delegate?.hideView()
    }
}
