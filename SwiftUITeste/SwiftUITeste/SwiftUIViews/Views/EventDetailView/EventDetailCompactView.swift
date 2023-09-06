//
//  EventDetailCompactView.swift
//  Meus Eventos
//
//  Created by André Menezes on 31/07/23.
//

import SwiftUI
import UserNotifications

struct EventDetailCompactView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var event: EventEntity
    @State var showingCreateView = false
    @State var deleted = false
    
    var isDiscover = false
    
    private let verticalSpacing: CGFloat = 5
    
    
    var body: some View {
        let isDarkMode = colorScheme == .dark
        let darkBackgroundColor: Color = Color(.systemGray6)
        let backgroundColor: Color = isDarkMode ? darkBackgroundColor : .white
        
        if self.deleted {
            Text("Selecione um evento")
        } else {
            VStack(spacing: 0) {
                
                if let imageData = self.event.imageData,
                   let uiImage = UIImage(data: imageData)
                {
                    let image = Image(uiImage: uiImage)
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Rectangle()
                        .foregroundColor(self.event.color)
                        .frame(height: 15)
                } else {
                    Rectangle()
                        .foregroundColor(self.event.color)
                        .aspectRatio(contentMode: .fit)
                }
                
                HStack {
                    Spacer()
                    Text(self.event.title)
                        .font(.title)
                        .padding(10)
                    Spacer()
                }
                .background(backgroundColor)
                
                Text("\(self.event.timeFromNow()) no dia \(self.event.dateAsString())")
                    .font(.title2)
                
                if  !self.event.address.isEmpty {
                    Text("Endereço: \(self.event.address)").onTapGesture {
                        DeepLinkHelpers().canOpenWithGps(address: self.event.address)
                    }
                    .padding(.top, 20)
                }
                
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
                    
                    Button(action: {
                        showingCreateView = true
                    }) {
                        EventDetailViewButton(imageSystemName: "pencil.circle",
                                              text: "Editar evento",
                                              backgroundColor: .blue)
                    }
                    .padding(.vertical, self.verticalSpacing)
                    .sheet(isPresented: $showingCreateView, content: {
                        CreateNewEventView(event: self.event)
                    })
                    
                    //MARK - New Feature Local Notification
                    
//                    if let notifyUser = self.event.notifyUser, !notifyUser {
//                        Button(action: {
////                            self.addNotification()
//                        }) {
//                            EventDetailViewButton(imageSystemName: "bell",
//                                                  text: "Esse evento já será notificado",
//                                                  backgroundColor: .green)
//                        }
//                        .padding(.vertical, self.verticalSpacing)
//                        .disabled(true)
//
//                    }else {
//                        Button(action: {
//                            self.addNotification()
//                        }) {
//                            EventDetailViewButton(imageSystemName: "bell",
//                                                  text: "Notificar",
//                                                  backgroundColor: .green)
//                        }
//                        .padding(.vertical, self.verticalSpacing)
//                    }
                    
                    Button(action: {
                        DataController.shared.deleteEvent(event: self.event)
                        self.deleted = true
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
    
    func checkIfNotificationIsPossible() -> Bool {
        
        var hasAuthorization = false

        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                hasAuthorization =  true
            }
        }
        
        return hasAuthorization
    }
    
    func addNotification() {
        
        if checkIfNotificationIsPossible() {
            let content = UNMutableNotificationContent()
            content.title = "Você pediu para que te lembrassemos de:"
            content.subtitle = self.event.title
            content.sound = UNNotificationSound.default

            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.event.date.timeIntervalSinceNow, repeats: false)

            // choose a random identifier
            let request = UNNotificationRequest(identifier: self.event.id, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        
        
        
    }
}

struct EventDetailCompactView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailCompactView(event: EventEntity.testEvent1)
    }
}
