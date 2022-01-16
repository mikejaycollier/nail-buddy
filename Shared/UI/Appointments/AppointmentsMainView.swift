//
//  AppointmentsMainView.swift
//  NailBuddy
//
//  Created by Mike Collier on 1/15/22.
//

import SwiftUI

enum BaseCoatType: String {
    case standard = "Standard"
    case builder = "Builder"
    case shaper = "Shaper"
}

struct AppointmentsMainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Appointment.date, ascending: true)],
        animation: .default)
    private var appointments: FetchedResults<Appointment>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Client.id, ascending: true)],
        animation: .default)
    private var clients: FetchedResults<Client>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(appointments) { appointment in
                    NavigationLink {
                        AppointmentDetailView(appointment: appointment)
                    } label: {
                        VStack(alignment: .leading) {
                            Text("Appointment Date: " + (appointment.date?.formatted(date: .complete, time: .complete) ?? ""))
                            Text("Client Name: " + (appointment.client?.fullName ?? ""))
                        }
                    }
                }
            }
            .toolbar {
                #if os(iOS)
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                    Button(action: addItem) {
                        Label("Add Appointment", systemImage: "plus")
                    }
                }
                #else
                Button(action: addItem) {
                    Label("Add Appointment", systemImage: "plus")
                }
                #endif
            }
            .navigationTitle("Appointments")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newAppointment = Appointment(context: viewContext)
            newAppointment.id = UUID()
            newAppointment.date = Date()
            newAppointment.note = "This is a note!!!"
            newAppointment.client = clients.first

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
            offsets.map { appointments[$0] }.forEach(viewContext.delete)

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

struct AppointmentsMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsMainView()
    }
}
