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
    var configurationViewController: ConfigurationViewController?
    
    // outlets
    @IBOutlet weak var stationIdLabel: NSTextField!
    @IBOutlet weak var studentIdTextField: NSTextField!
    @IBOutlet weak var attendanceAlertView: NSView!
    @IBOutlet weak var errorAlertView: NSView!
    
    @IBOutlet weak var subjectInfoLabel: NSTextField!
    @IBOutlet weak var lecturerLabel: NSTextField!
    
    
    // lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStation()
    }
    
    private func prepareStation() {
        let defaults = UserDefaults.standard
        let stationId = defaults.integer(forKey: "StationId")
        guard stationId != 0 else {
            return
        }
        self.stationIdLabel.stringValue = "Stanowisko \(stationId)"
        
        prepareClassInfo()
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
        } else if segue.identifier == "Configuration" {
            self.configurationViewController = segue.destinationController as? ConfigurationViewController
            self.configurationViewController?.delegate = self
        }
    }
    
    // actions
    @IBAction func didTapConfirmAttendance(_ sender: Any) {
        let studentIdString = self.studentIdTextField.stringValue
        guard let studentId = Int(studentIdString) else {
            self.showErrorAlert(withDescription: "wrongId")
            return
        }
        
        let defaults = UserDefaults.standard
        let stationId = defaults.integer(forKey: "StationId")
        guard stationId != 0 else {
            self.showErrorAlert(withDescription: "Stacja nie jest skonfigurowana")
            return
        }
        
        let request = AttendanceRequest(id: stationId, studentId: studentId)
        apiClient.postAttendance(request) { result in
            switch try? result.get().0 {
            case .ok:
                guard let name = try? result.get().1 else { return }
                self.showAttendanceAlert(name: name, id: studentId)
            case .wrongId:
                self.showErrorAlert(withDescription: "Nie znaleziono stanowiska")
            case .serverError:
                self.showErrorAlert(withDescription: "Błąd serwera")
            default:
                break
            }
        }
    }
    
    // private functions
    
    private func prepareClassInfo() {
        let defaults = UserDefaults.standard
        let stationId = defaults.integer(forKey: "StationId")
        guard stationId != 0 else {
            self.subjectInfoLabel.stringValue = ""
            self.lecturerLabel.stringValue = ""
            return
        }
        let infoRequest = InfoRequest(id: stationId)
        apiClient.getInfo(infoRequest) { result in
            guard let result = result else { return }
            self.subjectInfoLabel.stringValue = "Zajęcia: \(result.subject)"
            self.lecturerLabel.stringValue = "Prowadzący: \(result.name) \(result.surname)"
        }
    }
    
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
        self.errorAlertView.isHidden = true
    }
}

extension ViewController: ConfigurationViewControllerDelegate {
    func dismissAndChangeConfiguration() {
        self.prepareStation()
    }
}
