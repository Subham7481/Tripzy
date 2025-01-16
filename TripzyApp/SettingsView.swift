//
//  SettingsView.swift
//  TripzyApp
//
//  Created by Subham Patel on 27/12/24.
//

import SwiftUI

struct SettingsView: View {
    let settingItems = [
        ("Change Password", AnyView(ChangePasswordView())),
        ("Change Language", AnyView(ChangeLanguageView())),
        ("Privacy Policy", AnyView(PrivacyPolicyView())),
        ("Contact Us", AnyView(ContactUsView())),
        ("Delete Account", AnyView(DeleteAccountView())),
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text("Settings")
                    .font(.headline)
                    .padding(.horizontal, 30)
                Spacer()
            }
//            NavigationView {
                List(settingItems, id: \.0) { item in
                    NavigationLink(destination: item.1) {
                        Text(item.0)
                            .font(.subheadline)
                            .padding(.vertical, 10)
                    }
                    .padding()
                    .frame(width: 360, height: 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.green, lineWidth: 1)
                    )
                }
//            }
        }
    }
}


#Preview {
    SettingsView()
}
