//
//  AlertViewController.swift
//  LabMaster
//
//  Created by Robert Moryson on 01/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

class AlertViewController: NSViewController {
    
    @IBOutlet var contentView: AlertView!
    
    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // public functions
    public func setConfirmationView(name: String, id: Int) {
        self.contentView.setConfirmationView(name: name, id: id)
    }
    
}
