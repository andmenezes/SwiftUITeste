//
//  EventListWidgetiOS.swift
//  EventListWidgetiOS
//
//  Created by André Menezes on 28/07/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> EventListEntry {
        EventListEntry(date: Date(), event: EventEntity.testEvent1)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (EventListEntry) -> ()) {
        
        let upcoming = DataController.shared.getUpcomingEventsForWidget()
        
        var entry = EventListEntry(date: Date(), event: EventEntity.testEvent1)
        
        if upcoming.count > 0 {
            entry = EventListEntry(date: Date(), event: upcoming.randomElement())
        }
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [EventListEntry] = []
        let upcoming = DataController.shared.getUpcomingEventsForWidget()
        
        let currentDate = Date()
        for hourOffset in 0 ..< upcoming.count {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = EventListEntry(date: entryDate, event: upcoming[hourOffset])
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EventListEntry: TimelineEntry {
    let date: Date
    let event: EventEntity?
}

struct EventListWidgetiOSEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        
        GeometryReader { geometry in
            
            if let event = self.entry.event {
                
                ZStack {
                    if let image = event.image() {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    } else {
                        event.color
                    }
                    
                    Color.black
                        .opacity(0.30)
                    
                    Text(event.title)
                        .foregroundColor(.white)
                        .font(self.fontSize())
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    VStack{
                        Spacer()
                        HStack {
                            Spacer()
                            Text(event.timeFromNow())
                                .padding(.horizontal, 10)
                                .padding(.bottom, 15)
                                .foregroundColor(.white)
                                .font(self.fontSize())
                                .overlay(Color.black.opacity(0.05))
                        }
                    }
                }
                
            } else {
                
                VStack {
                    Spacer()
                    Text("Sem eventos para mostrar, toque em mim para adicionar algo maneiro 🤪")
                        .padding()
                    Spacer()
                }
            }
        }
    }
    
    func fontSize() -> Font {
        switch widgetFamily {
        case .systemSmall:
            return .body
                .bold()
        case .systemMedium:
            return .title
                .bold()
        case .systemLarge:
            return .largeTitle
                .bold()
        default:
            return .title
        }
    }
    
}

struct EventListWidgetiOS: Widget {
    let kind: String = "EventListWidgetiOS"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EventListWidgetiOSEntryView(entry: entry)
        }
        .configurationDisplayName("Meus Eventos Widget")
        .description("Acompanhe seus eventos que estão para chegar!!!")
    }
}

struct EventListWidgetiOS_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            EventListWidgetiOSEntryView(entry: EventListEntry(date: Date(), event: EventEntity.testEvent1))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            EventListWidgetiOSEntryView(entry: EventListEntry(date: Date(), event: EventEntity.testEvent2))
            
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            
            EventListWidgetiOSEntryView(entry: EventListEntry(date: Date(), event: nil))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
        }
        
    }
}
