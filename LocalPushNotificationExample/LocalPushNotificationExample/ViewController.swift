//
//  ViewController.swift
//  LocalPushNotificationExample
//
//  Created by Jackson Taylor on 1/12/17.
//  Copyright © 2017 WillowTree Apps, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.sound, .alert, .badge]) { (permissionGranted, error) in
            // permissionGranted -> A boolean to let you know whether or not the user
            //                      will allow you to send them notifications. One thing
            //                      to note here is that if the user did say no and you try
            //                      to send a notification, nothing will happen. The code will
            //                      simply execute but the user will not be notified. Best practice
            //                      though is to keep track of the permissions and only send them
            //                      if the user grants you permission.
            
            // error -> An error object will let you know if anything else goes wrong. 
        }
    }
    
    @IBAction func sendLocalNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "I am a notification"
        notificationContent.body = "And I say Hello World!"
        
        // you can actually add a lot more content to the notification. If you want to do that
        // then, command click on the UNMutableNotificationContent initializer above or checkout
        // the web docs at: https://developer.apple.com/reference/usernotifications/unmutablenotificationcontent
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        // the line above sets up a trigger so that our notification will show in 7 seconds. 
        
        // now let's setup the request for the notification
        let request = UNNotificationRequest(identifier: "HelloWorld", content: notificationContent, trigger: trigger)
        // the identifier for the request can be used if we wanted to cancel the notification
        // notice that we pass in the content and trigger into the request so that the device
        // will know exactly what we want when it needs to display the notification
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        // this is done just so that we can respond to the willPresent notification delegate method
        
        center.add(request) { error in
            // we could handle the error in here just in case anything happens.
        }
    }
    
    // remove the delegate from the notification center
    deinit {
        let center = UNUserNotificationCenter.current()
        center.delegate = nil
    }
}


extension ViewController: UNUserNotificationCenterDelegate {
    // this delegate method allows us to show the notification even though the app is in the foreground. This
    // way you don't have to close the app to view your notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
}

