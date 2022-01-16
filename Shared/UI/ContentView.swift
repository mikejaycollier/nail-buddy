//
//  ContentView.swift
//  Shared
//
//  Created by Mike the Great on 6/11/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        TabView {
            ClientsMainView()
                .tabItem {
                    Label("Clients", systemImage: "person")
                }
            
            AppointmentsMainView()
                .tabItem {
                    Label("Appointments", systemImage: "calendar")
                }
            
            SettingsMainView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
