import SwiftUI

struct PestListScreen: View {
    let pests: [Pest]
    @State private var search: String = ""
    
    private var filteredPests: [Pest] {
        if search.isEmptyOrWhiteSpace {
            return pests
        } else {
            return pests.filter { $0.localizedName.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        List(filteredPests) { pest in
            NavigationLink {
                PestDetailScreen(pest: pest)
            } label: {
                PestCellView(pest: pest)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)) // Increased padding for better spacing
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1.0, green: 0.95, blue: 0.9).opacity(0.6),
                        Color(red: 1.0, green: 0.98, blue: 0.95).opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(red: 0.1, green: 0.6, blue: 0.3), Color(red: 1.0, green: 0.5, blue: 0.0)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                        .blur(radius: 1)
                )
            )
        }
        .listStyle(.plain)
        .searchable(text: $search, prompt: "Search pests...")
        .navigationTitle(NSLocalizedString("pests_title".localized, comment: "Pests list title"))
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
                Image("subtle_pattern") // Optional: Add a faint Indian pattern if available
                    .resizable()
                    .scaledToFill()
                    .opacity(0.05)
                    .blur(radius: 2)
                    .ignoresSafeArea()
            )
        )
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        PestListScreen(pests: PreviewData.loadPests())
    }
}
