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
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            
            Form {
                
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
                    .frame(height: 340)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    
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
                            }) {
                                Text("Remover Imagem")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle()) //Fix a swiftUI bug that when a button was touched they triger other buttons on the same section
                        }
                        
                        Button(action: {
                            self.showImagePicker = true
                        }) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        }
                        .buttonStyle(BorderlessButtonStyle()) //Fix a swiftUI bug that when a button was touched they triger other buttons on the same section
                    } else {
                        HStack {
                            EventLabelView(title: "",
                                           image: Image(systemName: "camera"),
                                           backgroundColor: .red)
                            Spacer()
                            Button(action: {
                                self.showImagePicker = true
                            }) {
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
                                       backgroundColor: .purple)
                    }
                }
                
                Section {
                    EventLabelView(title: "Endereço",
                                   image: Image(systemName: "map"),
                                   backgroundColor: .yellow)
                    TextField("Adicione um endereço para o seu evento", text: $event.address)
                        .autocapitalization(.none)
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
                    .font(.title2)
            }, trailing: Button(action: {
                self.checkIfCanBeSave()
            }) {
                Text("Salvar")
                    .font(.title2)
                    .bold()
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Erro ao salvar seu evento"),
                      message: Text("O Evento precisa ter um Nome"),
                      dismissButton: .default(Text("Ok!")))
            }
        }
    }
    
    func checkIfCanBeSave() {
        if self.event.title.isEmpty {
            showingAlert = true
        } else {
            DataController.shared.saveEvent(event: self.event)
            self.presentationMode.wrappedValue.dismiss()
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
