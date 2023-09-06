//
//  EventEntity.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import Foundation
import SwiftUI
import SwiftDate
import UIColor_Hex_Swift

class EventEntity: ObservableObject, Identifiable, Codable {
    @Published var id: String = UUID().uuidString
    @Published var date: Date = Date()
    @Published var title: String = ""
    @Published var address: String = ""
    @Published var url: String = ""
    @Published var color: Color = Color.purple
    @Published var imageData: Data?
    @Published var notifyUser: Bool?
    
    var hasBeenAdded: Bool {
        let event = DataController.shared.events.first { event in
            return event.id == self.id
        }
        
        if event != nil {
            return true
        }else {
            return false
        }
        
    }

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case address
        case url
        case color
        case imageData
    }
    
    init() {

    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.date = try values.decodeIfPresent(Date.self, forKey: .date) ?? Date()
        self.title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.address = try values.decodeIfPresent(String.self, forKey: .address) ?? ""
        self.url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        let hexColor: String = try values.decodeIfPresent(String.self, forKey: .color) ?? "#0000"
        self.color = Color(UIColor(hexColor))
        self.imageData = try? values.decodeIfPresent(Data.self, forKey: .imageData)
    }
    
    init(json: [String: Any]) {
        if let id = json["id"] as? String {
            self.id = id
        }
        
        if let title = json["title"] as? String {
            self.title = title
        }
        
        if let address = json["address"] as? String {
            self.address = address
        }
        
        if let url = json["url"] as? String {
            self.url = url
        }
        
        if let dateString = json["date"] as? String {
            SwiftDate.defaultRegion = Region.local
            if let dateInRegion = dateString.toDate() {
                self.date = dateInRegion.date
            }
        }
        
        if let colorHex = json["color"] as? String {
            self.color = Color(UIColor("#"+colorHex))
        }
        
        if let imageUrl = json["imageURL"] as? String {
            if let url = URL(string: imageUrl) {
                if let data = try? Data(contentsOf: url) {
                    self.imageData = data
                }
            }
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: CodingKeys.id)
        try container.encode(self.date, forKey: CodingKeys.date)
        try container.encode(self.title, forKey: CodingKeys.title)
        try container.encode(self.address, forKey: CodingKeys.address)
        try container.encode(self.url, forKey: CodingKeys.url)
        let color = UIColor(self.color)
        let uiColorString = color.hexString(true)
        try container.encode(uiColorString, forKey: CodingKeys.color)
        try container.encode(self.imageData, forKey: CodingKeys.imageData)
    }

    func image() -> Image? {

        if let imageData = self.imageData, let uiImage = UIImage(data: imageData)?.resized(toWidth: 800) {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.locale =  Locale(identifier: "pt-BR")

//      if self.date.compare(.isThisYear) { //Com SwiftDate Coisa linda de meu deus 
        if self.date.year == Date().year {
            formatter.dateFormat = "d MMM"
        } else {
            formatter.dateFormat = "dd/MM/yyyy"
        }

        return formatter.string(from: self.date)
    }

    func timeFromNow() -> String {
        return self.date.toRelative(since: nil, style: nil, locale: Locale(identifier: "pt-BR")).capitalizedSentence
    }
    
    func validUrl() -> URL? {
        return URL(string: self.url)
    }
}

extension EventEntity {
    static var testEvent1: EventEntity {
        let event = EventEntity()

        event.title = "WWDC 2020"
        event.date = Date() + 1.years
        event.color = .green
        event.url = "www.apple.com"

        if let image = UIImage(named: "wwdc"), let data = image.pngData() {
            event.imageData = data
        }

        return event
    }

    static var testEvent2: EventEntity {
        let event = EventEntity()

        event.title = "Viagem em familia para ilha bela, com parada para ver a migração de baleias"
        event.date = Date() + 2.hours
        event.color = .blue

        return event
    }

    static var testEvent3: EventEntity {
        let event = EventEntity()

        event.title = "Conhecendo o Rio de Janeiro com meus pais"
        event.date = Date() + 4.years
        event.color = .purple

        return event
    }
}
