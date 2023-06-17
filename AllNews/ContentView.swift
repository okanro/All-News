//
//  ContentView.swift
//  AllNews
//
//  Created by Okan Özdemir on 15.06.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showNetworkAlert = false
    
    var body: some View {
        SourcesView()
            .onChange(of: networkMonitor.isConnected) { connection in
                showNetworkAlert = connection == false
            }
            .alert(
                "Network connection seems to be offline.",
                isPresented: $showNetworkAlert
            ) {}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
