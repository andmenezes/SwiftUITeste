//
//  EventsListView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 13/07/2021.
//

import SwiftUI

struct EventsListView: View {
    
    var events: [EventEntity]
    var noEventText: String
    var isDiscover = false
    
    var body: some View {
        ScrollView {
            VStack {
                if self.events.count == 0 {
                    Spacer()
                    
                    Text(self.noEventText)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.top, 200)
                        .padding(.horizontal, 20)
                    Spacer()
                    
                } else {
                    ForEach(self.events) { event in
                        NavigationLink(destination: EventDetailView(event: event,
                                                                    isDiscover: self.isDiscover)) {
                            EventTileView(event: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                }
            }
        }
    }
    
    struct EventsListView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                EventsListView(events: [EventEntity.testEvent1, EventEntity.testEvent2], noEventText: "teste")
                EventsListView(events: [], noEventText: "Você ainda não tem eventos para acompanhar 😥\nCrie um evento novo ou de uma olhada na aba de descobertas.")
                    .previewDevice("iPhone SE (2nd generation)")
                
            }
            
        }
    }
    
}
