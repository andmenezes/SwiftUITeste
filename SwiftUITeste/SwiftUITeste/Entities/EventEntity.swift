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
    var id: String = UUID().uuidString
    var date: Date = Date()
    var title: String = ""
    var url: String = ""
    var color: Color = Color.purple
    @Published var imageData: Data?

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case title
        case url
        case color
        case imageData
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: CodingKeys.id)
        try container.encode(self.date, forKey: CodingKeys.date)
        try container.encode(self.title, forKey: CodingKeys.title)
        try container.encode(self.url, forKey: CodingKeys.url)
        let uiColorString = UIColor(self.color).hexString(true)
        try container.encode(uiColorString, forKey: CodingKeys.color)
        try container.encode(self.imageData, forKey: CodingKeys.imageData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try values.decode(String.self, forKey: .id)
        self.date = try values.decode(Date.self, forKey: .date)
        self.title = try values.decode(String.self, forKey: .title)
        self.url = try values.decode(String.self, forKey: .url)
        let hexColor: String = try values.decode(String.self, forKey: .color)
        self.color = Color(UIColor(hexColor))
        self.imageData = try? values.decode(Data.self, forKey: .imageData)
    }

    init() {

    }

    func image() -> Image? {

        if let imageData = self.imageData, let uiImage = UIImage(data: imageData) {
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
        return self.date.toRelative(since: nil, style: nil, locale: Locale(identifier: "pt-BR"))
    }
}

extension EventEntity {
    static var testEvent1: EventEntity {
        let event = EventEntity()

        event.title = "WWDC 2020"
        event.date = Date() + 2.months
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
        event.date = Date() + 4.hours
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
