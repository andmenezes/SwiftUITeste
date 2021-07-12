//
//  EventEntity.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import Foundation
import SwiftUI

class EventEntity: ObservableObject, Identifiable {
    var id: UUID = UUID()
    var date: Date = Date()
    var title: String = ""
    var url: String = ""
    var color: Color = Color.purple
    @Published var imageData: Data?
    
    func image() -> Image? {
        
        if let imageData = self.imageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
}

extension EventEntity {
    static var testEvent1: EventEntity {
        let event = EventEntity()
        
        event.title = "WWDC 2020"
        event.date = Date()
        event.color = .green
        event.url = "www.apple.com"
        
        if let image = UIImage(named: "wwdc"), let data = image.pngData() {
            event.imageData = data
        }
        
        return event
    }
    
    static var testEvent2: EventEntity {
        let event = EventEntity()
        
        event.title = "Viagem em familia para Ilha bela depois vamos para o Rio de Janeiro"
        event.date = Date()
        event.color = .blue

        return event
    }
}
