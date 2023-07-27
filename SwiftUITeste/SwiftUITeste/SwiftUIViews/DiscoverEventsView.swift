//
//  DiscoverEventsView.swift
//  SwiftUITeste
//
//  Created by André Menezes on 27/07/23.
//

import SwiftUI

struct DiscoverEventsView: View {
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        EventsListView(events: self.data.discoveryEvents.sorted {$0.date < $1.date}, noEventText: "Estamos carregando uns eventos maneiros para você 🤘🏻")
        
            .navigationTitle("Descubra")
            .navigationBarItems(trailing:
                                    Button(action: {
                data.getDiscoveryEventsAPiData()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.body)
            }
            )
    }
}

struct DiscoverEventsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverEventsView()
    }
}
