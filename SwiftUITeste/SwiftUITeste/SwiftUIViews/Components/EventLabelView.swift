//
//  EventLabelView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct EventLabelView: View {

    var title: String
    var image: Image
    var backgroundColor: Color

    var body: some View {
        Label {
            Text(self.title)

        } icon: {
            self.image
                .padding(4)
                .background(self.backgroundColor)
                .cornerRadius(7)
                .foregroundColor(.white)
        }

    }
}

struct EventLabelView_Previews: PreviewProvider {
    static var previews: some View {
        EventLabelView(title: "Title", image: Image(systemName: "keyboard"), backgroundColor: .blue)
    }
}
