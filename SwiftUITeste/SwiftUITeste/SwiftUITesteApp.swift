//
//  SwiftUITesteApp.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

@main
struct SwiftUITesteApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear(perform: {
                    DataController.shared.loadData()
                    DataController.shared.getDiscoveryEventsAPiData()
                })
        }
    }
}
