//
//  AlertViewController.swift
//  LabMaster
//
//  Created by Robert Moryson on 01/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

protocol AlertViewControllerDelegate {
    func hideView()
}

class AlertViewController: NSViewController {
    
    // properties
    public var delegate: AlertViewControllerDelegate?
    
    // outlets
    @IBOutlet var contentView: AlertView!
    
    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.delegate = self
    }
    
    // public functions
    public func setConfirmationView(name: String, id: Int) {
        self.contentView.setConfirmationView(name: name, id: id)
    }
    
}

extension AlertViewController: AlertViewDelegate {
    func hideView() {
        self.delegate?.hideView()
    }
}
