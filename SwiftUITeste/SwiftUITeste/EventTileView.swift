//
//  EventTileView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 12/07/2021.
//

import SwiftUI

struct EventTileView: View {
    
    var event: EventEntity
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            if let imageData = event.imageData, let uiImage = UIImage(data: imageData) , let image = Image(uiImage: uiImage) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Rectangle()
                .foregroundColor(event.color)
                .frame(height: 15)
            
            
            HStack {
                Text(event.title)
                    .font(.title)
                    .padding(10)
                Spacer()
            }
            .background(Color.white)
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.red)
                
                Text("4 Setembro")
                    
                Spacer()
                
                Text("Próximo Mês")
                    
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
                
            }
            .font(.title3)
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .background(Color.white)
            
            
        }
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

struct EventTileView_Previews: PreviewProvider {
    static var previews: some View {
        EventTileView(event: EventEntity.testEvent1)
            .previewLayout(.sizeThatFits)
    }
    
}
