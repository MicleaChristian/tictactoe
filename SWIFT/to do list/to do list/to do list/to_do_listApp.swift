//
//  to_do_listApp.swift
//  to do list
//
//  Created by goldorak on 12/09/2023.
//

import SwiftUI

@main
struct to_do_listApp: App {
    @StateObject private var taskStore = TaskStore() // Create an instance of TaskStore

    var body: some Scene {
        WindowGroup {
            ContentView(taskStore: taskStore) // Use the instance of TaskStore
        }
    }

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }
}
