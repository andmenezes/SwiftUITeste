//
//  PastEventsView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 13/07/2021.
//

import SwiftUI

struct PastEventsView: View {
    
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        EventsListView(events: self.data.pastEvents, noEventText: "Nenhum evento para exibir aqui, você tem que adicionar mais eventos")
        
        .navigationTitle("Eventos passados")
    }
}

struct PastEventsView_Previews: PreviewProvider {
    static var previews: some View {
        PastEventsView()
    }
}
