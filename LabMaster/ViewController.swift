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
    var alertViewController: AlertViewController?
    
    // outlets
    @IBOutlet weak var studentIdTextField: NSTextField!
    @IBOutlet weak var alertView: NSView!
    
    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationView" {
            self.alertViewController = segue.destinationController as? AlertViewController
        }
    }
    
    // actions
    @IBAction func didTapConfirmAttendance(_ sender: Any) {
        let studentIdString = self.studentIdTextField.stringValue
        guard let studentId = Int(studentIdString) else { return }
        let request = AttendanceRequest(id: Constants.station.id, studentId: studentId)
        apiClient.postAttendance(request) { result in
            switch try? result.get() {
            case .ok:
                self.alertViewController?.setConfirmationView(name: "Jakub", id: studentId)
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

