//
//  AppointmentDetailView.swift
//  NailBuddy
//
//  Created by Mike Collier on 1/15/22.
//

import SwiftUI

struct AppointmentDetailView: View {
    let appointment: Appointment
    
    var body: some View {
        VStack {
            Text("Appointment Date: " + (appointment.date?.formatted(date: .complete, time: .complete) ?? ""))
            Text("Appointment Note: " + (appointment.note ?? ""))
            
            if let client = appointment.client {
                NavigationLink {
                    ClientDetailView(client: client)
                } label: {
                    VStack {
                        Text("Cusotmer Name " + client.fullName)
                        Text("Cusotmer Note: " + (client.note ?? ""))                        
                    }
                }
            }
        }
    }
}

struct AppointmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentDetailView(appointment: getAppointment())
    }
    
    static func getAppointment() -> Appointment {
        let viewContext = PersistenceController(inMemory: true).container.viewContext

        let testClient = Client(context: viewContext)
        testClient.firstName = "Tester"
        testClient.lastName = "Testeroo"
        testClient.created = Date()
        testClient.id = UUID()
        
        let appointment = Appointment(context: viewContext)
        appointment.client = testClient
        appointment.note = "This is a test note for testing things"
        appointment.date = Date()
        appointment.id = UUID()
        
        return appointment
    }
}
