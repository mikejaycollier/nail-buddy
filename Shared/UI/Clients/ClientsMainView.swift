//
//  ClientsMainView.swift
//  NailBuddy
//
//  Created by Mike Collier on 1/15/22.
//

import SwiftUI

struct ClientsMainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Client.created, ascending: true)],
        animation: .default)
    private var clients: FetchedResults<Client>

    
    var body: some View {
        NavigationView {
            List {
                ForEach(clients) { client in
                    NavigationLink {
                        ClientDetailView(client: client)
                    } label: {
                        let timeString = client.created?.formatted(date: .abbreviated, time: .shortened)
                        Text("\(client.firstName ?? "") \(client.lastName ?? "")" + " - " + (timeString ?? ""))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                #if os(iOS)
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                    Button(action: addItem) {
                        Label("Add Client", systemImage: "plus")
                    }
                }
                #else
                Button(action: addItem) {
                    Label("Add Client", systemImage: "plus")
                }
                #endif
            }
            .navigationTitle("Clients")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newClient = Client(context: viewContext)
            newClient.created = Date()
            newClient.firstName = String.randomString(numberOfCharacters: 10)
            newClient.lastName = String.randomString(numberOfCharacters: 10)
            newClient.appointments = []
            newClient.id = UUID()
            newClient.note = ""

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { clients[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ClientsMainView_Previews: PreviewProvider {
    static var previews: some View {
        ClientsMainView()
    }
}
