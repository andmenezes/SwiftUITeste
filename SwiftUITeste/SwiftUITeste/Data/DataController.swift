//
//  DataController.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 12/07/2021.
//

import Foundation
import SwiftDate
import UIColor_Hex_Swift
import SwiftUI

class DataController: ObservableObject {
    static var shared = DataController()

    @Published var events: [EventEntity] = []
    @Published var discoveryEvents: [EventEntity] = []
    
    var upcomingEvents: [EventEntity] {
        var upcomingEvents = events.filter { $0.date.compare(.isToday) }.sorted {$0.date < $1.date}
        upcomingEvents.append(contentsOf: events.filter { $0.date.compare(.isInTheFuture) }.sorted {$0.date < $1.date})
        
        return upcomingEvents
    }

    var pastEvents: [EventEntity] {
        return events.filter { $0.date.compare(.isEarlier(than: Calendar.current.date(byAdding: .day,
                                                                                      value: -1,
                                                                                      to: Date())!))}
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
    
    func addFromDiscover(event: EventEntity) {
        events.append(event)
        event.objectWillChange.send()
        self.saveData()
    }
    
    func deleteEvent(event: EventEntity) {
        if let index = events.firstIndex(where: { loopingEvent -> Bool in
            loopingEvent.id == event.id
        }) {
            events.remove(at: index)
        }
        self.saveData()
    }
    
    func saveEvent(event: EventEntity) {
        
        if let index = events.firstIndex(where: { loopingEvent -> Bool in
            loopingEvent.id == event.id
        }) {
            events[index] = event
        }else {
            events.append(event)
        }
        
        self.saveData()
    }
    
    func getDiscoveryEventsAPiData() {
        if let url = URL(string: "https://api.jsonbin.io/v3/b/64c29bef8e4aa6225ec5fcb0/latest") {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let webData = data {
                    if let json = try? JSONSerialization.jsonObject(with: webData) as? [String: Any] {
                        if let record = json["record"] as? [[String: Any]] {
                            
                            var discoveryEventsToAdd: [EventEntity] = []
                            
                            for eventJSON in record {
                                
                                let newDiscoveryEvents = EventEntity(json: eventJSON)
                                discoveryEventsToAdd.append(newDiscoveryEvents)
                            }
                            
                            DispatchQueue.main.async {
                                self.discoveryEvents = discoveryEventsToAdd
                            }
                        }
                    }
                }
            }.resume()
        }
            
            
    }
    
}
