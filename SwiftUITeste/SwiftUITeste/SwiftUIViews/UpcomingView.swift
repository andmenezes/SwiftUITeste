//
//  UpcomingView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    @ObservedObject var data = DataController.shared
    
    
    var body: some View {
        EventsListView(events: self.data.upcomingEvents, noEventText: "Você ainda não tem eventos para acompanhar 😥\nCrie um evento novo ou de uma olhada na aba de descobertas.")
        
        .navigationTitle("Próximos Eventos")
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.showingCreateView = true
                                }) {
                                    Image(systemName: "calendar.badge.plus")
                                        .font(.title)
                                }
            .sheet(isPresented: $showingCreateView, content: {
                CreateNewEventView()
            })
                            
                            
        )
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NavigationView{
                
                UpcomingView()
            }
            
            NavigationView{
                UpcomingView()
            }
            
        }
    }
}
