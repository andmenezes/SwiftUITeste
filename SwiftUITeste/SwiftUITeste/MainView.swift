//
//  MainView.swift
//  Meus Eventos
//
//  Created by André Menezes on 31/07/23.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            HomeTabView()
        } else {
            HomeSideBarView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
