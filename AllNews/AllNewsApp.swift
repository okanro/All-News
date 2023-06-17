//
//  AllNewsApp.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import SwiftUI

@main
struct AllNewsApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
        }
    }
}
