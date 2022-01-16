//
//  ClientDetailView.swift
//  NailBuddy (iOS)
//
//  Created by Mike Collier on 1/15/22.
//

import SwiftUI

struct ClientDetailView: View {
    let client: Client
    
    var body: some View {
        VStack {
            Text(client.fullName)
            Text(client.created?.formatted(date: .complete, time: .omitted) ?? "")
            
            if let appointments = client.appointments?.allObjects as? [Appointment] {
                List(appointments) { appointment in
                    NavigationLink {
                        AppointmentDetailView(appointment: appointment)
                    } label: {
                        VStack {
                            Text(appointment.date?.formatted(date: .complete, time: .complete) ?? "")
                            Text(appointment.note ?? "")
                        }
                    }
                }
            }
        }
        .navigationTitle(client.fullName)
    }
}

struct ClientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetailView(client: getClient())
    }
    
    static func getClient() -> Client {
        let viewContext = PersistenceController(inMemory: true).container.viewContext

        let testClient = Client(context: viewContext)
        testClient.firstName = "Tester"
        testClient.lastName = "Testeroo"
        testClient.created = Date()
        
        return testClient
    }
}
