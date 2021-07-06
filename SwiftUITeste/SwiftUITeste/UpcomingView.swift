//
//  UpcomingView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct UpcomingView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle("Próximos")
            .navigationBarItems(trailing:
                                    Button(action: {}) {
                                        Image(systemName: "calendar.badge.plus")
                                            .font(.title)
                                    }
                                
                                
            )
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
