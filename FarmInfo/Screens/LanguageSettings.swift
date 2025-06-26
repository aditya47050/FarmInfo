import Foundation
import Combine

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
            updateBundle()
        }
    }
    
    private var bundle: Bundle = .main
    
    private init() {
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") {
            currentLanguage = savedLanguage
        } else {
            let preferredLanguage = Locale.preferredLanguages.first?.prefix(2).description ?? "en"
            currentLanguage = ["en", "hi", "mr"].contains(preferredLanguage) ? preferredLanguage : "en"
        }
        updateBundle()
    }
    
    private func updateBundle() {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.bundle = bundle
        } else {
            self.bundle = .main
        }
        objectWillChange.send()
    }
    
    func localizedString(_ key: String, comment: String = "") -> String {
        bundle.localizedString(forKey: key, value: nil, table: nil)
    }
}

extension String {
    var localized: String {
        LanguageManager.shared.localizedString(self)
    }
}
