//
//  EventEntity.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import Foundation
import SwiftUI

class EventEntity: ObservableObject {
    var date: Date = Date()
    var title: String = ""
    var url: String = ""
    var color: Color = Color.purple
    var imageData: Data?
}
