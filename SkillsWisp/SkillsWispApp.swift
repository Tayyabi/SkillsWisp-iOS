//
//  SkillsWispApp.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/05/2023.
//

import SwiftUI
import FirebaseCore

@main
struct SkillsWispApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
