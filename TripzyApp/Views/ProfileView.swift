import PhotosUI
import SwiftUI
import UIKit

struct Country: Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let flag: String
}
struct ImagePicker: View {
    @Binding var image: UIImage?
    @Binding var imageData: Data?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ImagePickerController(image: $image, imageData: $imageData)
        }
    }
}
struct ImagePickerController: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var imageData: Data?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, imageData: $imageData)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        @Binding var imageData: Data?
        
        init(image: Binding<UIImage?>, imageData: Binding<Data?>) {
            _image = image
            _imageData = imageData
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.image = selectedImage
                self.imageData = selectedImage.jpegData(compressionQuality: 0.8)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct ProfileView: View {
    let countries = [
        Country(name: "United States", code: "+1", flag: "🇺🇸"),
        Country(name: "India", code: "+91", flag: "🇮🇳"),
        Country(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
        Country(name: "Canada", code: "+1", flag: "🇨🇦"),
        Country(name: "Australia", code: "+61", flag: "🇦🇺")
    ]
    let genders = ["Male", "Female", "Other"]
    
    @ObservedObject var viewModel = ProfileViewViewModel()
    @State private var image: Image? = Image(systemName: "person.circle")
    @State private var showingImagePicker = false
    @State private var showRemoveButton = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Profile")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
            }
            ScrollView{
                VStack {
                    ZStack {
                        // Profile Image Circle
                        (viewModel.profileImage != nil ?
                         Image(uiImage: viewModel.profileImage!) :
                            Image(systemName: "person.circle"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        
                        .padding()
                        .onTapGesture {
                            showRemoveButton.toggle()
                        }
                        
                        // Camera Button
                        Button(action: {
                            showingImagePicker.toggle()
                        }) {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(8)
                                .background(Color.green)
                                .clipShape(Circle())
                                .foregroundColor(.black)
                        }
                        .position(x: 240, y: 95)
                        
                        // Remove Button
                        if showRemoveButton {
                            Button(action: {
                                viewModel.resetProfileImage()
                                showRemoveButton = false
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .padding(6)
                            }
                            .position(x: 120, y: 20)
                        }
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $viewModel.profileImage, imageData: $viewModel.profileImageData)
                }
                
                TextField("Name", text: $viewModel.name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                // Mobile Number
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        Menu {
                            ForEach(countries) { country in
                                Button {
                                    viewModel.selectedCountry = country
                                } label: {
                                    HStack {
                                        Text(country.flag)
                                        Text("\(country.name) (\(country.code))")
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(viewModel.selectedCountry.flag)
                                Text(viewModel.selectedCountry.code)
                                    .font(.subheadline)
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(5)
                        }
                        .frame(height: 40)
                        
                        TextField("Your Mob Number", text: $viewModel.phoneNumber)
                            .keyboardType(.numberPad)
                            .padding(.horizontal, 8)
                            .frame(height: 40)
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .frame(height: 30)
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(maxWidth: 360)
                
                // Gender Selection
                VStack {
                    Menu {
                        ForEach(genders, id: \.self) { gender in
                            Button(gender) {
                                viewModel.selectedGender = gender
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.selectedGender)
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
                    .padding(.top, 10)
                }
                
                // Address
                TextField("Address", text: $viewModel.address)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                
                // Save Details Button
                Button(action: {
                    viewModel.saveProfileData()
                }, label: {
                    Text("Save")
                        .frame(width: 330, height: 50)
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(10)
                        .padding()
                })
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 1)
                        .padding()
                )
                .padding(.bottom, 45)
                .padding(.top, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

