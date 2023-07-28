//
//  EventDetailButtonView.swift
//  SwiftUITeste
//
//  Created by André Menezes on 27/07/23.
//

import SwiftUI

struct EventDetailViewButton: View {
    var imageSystemName: String
    var text: String
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: self.imageSystemName)
            Text(self.text)
            Spacer()
        }
        .font(.title2)
        .padding(12)
        .cornerRadius(10)
        .background(self.backgroundColor)
        .foregroundColor(.white)
        .padding(.horizontal, 10)
    }
}

struct EventDetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailViewButton(imageSystemName: "link", text: "Visite o Site", backgroundColor: .orange)
    }
}
