//
//  ViewController.swift
//  LabMaster
//
//  Created by Robert Moryson on 23/08/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // properties
    let apiClient = ApiClient()
    let readerId = 5467

    // outlets
    @IBOutlet weak var studentIdTextField: NSTextField!
    @IBOutlet weak var alertView: NSView!
    
    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertView.wantsLayer = true
        self.alertView.layer?.backgroundColor = .init(gray: 0.95, alpha: 1)
        self.alertView.layer?.cornerRadius = 10
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // actions
    @IBAction func didTapConfirmAttendance(_ sender: Any) {
        let studentIdString = self.studentIdTextField.stringValue
        guard let studentId = Int(studentIdString) else { return }
        let request = AttendanceRequest(id: readerId, studentId: studentId)
        apiClient.postAttendance(request) { result in
            switch try? result.get() {
            case .ok:
                self.alertView.isHidden = false
            case .wrongId:
                break
            case .serverError:
                break
            default:
                break
            }
        }
    }
    
}

