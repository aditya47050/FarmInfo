import SwiftUI

struct VegetableTabBarScreen: View {
    @State private var vegetables: [Vegetable] = []
    @EnvironmentObject var languageManager: LanguageManager
    
    private var pests: [Pest] {
        let allPests = vegetables.flatMap { $0.pests ?? [] }
        return Array(Set(allPests.map { $0.localizedName.lowercased() }))
            .compactMap { name in
                allPests.first { $0.localizedName.lowercased() == name }
            }
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                VegetableListScreen(vegetables: vegetables)
            }
            .tabItem {
                Image(systemName: "leaf.fill")
                Text("Vegetables")
            }
            
            NavigationStack {
                MyGardenScreen()
            }
            .tabItem {
                Image(systemName: "tree.fill")
                Text("My Garden")
            }
            
            NavigationStack {
                PestListScreen(pests: pests)
            }
            .tabItem {
                Image(systemName: "ladybug.fill")
                Text("Pests")
            }
            
            NavigationStack {
                LanguageSettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
        .accentColor(Color(red: 0.1, green: 0.7, blue: 0.3)) // Changed to green
        .environmentObject(languageManager)
        .task {
            do {
                let client = VegetableHTTPClient()
                vegetables = try await client.fetchVegetables()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview(traits: .sampleData) {
    VegetableTabBarScreen()
        .environmentObject(LanguageManager.shared)
}
