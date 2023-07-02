//
//  SkillsWispApp.swift
//  SkillsWisp
//
//  Created by M Tayyab on 08/05/2023.
//

import SwiftUI

@main
struct SkillsWispApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
