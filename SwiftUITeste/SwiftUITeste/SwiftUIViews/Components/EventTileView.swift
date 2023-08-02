//
//  EventTileView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 12/07/2021.
//

import SwiftUI

struct EventTileView: View {
    
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var event: EventEntity

    var body: some View {

        let isDarkMode = colorScheme == .dark
        let darkBackgroundColor: Color = Color(.systemGray6)
        let backgroundColor: Color = isDarkMode ? darkBackgroundColor : .white
        
        VStack(spacing: 0) {

            if let imageData = self.event.imageData,
               let uiImage = UIImage(data: imageData)
            {
                let image = Image(uiImage: uiImage)
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Rectangle()
                .foregroundColor(self.event.color)
                .frame(height: 15)

            HStack {
                Text(self.event.title)
                    .font(.title)
                    .padding(10)
                Spacer()
            }
            .background(backgroundColor)

            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.red)

                Text(self.event.dateAsString())

                Spacer()

                Text(self.event.timeFromNow())

                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)

            }
            .font(.title3)
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .background(backgroundColor)

        }
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

struct EventTileView_Previews: PreviewProvider {
    static var previews: some View {
        EventTileView(event: EventEntity.testEvent1)
            .previewLayout(.sizeThatFits)
    }

}
