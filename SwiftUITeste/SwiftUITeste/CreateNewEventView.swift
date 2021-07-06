//
//  CreateNewEventView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct CreateNewEventView: View {
    
    @StateObject var event: EventEntity = EventEntity()
    @State var showTimeOfEvent: Bool = false
    
    var body: some View {
        Form{
            Section {
                EventLabelView(title: "Nome do Evento",
                               image: Image(systemName: "keyboard"),
                               backgroundColor: .green)
                
                TextField("Nome do Evento",
                          text: $event.title)
                    .autocapitalization(.words)
            }
            
            Section {
                EventLabelView(title: "Data do Evento",
                               image: Image(systemName: "calendar"),
                               backgroundColor: .blue)
                
                DatePicker("Data do Evento",
                           selection: $event.date,
                           displayedComponents: self.showTimeOfEvent ? [.date, .hourAndMinute] : [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                Toggle(isOn: $showTimeOfEvent) {
                    EventLabelView(title: "Hora do Evento",
                                   image: Image(systemName: "clock.fill"),
                                   backgroundColor: .blue)
                }
            }
            
            Section {
                ColorPicker(selection: $event.color) {
                    EventLabelView(title: "Cor da categoria do evento",
                                   image: Image(systemName: "eyedropper"),
                                   backgroundColor: .yellow)
                }
            }
            
            Section {
                EventLabelView(title: "URL",
                               image: Image(systemName: "link"),
                               backgroundColor: .orange)
                TextField("Adicione uma URL para o seu evento", text: $event.url)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }
        }
        
    }
}

struct CreateNewEvent_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewEventView()
    }
}
