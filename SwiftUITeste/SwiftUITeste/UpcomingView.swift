//
//  UpcomingView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct UpcomingView: View {
    
    @State var showingCreateView = false
    
    
    var body: some View {
        Text("Próximos")
            .navigationTitle("Próximos")
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
        UpcomingView()
    }
}
