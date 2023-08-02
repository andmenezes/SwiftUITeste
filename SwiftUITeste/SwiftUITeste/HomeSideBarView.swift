//
//  HomeSideBarView.swift
//  Meus Eventos
//
//  Created by André Menezes on 31/07/23.
//

import SwiftUI

struct HomeSideBarView: View {
    
    @State private var showingCreateView = false
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UpcomingView()) {
                    Label("Próximos", systemImage: "calendar")
                }
                NavigationLink(destination: DiscoverEventsView()) {
                    Label("Descubra", systemImage: "magnifyingglass")
                }
                NavigationLink(destination: PastEventsView()) {
                    Label("Passado", systemImage: "gobackward")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Meus Eventos")
            .overlay(bottomSideBarView, alignment: .bottom)
            
            UpcomingView()
            
            Text("Selecione um evento")
        }
    }
    
    var bottomSideBarView: some View {
        VStack {
            Divider()
            Button(action: {
                self.showingCreateView = true
            }) {
                Image(systemName: "calendar.badge.plus")
                Text("Novo Evento")
            }.sheet(isPresented: $showingCreateView, content: {
                CreateNewEventView()
            })
        }
    }
}

struct HomeSideBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSideBarView()
    }
}
