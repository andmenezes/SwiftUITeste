//
//  CreateNewEventView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct CreateNewEventView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var event: EventEntity = EventEntity()
    @State var showTimeOfEvent: Bool = false
    @State var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            
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
                               displayedComponents: self.datePickerComponentsToShow())
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Toggle(isOn: $showTimeOfEvent) {
                        EventLabelView(title: "Hora do Evento",
                                       image: Image(systemName: "clock.fill"),
                                       backgroundColor: .blue)
                    }
                }
                
                Section {
                    
                    if let image = self.event.image() {
                        HStack {
                            EventLabelView(title: "",
                                           image: Image(systemName: "camera"),
                                           backgroundColor: .purple)
                            
                            Spacer()
                            
                            Button(action: {
                                self.event.imageData = nil
                                self.showImagePicker = false
                            }){
                                Text("Remover Imagem")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle()) //Arruma um Bug no swiftUI de ao tocare em um botão numa Section outros botões na mesma section dispara suas actions tbm
                        }
                        
                        Button(action: {
                            self.showImagePicker = true
                        }){
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        }
                        .buttonStyle(BorderlessButtonStyle()) //Arruma um Bug no swiftUI de ao tocare em um botão numa Section outros botões na mesma section dispara suas actions tbm
                    }else {
                        HStack {
                            EventLabelView(title: "",
                                           image: Image(systemName: "camera"),
                                           backgroundColor: .purple)
                            
                            Spacer()
                            
                            Button(action: {
                                self.showImagePicker = true
                            }){
                                Text("Selecione uma imagem")
                            }
                        }
                    }
                    
                }.sheet(isPresented: $showImagePicker) {
                    ImagePickerUISwiftHelper(imageDate: $event.imageData)
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
            .navigationTitle("Novo Evento")
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancelar")
            }, trailing: Button(action:{
                DataController.shared.events.append(self.event)
                DataController.shared.saveData()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Pronto")
            })
        }
        
        
    }
}

extension CreateNewEventView {
    func datePickerComponentsToShow() -> DatePickerComponents {
        return self.showTimeOfEvent ? [.date, .hourAndMinute] : [.date]
    }
}

struct CreateNewEvent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateNewEventView()
        }
        
    }
}
