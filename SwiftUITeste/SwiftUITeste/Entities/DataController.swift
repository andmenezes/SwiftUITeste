//
//  DataController.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 12/07/2021.
//

import Foundation

class DataController: ObservableObject {
    static var shared = DataController()

    @Published var events: [EventEntity] = []
    var upcomingEvents: [EventEntity] {
        return events.filter { $0.date.compare(.isInTheFuture) }.sorted {$0.date < $1.date}
    }

    var pastEvents: [EventEntity] {
        return events.filter { $0.date.compare(.isInThePast)}
    }

    internal let userDefaultKey = "events"

    func saveData() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.events) {
                UserDefaults.standard.setValue(encoded, forKey: self.userDefaultKey)
                UserDefaults.standard.synchronize()
            }
        }
    }

    func loadData() {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.data(forKey: self.userDefaultKey) {
                let decoder = JSONDecoder()
                if let jsonEvents = try? decoder.decode([EventEntity].self, from: data) {
                    DispatchQueue.main.async {
                        self.events = jsonEvents
                    }
                }
            }
        }

    }
}
