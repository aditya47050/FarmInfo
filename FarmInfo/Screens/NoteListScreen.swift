import SwiftUI
import SwiftData

struct NoteListScreen: View {
    
    let myGardenVegetable: MyGardenVegetable
    @State private var addNotePresented: Bool = false
    
    @Environment(\.modelContext) private var context
    
    private func deleteNote(at indexSet: IndexSet) {
        guard let notes = myGardenVegetable.notes else { return }
        
        for index in indexSet {
            let note = notes[index]
            context.delete(note)
            
            if let noteToRemoveIndex = notes.firstIndex(where: { $0.persistentModelID == note.persistentModelID }) {
                myGardenVegetable.notes?.remove(at: noteToRemoveIndex)
            }
            
            try? context.save()
        }
    }
    
    var body: some View {
        List {
            ForEach(Array((myGardenVegetable.notes ?? []).enumerated()), id: \.element) { index, note in
                NoteCellView(
                    note: note,
                    index: index,
                    placeHolderImage: myGardenVegetable.vegetable.thumbnailImage
                )
            }
            .onDelete(perform: deleteNote)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
        .navigationTitle("vegetable_\(myGardenVegetable.vegetable.vegetableId)_name".localized)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add_Note".localized) {
                    addNotePresented = true
                }
            }
        }
        .sheet(isPresented: $addNotePresented) {
            NavigationStack {
                AddNoteScreen(myGardenVegetable: myGardenVegetable)
            }
        }
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
    @Previewable @Query var myGardenVegetables: [MyGardenVegetable]
    
    NavigationStack {
        NoteListScreen(myGardenVegetable: myGardenVegetables[0])
    }
}
