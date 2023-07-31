//
//  StringExtension.swift
//  SwiftUITeste
//
//  Created by André Menezes on 31/07/23.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
