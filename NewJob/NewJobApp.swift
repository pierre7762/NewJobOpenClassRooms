//
//  NewJobApp.swift
//  NewJob
//
//  Created by Pierre on 07/01/2022.
//

import SwiftUI

@main
struct NewJobApp: App {
//    @StateObject private var dataController = DataController()
//    let myController = PersistenceManager.shared
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .preferredColorScheme(.light)
        }
    }
}
