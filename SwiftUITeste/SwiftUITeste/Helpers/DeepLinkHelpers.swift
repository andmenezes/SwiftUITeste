//
//  DeepLinkHelpers.swift
//  Meus Eventos
//
//  Created by André Menezes on 01/08/23.
//

import UIKit

class DeepLinkHelpers {
    func canOpenWithGps(address: String) {
        
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            
            let urlStr = "https://waze.com/ul?q=\(address)".replacingOccurrences(of: " ", with: "%20")
            print("Waze url: = \(urlStr)")
            UIApplication.shared.open(URL(string: urlStr)!)
        } else {
            UIApplication.shared.open(URL(string: "https://apps.apple.com/us/app/323229106")!)
        }
    }
}
