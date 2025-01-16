import SwiftUI

struct ChangeLanguageView: View {
    @State private var selectedLanguage: String? = nil
    let languages = [
        ("English", "🇺🇸"),
        ("Hindi", "🇮🇳"),
        ("Spanish", "🇪🇸"),
        ("French", "🇫🇷"),
        ("German", "🇩🇪"),
        ("Japanese", "🇯🇵")
    ]
    
    var body: some View {
        HStack {
            Text("Change Language")
                .font(.headline)
                .padding(.horizontal, 10)
            Spacer()
        }
        .padding()
        ScrollView {
            VStack(spacing: 20) {
                ForEach(languages, id: \.0) { language, flag in
                    Button(action: {
                        selectedLanguage = (selectedLanguage == language) ? nil : language
                    }) {
                        HStack {
                            HStack {
                                Text(flag)
                                    .font(.largeTitle)
                                Text(language)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            ZStack {
                                Circle()
                                    .strokeBorder(selectedLanguage == language ? Color.green : Color.gray, lineWidth: 1)
                                    .background(
                                        Circle()
                                            .foregroundColor(selectedLanguage == language ? Color.green.opacity(0.3) : Color.clear)
                                    )
                                    .frame(width: 30, height: 30)
                                if selectedLanguage == language {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 27))
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 27))
                                }
                            }
                        }
                        .padding()
                        .frame(width: 370, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 1)
                        )
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
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

        }
    }
}

#Preview {
    ChangeLanguageView()
}
