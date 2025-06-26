import SwiftUI
import SwiftData

struct MyGardenScreen: View {
    @Query private var myGardenVegetables: [MyGardenVegetable]
    @Environment(\.modelContext) private var context
    
    private func deleteMyGardenVegetable(at offsets: IndexSet) {
        offsets.forEach { index in
            let myGardenVegetable = myGardenVegetables[index]
            context.delete(myGardenVegetable)
            try? context.save()
        }
    }
    
    var body: some View {
        List {
            ForEach(myGardenVegetables) { myGardenVegetable in
                NavigationLink {
                    NoteListScreen(myGardenVegetable: myGardenVegetable)
                } label: {
                    MyGardenCellView(myGardenVegetable: myGardenVegetable)
                }
            }
            .onDelete(perform: deleteMyGardenVegetable)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
        .searchable(text: .constant(""), prompt: "Search my garden...")
        .navigationTitle("my_garden_tab_title".localized)
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

#Preview(traits: .sampleData) {
    NavigationStack {
        MyGardenScreen()
    }
}
