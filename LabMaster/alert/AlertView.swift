//
//  AlertView.swift
//  LabMaster
//
//  Created by Robert Moryson on 01/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

protocol AlertViewDelegate {
    func hideView()
}

class AlertView: NSView {
    
    // properties
    var delegate: AlertViewDelegate?
    private var name: String? {
        didSet {
            guard let name = name else { return }
            self.greetingsTextField.stringValue = "Witaj, \(name)"
        }
    }
    private var studentId: Int? {
        didSet {
            guard let studentId = studentId else { return }
            self.studentIdTextField.stringValue = "Twój numer: \(studentId)"
        }
    }
    
    // outlets
    @IBOutlet weak var greetingsTextField: NSTextField!
    @IBOutlet weak var studentIdTextField: NSTextField!
    
    // lifecycle
    override func awakeFromNib() {
        wantsLayer = true
        layer?.backgroundColor = .init(gray: 0.95, alpha: 1)
        layer?.cornerRadius = 10
    }
    
    // public func
    public func setConfirmationView(name: String, id: Int) {
        self.name = name
        self.studentId = id
    }
    
    @IBAction func didTapOkButton(_ sender: NSButton) {
        self.delegate?.hideView()
    }
    
}
