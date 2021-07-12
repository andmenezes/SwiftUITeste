//
//  UpcomingView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    var events: [EventEntity] = []
    
    
    var body: some View {
        ScrollView{
            VStack {
                if self.events.count == 0 {
                    Spacer()
                    Text("Você ainda não tem eventos para acompanhar 😥\nCrie um evento novo ou de uma olhada na aba de descobertas.")
                        .bold()
                        .multilineTextAlignment(.center)
                    Spacer()
                    
                }else{
                    ForEach(self.events) { event in
                        EventTileView(event: event)
                    }
                 
                }
            }
        }
        
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
                UpcomingView(events: [EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2,EventEntity.testEvent1, EventEntity.testEvent2])
            }
            
            NavigationView{
                UpcomingView(events: [])
            }
            
        }
    }
}
