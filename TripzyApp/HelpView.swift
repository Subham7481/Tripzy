//
//  HelpUsView.swift
//  TripzyApp
//
//  Created by Subham Patel on 27/12/24.
//
import SwiftUI
struct HelpView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Help and Support")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .padding()
            List {
                NavigationLink(destination: FAQView()) {
                    Text("Frequently Asked Questions")
                        .font(.body)
                }
                
                NavigationLink(destination: ContactSupportView()) {
                    Text("Contact Support")
                        .font(.body)
                }

                NavigationLink(destination: WebsiteView()) {
                    Text("Visit Our Website")
                        .font(.body)
                }
            }
            .padding(.top, 10)
        }
    }
}

struct FAQView: View {
    var body: some View {
        VStack {
            Text("Frequently Asked Questions")
                .font(.title)
                .padding()
            Text("1. How do I use the app?\n- You can start by registering and logging in.")
                .padding()
        }
    }
}

struct ContactSupportView: View {
    var body: some View {
        VStack {
            Text("Contact Support")
                .font(.title)
                .padding()
            Text("You can reach us at support@tripzyapp.com.")
                .padding()
        }
    }
}

struct WebsiteView: View {
    var body: some View {
        VStack {
            Text("Visit Our Website")
                .font(.title)
                .padding()
            Text("Visit us at www.tripzyapp.com")
                .padding()
        }
    }
}

#Preview {
    HelpView()
}
