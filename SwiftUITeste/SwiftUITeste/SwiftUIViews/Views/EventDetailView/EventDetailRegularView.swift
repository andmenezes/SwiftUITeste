//
//  EventDetailRegularView.swift
//  Meus Eventos
//
//  Created by André Menezes on 31/07/23.
//

import SwiftUI

struct EventDetailRegularView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var isDiscover = false
    @ObservedObject var event: EventEntity
    
    @State var showingCreateView = false
    @State var deleted = false
    let verticalSpacing: CGFloat = 5
    
    var body: some View {
        
        let isDarkMode = colorScheme == .dark
        let darkBackgroundColor: Color = Color(.systemGray6)
        let backgroundColor: Color = isDarkMode ? darkBackgroundColor : .white
        
        if self.deleted {
            Text("Selecione um evento")
        } else {
            VStack {
                VStack(spacing: 0) {
                    
                    if let imageData = self.event.imageData,
                       let uiImage = UIImage(data: imageData)
                    {
                        let image = Image(uiImage: uiImage)
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else {
                        
                        self.event.color
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Text(self.event.title)
                        .font(.largeTitle)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    
                    Text("\(self.event.timeFromNow().capitalizedSentence) no dia \(self.event.dateAsString())")
                        .font(.title)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 20)
                    
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.horizontal, 40)
                
                HStack {
                    if let eventUrl = self.event.validUrl() {
                        
                        Button(action: {
                            UIApplication.shared.open(eventUrl)
                        }) {
                            EventDetailViewRegularButton(imageSystemName: "link",
                                                         text: "Visite o Site",
                                                         backgroundColor: .orange)
                        }
                    }
                    
                    if isDiscover {
                        
                        let hasBeenAdded = self.event.hasBeenAdded
                        
                        Button(action: {
                            DataController.shared.addFromDiscover(event: self.event)
                        }) {
                            EventDetailViewRegularButton(imageSystemName: "plus.circle",
                                                         text: hasBeenAdded ? "Evento já adicionado" : "Adicionar",
                                                         backgroundColor: .green)
                        }
                        .disabled(hasBeenAdded ? true : false)
                        .opacity(hasBeenAdded ? 0.5 : 1.0 )
                        
                    } else {
                        Button(action: {
                            showingCreateView = true
                        }) {
                            EventDetailViewRegularButton(imageSystemName: "pencil.circle",
                                                         text: "Editar evento",
                                                         backgroundColor: .blue)
                        }
                        .sheet(isPresented: $showingCreateView, content: {
                            CreateNewEventView(event: self.event)
                        })
                        
                        Button(action: {
                            DataController.shared.deleteEvent(event: self.event)
                            self.deleted = true
                        }) {
                            EventDetailViewRegularButton(imageSystemName: "trash",
                                                         text: "Deletar o evento",
                                                         backgroundColor: .red)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .padding(35)
                .padding(.top, 15)
            }
        }
    }
}


struct EventDetailRegularView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventDetailRegularView(event: EventEntity.testEvent1)
            EventDetailRegularView(event: EventEntity.testEvent2)
        }
    }
}
