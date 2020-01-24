//
//  ViewController.swift
//  Alarm
//
//  Created by Yichuan Wang on 23/1/20.
//  Copyright © 2020 Wang Yichuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLbel: UILabel!
    let dateformatter = DateFormatter()
    var isGrantedNotificationAccess:Bool = false
    private let log = Log()
    
    @IBAction func sendNotification(_ sender: Any) {

        if isGrantedNotificationAccess{
            triggerNotification()
        }
    }
    
    func askNotificationRequest(){
        UNUserNotificationCenter.current().requestAuthorization(
                      options: [.alert,.sound,.badge],
                      completionHandler: { (granted,error) in
                          self.isGrantedNotificationAccess = granted
                  })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        askNotificationRequest()
       }
    
    func triggerNotification(){
        let content = UNMutableNotificationContent()
        content.setValue("YES", forKeyPath: "shouldAlwaysAlertWhileAppIsForeground")
        content.title = NSString.localizedUserNotificationString(forKey: "Notification Testing", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "This is a test", arguments: nil)
        content.sound = UNNotificationSound.default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber;
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1.0,
            repeats: false)

        let request = UNNotificationRequest.init(identifier: "testTriggerNotif", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    
    
    func consumeLog(log: String) {
        dateformatter.dateFormat = "HH:mm:ss"
        myLbel.text = dateformatter.string(from: Date())
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            self?.log.requestLog{ data in
                self?.consumeLog(log: data)
            }
        }
    }
}

class Log {
    func requestLog(consume: (_ log: String) -> Void) {
        let slog = "Data from wherever"
        consume(slog)
    }
}

