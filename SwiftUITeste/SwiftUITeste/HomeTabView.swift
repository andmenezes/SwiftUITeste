//
//  ContentView.swift
//  SwiftUITeste
//
//  Created by Andre Pessoal on 06/07/2021.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            NavigationView{
                UpcomingView()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Próximos")
            }
            Text("Hello 2")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Descubra")
                }
            Text("Hello 3")
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Passado")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
