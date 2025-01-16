//
//  DeleteAccountView.swift
//  TripzyApp
//
//  Created by Subham Patel on 29/12/24.
//

import SwiftUI

struct DeleteAccountView: View {
    var body: some View {
        VStack{
            HStack {
                Text("Change Language")
                    .font(.headline)
                    .padding(.horizontal, 10)
                Spacer()
            }
            .padding()
            Text("Are you sure you want to delete your account? This action is permanent and cannot be undone. All your data, including personal information and preferences, will be erased.If you proceed, you will be logged out and your account will be deleted from our system. Please confirm if you wish to continue.")
                .font(.headline)
                .foregroundColor(Color.gray)
                .padding()
            Button(action: {
                // Save password action
            }, label: {
                Text("Delete")
                    .font(.headline)
                    .frame(width: 350, height: 55)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .padding()
            Spacer()
        }
    }
}

#Preview {
    DeleteAccountView()
}
