//
//  ContactUsView.swift
//  TripzyApp
//
//  Created by Subham Patel on 29/12/24.
//

import SwiftUI

struct ContactUsView: View {
    @State var name: String = ""
    @State var email: String = ""
    let countries = [
        Country(name: "United States", code: "+1", flag: "🇺🇸"),
        Country(name: "India", code: "+91", flag: "🇮🇳"),
        Country(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
        Country(name: "Canada", code: "+1", flag: "🇨🇦"),
        Country(name: "Australia", code: "+61", flag: "🇦🇺")
    ]
    @State private var selectedCountry: Country = Country(name: "India", code: "+91", flag: "🇮🇳")
    @State private var phoneNumber: String = ""
    @State private var textMessage: String = ""
    
    var body: some View {
        VStack{
            HStack {
                Text("Contact Us")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.top, 20)
            ScrollView{
                Text("Contact us for ride share")
                    .font(.headline)
                    .padding()
                
                Text("Address")
                    .font(.headline)
                
                Text("House #72, Road #12, City #123456")
                    .font(.subheadline)
                
                Text("Call: 13302 (24/7)")
                    .font(.subheadline)
                
                Text("Email: support@tripzy.com")
                    .font(.subheadline)
                    .padding()
                
                Text("Send Message")
                    .font(.headline)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: 360, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.bottom, 1)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: 360, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.bottom, 5)
                
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        // Country Picker
                        Menu {
                            ForEach(countries) { country in
                                Button {
                                    selectedCountry = country
                                } label: {
                                    HStack {
                                        Text(country.flag)
                                        Text("\(country.name) (\(country.code))")
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedCountry.flag)
                                Text(selectedCountry.code)
                                    .font(.subheadline)
                                Image(systemName: "chevron.down") // Dropdown indicator
                                    .font(.caption)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                        .frame(height: 40) // Set a compact height for the picker
                        
                        // Phone Number TextField
                        TextField("Your Mob Number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .padding(.horizontal, 8)
                            .frame(height: 40) // Explicitly set the height to 30
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .frame(height: 30) // Consistent height for the entire HStack
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(maxWidth: 360)
                .frame(maxHeight: 30)
                .padding(.top, 28)
                
                TextField("Write your text", text: $textMessage)
                    .frame(height: 100)
                    .padding()
                    .background(Color.white)
                    .frame(width: 360, height: 120)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.top, 35)
                
                Button(action: {
                    // Save password action
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .frame(width: 350, height: 55)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .padding(.top, 30)
                Spacer()
            }
        }
    }
}

#Preview {
    ContactUsView()
}
