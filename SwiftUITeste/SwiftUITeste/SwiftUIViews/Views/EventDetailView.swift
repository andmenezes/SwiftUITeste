//
//  EventDetailView.swift
//  SwiftUITeste
//
//  Created by André Menezes on 27/07/23.
//

import SwiftUI

struct EventDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var event: EventEntity
    var isDiscover = false
    let verticalSpacing: CGFloat = 5
    
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
            
            Text("\(self.event.timeFromNow()) no dia \(self.event.dateAsString())")
                .font(.title2)
        
            Spacer()
            
            if let eventUrl = self.event.validUrl() {
                
                Button(action: {
                    UIApplication.shared.open(eventUrl)
                }) {
                    EventDetailViewButton(imageSystemName: "link",
                                          text: "Visite o Site",
                                          backgroundColor: .orange)
                }
                .padding(.vertical, self.verticalSpacing)
            }
            
            if isDiscover {
                
                let hasBeenAdded = self.event.hasBeenAdded
                
                Button(action: {
                    DataController.shared.addFromDiscover(event: self.event)
                }) {
                    EventDetailViewButton(imageSystemName: "plus.circle",
                                          text: hasBeenAdded ? "Evento já adicionado" : "Adicionar",
                                          backgroundColor: .green)
                }
                .disabled(hasBeenAdded ? true : false)
                .opacity(hasBeenAdded ? 0.5 : 1.0 )
                .padding(.vertical, self.verticalSpacing)
                
            } else {
                Button(action: {}) {
                    EventDetailViewButton(imageSystemName: "pencil.circle",
                                          text: "Editar evento",
                                          backgroundColor: .blue)
                }
                .padding(.vertical, self.verticalSpacing)
                
                Button(action: {
                    DataController.shared.deleteEvent(event: self.event)
                }) {
                    EventDetailViewButton(imageSystemName: "trash",
                                          text: "Deletar o evento",
                                          backgroundColor: .red)
                }
                .padding(.vertical, self.verticalSpacing)
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventDetailView(event: EventEntity.testEvent1)
                .previewLayout(.sizeThatFits)
            EventDetailView(event: EventEntity.testEvent2)
                .previewLayout(.sizeThatFits)
        }
    }
}
