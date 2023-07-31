//
//  EventDetailViewRegularButton.swift
//  SwiftUITeste
//
//  Created by André Menezes on 31/07/23.
//

import SwiftUI

struct EventDetailViewRegularButton: View {
    var imageSystemName: String
    var text: String
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: self.imageSystemName)
            Text(self.text)
        }
        .padding(12)
        .font(.title2)
        .cornerRadius(10)
        .background(self.backgroundColor)
        .foregroundColor(.white)
    }
}
struct EventDetailViewRegularButton_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailViewRegularButton(imageSystemName: "link", text: "Visite o Site", backgroundColor: .orange)
    }
}
