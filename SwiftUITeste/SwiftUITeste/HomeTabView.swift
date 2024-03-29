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
            NavigationView {
                UpcomingView()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Próximos")
            }
            NavigationView {
                DiscoverEventsView()
            }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Descubra")
                }
            NavigationView {
                PastEventsView()
            }
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
