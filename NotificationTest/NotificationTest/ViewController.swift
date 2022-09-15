//
//  ViewController.swift
//  NotificationTest
//
//  Created by M1 on 15.09.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Date()
        textField.delegate = self
    }
    
    private func sendNotification(withBody body: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "New event"
        content.body = body
        
        let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "customIdentifier",
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction private func sendPressed(_ sender: Any) {
        let body = textField.text ?? ""
        sendNotification(withBody: body, date: datePicker.date)
    }
    
    @IBAction private func removeAllPressed(_ sender: Any) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
