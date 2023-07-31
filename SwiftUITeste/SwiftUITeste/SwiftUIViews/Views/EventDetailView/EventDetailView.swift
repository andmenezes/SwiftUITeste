//
//  EventDetailView.swift
//  SwiftUITeste
//
//  Created by André Menezes on 27/07/23.
//

import SwiftUI

struct EventDetailView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var event: EventEntity
    
    var isDiscover = false
    
    var body: some View {
        
        
        if horizontalSizeClass == .compact {
            EventDetailCompactView(isDiscover: self.isDiscover, event: self.event)
        } else {
            EventDetailRegularView(isDiscover: self.isDiscover, event: self.event)
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventDetailView(event: EventEntity.testEvent1)
                .previewLayout(.sizeThatFits)
            EventDetailView(event: EventEntity.testEvent2)
                .previewLayout(.sizeThatFits)
        }
    }
}
