import SwiftUI

struct VegetableListScreen: View {
    let vegetables: [Vegetable]
    @EnvironmentObject var languageManager: LanguageManager
    @State private var search: String = ""
    @State private var selectedVegetable: Vegetable?
    
    @Environment(\.modelContext) private var context
    
    private var filteredVegetables: [Vegetable] {
        if search.isEmptyOrWhiteSpace {
            return vegetables
        } else {
            return vegetables.filter { $0.localizedName.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        List(filteredVegetables) { vegetable in
            NavigationLink {
                VegetableDetailScreen(vegetable: vegetable)
            } label: {
                VegetableCellView(vegetable: vegetable)
                    .swipeActions(edge: .trailing, content: {
                        Button {
                            selectedVegetable = vegetable
                        } label: {
                            Label("Add to Garden", systemImage: "leaf.fill")
                        }
                        .tint(Color(red: 0.1, green: 0.7, blue: 0.3)) // Changed to green
                    })
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .searchable(text: $search, prompt: "Search vegetables...")
        .navigationTitle("Vegetables")
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
                Image("subtle_pattern") // Optional: Add a faint Indian pattern (e.g., paisley) if available
                    .resizable()
                    .scaledToFill()
                    .opacity(0.05)
                    .blur(radius: 2)
                    .ignoresSafeArea()
            )
        )
        .sheet(item: $selectedVegetable) { selectedVegetable in
            SeedOrSeedlingView { plantOption in
                let myGardenVegetable = MyGardenVegetable(vegetable: selectedVegetable, plantOption: plantOption)
                context.insert(myGardenVegetable)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .presentationDetents([.fraction(0.3)])
            .presentationBackground(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.95, blue: 0.9), Color(red: 0.95, green: 0.9, blue: 0.85)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        VegetableListScreen(vegetables: PreviewData.loadVegetables())
    }
}
