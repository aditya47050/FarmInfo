import SwiftUI

struct LanguageSettingsView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    
    private let languages: [(name: String, code: String, flag: String)] = [
        ("English", "en", "🇬🇧"),
        ("Hindi", "hi", "🇮🇳"),
        ("Marathi", "mr", "🚩")
    ]
    
    var body: some View {
        List {
            Section(header: Text("select_language_title".localized)) {
                ForEach(languages, id: \.code) { language in
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            languageManager.currentLanguage = language.code
                        }
                    }) {
                        HStack(spacing: 12) {
                            Text(language.flag)
                                .font(.system(size: 24))
                            
                            Text(language.name.localized)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if languageManager.currentLanguage == language.code {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(Color.clear) // Transparent row background
                }
            }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .navigationTitle("language_settings_title".localized)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.7, blue: 0.4).opacity(0.15),
                    Color(red: 1.0, green: 0.95, blue: 0.9).opacity(0.3)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .overlay(
                Image("subtle_pattern")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.05)
                    .blur(radius: 2)
                    .ignoresSafeArea()
            )
        )
    }
}

#Preview {
    NavigationStack {
        LanguageSettingsView()
            .environmentObject(LanguageManager.shared)
    }
}
