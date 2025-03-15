//
//  ComplainView.swift
//  TripzyApp
//
//  Created by Subham Patel on 27/12/24.
//
import SwiftUI

struct ComplainView: View {
    @StateObject private var viewModel = ComplainViewViewModel() // Attach ViewModel
    @State private var selectedComplaint: String = "Select a Complaint"
    @State private var complaints = [
        "Vehicle not clean",
        "Driver was not decent",
        "Late arrival",
        "Overcharged",
        "Other"
    ]
    @State private var complaintBox: String = ""
    
    var body: some View {
            VStack {
                // Title
                HStack {
                    Text("Complain")
                        .font(.headline)
                        .padding(.horizontal, 25)
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.bottom, 20)
                
                Spacer()
                
                // Complaint Type Dropdown
                Menu {
                    ForEach(complaints, id: \.self) { complaint in
                        Button(complaint) {
                            selectedComplaint = complaint
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedComplaint)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                            .frame(height: 25, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .frame(width: 360)
                }
                
                // Complaint Text Field
                TextField("Write your complaint here (min 10 chars)", text: $complaintBox)
                    .padding()
                    .background(Color.white)
                    .frame(width: 360, height: 140)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                // Submit Button
                Button(action: {
                    viewModel.submitComplaint(selectedComplaint: selectedComplaint, complaintText: complaintBox)
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(width: 330, height: 60)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(15)
                    } else {
                        Text("Submit")
                            .frame(width: 330, height: 60)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                            .padding(.top, 30)
                    }
                }
                .disabled(viewModel.isLoading)
                .padding(.bottom, 370)
                
                Spacer()
            }
            .alert("Error", isPresented: $viewModel.showError, actions: {
                Button("OK", action: { viewModel.showError = false })
            }, message: {
                Text(viewModel.errorMessage)
            })
            .navigationDestination(isPresented: $viewModel.isSubmitted) {
                ConfirmationView()
            }
        }
}

struct ConfirmationView: View {
    var body: some View {
        VStack {
            Text("Thank you for your complaint!")
                .font(.headline)
                .padding()
            
            Text("We value your feedback and will address the issue promptly.")
                .multilineTextAlignment(.center)
                .padding()
            
            NavigationLink(destination: HomeView()) {
                Text("Back Home")
                    .frame(width: 330, height: 60)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .padding(.top, 30)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ComplainView()
}
