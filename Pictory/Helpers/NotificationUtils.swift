//
//  NotificationUtils.swift
//  Pictory
//
//  Created by Edvaldo Martins on 30/11/2023.
//

import Foundation
import UserNotifications

final class NotificationUtils {
    static func show(message: String? = nil, title: String? = nil) {
        let content = UNMutableNotificationContent()
        content.title = title ?? "Pictory"
        content.body = message ?? "New notification"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest.init(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
