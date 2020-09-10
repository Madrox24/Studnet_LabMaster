//
//  ConfigurationViewController.swift
//  LabMaster
//
//  Created by Robert Moryson on 10/09/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

protocol ConfigurationViewControllerDelegate: AnyObject {
    func dismissAndChangeConfiguration()
}

class ConfigurationViewController: NSViewController {
    
    // properties
    let apiClient = ApiClient()
    weak var delegate: ConfigurationViewControllerDelegate?
    
    @IBOutlet weak var roomTextField: NSTextField!
    @IBOutlet weak var positionTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var errorLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSaveButton(_ sender: NSButton) {
        self.errorLabel.isHidden = true
        
        let room = self.roomTextField.stringValue
        let positionString = self.positionTextField.stringValue
        guard let positionId = Int(positionString) else {
            showErrorAlert(text: "Popraw pole: numer miejsca")
            return
        }
        let password = self.passwordTextField.stringValue
        
        let request = RegisterRequest(room: room, position: positionId, adminKey: password)
        
        apiClient.postRegister(request) { [weak self] result in
            switch try? result.get() {
            case .ok:
                self?.delegate?.dismissAndChangeConfiguration()
                self?.dismiss(self)
            case .wrongKey:
                self?.showErrorAlert(text: "Hasło jest niepoprawne")
            case .serverError:
                self?.showErrorAlert(text: "Problem z serwerem")
            default:
                break
            }
        }
        
    }
    
    
    @IBAction func didTapDismissButton(_ sender: NSButton) {
        self.dismiss(self)
    }
    
    private func showErrorAlert(text: String) {
        self.errorLabel.stringValue = text
        self.errorLabel.isHidden = false
    }
}
