import SwiftUI

struct PrivacyPolicyView: View {
    let privacyPolicyText: [String] = [
        
        "At TripzyApp, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and disclose your information when you use our services.",
        "",
        "1. Information We Collect",
        "We collect personal information that you provide directly to us when you register, use our services, or interact with the app. This may include:",
        "- Name, email address, and phone number",
        "- Location data",
        "- Payment information ",
        "",
        "2. How We Use Your Information",
        "We use the information we collect to provide, maintain, and improve our services, including:",
        "- To process and complete transactions",
        "- To send you updates, promotions, and marketing materials (with your consent)",
        "- To personalize your user experience",
        "- To improve customer support and ensure smooth interactions",
        "",
        "3. Sharing of Information",
        "We do not share your personal information with third parties unless:",
        "- You have provided your consent",
        "- It is required by law, such as in response to a subpoena, court order, or other legal processes",
        "- We believe it is necessary to protect our rights, the safety of others, or to investigate fraud",
        "",
        "4. Data Security",
        "We use industry-standard security measures to protect your personal information from unauthorized access or disclosure. However, no method of transmission over the internet is 100% secure, and we cannot guarantee the absolute security of your data.",
        "",
        "5. Your Choices",
        "You can choose to:",
        "- Update or delete your personal information at any time through your account settings",
        "- Opt-out of marketing communications by following the unsubscribe instructions in emails or notifications",
        "",
        "6. Children's Privacy",
        "Our services are not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have inadvertently collected information from a child under 13, we will take steps to delete that information as soon as possible.",
        "",
        "7. Changes to This Privacy Policy",
        "We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date. We encourage you to review this Privacy Policy periodically to stay informed about how we are protecting your information.",
        "",
        "8. Contact Us",
        "If you have any questions or concerns about this Privacy Policy or your personal data, please contact us at tripzysupport@gmail.com"
    ]
    
    var body: some View {
        HStack {
            Text("Privacy Policy")
                .font(.headline)
                .padding(.horizontal, 10)
            Spacer()
        }
        .padding()
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ForEach(privacyPolicyText, id: \.self) { text in
                    Text(text)
                        .font(.body)
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.top, 10)
        }
    }
}

#Preview {
    PrivacyPolicyView()
}
