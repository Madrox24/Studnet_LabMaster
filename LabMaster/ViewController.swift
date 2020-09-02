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
    var attendanceAlertViewController: AttendanceAlertViewController?
    var errorAlertViewController: ErrorAlertViewController?
    
    // outlets
    @IBOutlet weak var studentIdTextField: NSTextField!
    @IBOutlet weak var attendanceAlertView: NSView!
    @IBOutlet weak var errorAlertView: NSView!
    
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
        if segue.identifier == "AttendanceAlertView" {
            self.attendanceAlertViewController = segue.destinationController as? AttendanceAlertViewController
            self.attendanceAlertViewController?.delegate = self
        } else if segue.identifier == "ErrorView" {
            self.errorAlertViewController = segue.destinationController as? ErrorAlertViewController
            self.errorAlertViewController?.delegate = self
        }
    }
    
    // actions
    @IBAction func didTapConfirmAttendance(_ sender: Any) {
        let studentIdString = self.studentIdTextField.stringValue
        guard let studentId = Int(studentIdString) else {
            self.showErrorAlert(withDescription: "wrongId")
            return
        }
        let request = AttendanceRequest(id: Constants.station.id, studentId: studentId)
        apiClient.postAttendance(request) { result in
            switch try? result.get() {
            case .ok:
                self.showAttendanceAlert(name: "Jakub", id: studentId)
            case .wrongId:
                self.showErrorAlert(withDescription: "wrongId")
            case .serverError:
                self.showErrorAlert(withDescription: "wrongId")
            default:
                break
            }
        }
    }
    
    // private functions
    private func showAttendanceAlert(name: String, id: Int) {
        self.attendanceAlertViewController?.setConfirmationView(name: name, id: id)
        self.attendanceAlertView.isHidden = false
        self.errorAlertView.isHidden = true
    }
    
    private func showErrorAlert(withDescription description: String) {
        self.errorAlertViewController?.setErrorView(description: description)
        self.attendanceAlertView.isHidden = true
        self.errorAlertView.isHidden = false
    }
    
}

extension ViewController: AlertViewControllerDelegate {
    func hideView() {
        self.attendanceAlertView.isHidden = true
    }
}
