import SwiftUI

struct EnterLocation: View {
    @StateObject var viewModel = EnterLocationViewViewModel()
    @State private var isNavigating = false
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case from, to
    }

    var body: some View {
        HStack {
            Text("Select Address")
                .font(.headline)
                .padding(.horizontal, 10)
            Spacer()
        }.padding()
        VStack {
                VStack {
                    HStack {
                        Image(systemName: "dot.scope")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)

                        TextField("From", text: $viewModel.startLocation)
                            .focused($focusedField, equals: .from)
                            .onChange(of: viewModel.startLocation) { newValue in
                                viewModel.fetchSuggestions(for: newValue)
                            }
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(width: 220, height: 30, alignment: .center)
                            .autocorrectionDisabled()
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(focusedField == .from ? Color.green : Color.black, lineWidth: 1)
                            )
                            .padding(.leading, 30)
                    }

                    // Suggestions List for "From" TextField
                    if focusedField == .from && !viewModel.locationSuggestions.isEmpty {
                        List(viewModel.locationSuggestions, id: \.self) { suggestion in
                            Text(suggestion)
                                .onTapGesture {
                                    viewModel.startLocation = suggestion
                                    viewModel.locationSuggestions = []
                                }
                        }
                        .frame(maxHeight: 150)
                        .padding(.top, 5)
                        .padding(.leading, 30)
                    }
                }

                // To TextField with suggestions
                VStack {
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)

                        TextField("To", text: $viewModel.endLocation)
                            .focused($focusedField, equals: .to)
                            .onChange(of: viewModel.endLocation) { newValue in
                                viewModel.fetchSuggestions(for: newValue)
                            }
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(width: 220, height: 30, alignment: .center)
                            .autocorrectionDisabled()
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(focusedField == .to ? Color.green : Color.black, lineWidth: 1)
                            )
                            .padding(.leading, 30)
                    }.padding()

                    // Suggestions List for "To" TextField
                    if focusedField == .to && !viewModel.locationSuggestions.isEmpty {
                        List(viewModel.locationSuggestions, id: \.self) { suggestion in
                            Text(suggestion)
                                .onTapGesture {
                                    viewModel.endLocation = suggestion
                                    viewModel.locationSuggestions = []
                                }
                        }
                        .frame(maxHeight: 150)
                        .padding(.top, 5)
                        .padding(.leading, 30)
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                // Confirm Button
                Button(action: {
                    viewModel.calculateAmount()
                    isNavigating = true
                }, label: {
                    Text("Confirm Location")
                })
                .frame(width: 250, height: 50)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(15)
                .padding()

                NavigationLink("", destination: SelectTransport(), isActive: $isNavigating)
                    .hidden()

                if let amount = viewModel.fareAmount {
                    Text("Estimated Amount: ₹\(amount, specifier: "%.2f")")
                        .font(.headline)
                        .padding()
                }

                Spacer()
            }
        .padding(.top, 20)
        }
}

#Preview {
    EnterLocation()
}
