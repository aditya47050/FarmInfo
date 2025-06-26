import SwiftUI
import SwiftData
import PhotosUI

struct AddNoteScreen: View {
    
    let myGardenVegetable: MyGardenVegetable
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var uiImage: UIImage?
    @State private var imageData: Data?
    
    @State private var isCameraSelected: Bool = false
    
    private var isFormValid: Bool {
        !noteTitle.isEmptyOrWhiteSpace && !noteBody.isEmptyOrWhiteSpace
    }
    
    private func saveNote() {
        let note = Note(title: noteTitle, body: noteBody)
        note.photo = imageData
        myGardenVegetable.notes?.append(note)
        try? context.save()
        dismiss()
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $noteTitle)
            
            TextEditor(text: $noteBody)
                .frame(minHeight: 200)
            
            HStack(spacing: 20) {
                Button {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        isCameraSelected = true
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.green.opacity(0.2))
                            .frame(width: 60, height: 60)
                        Image(systemName: "camera.fill")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
                
                PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 60, height: 60)
                        Image(systemName: "photo.on.rectangle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
            .buttonStyle(.borderless)
            
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(maxWidth: 300, maxHeight: 300)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    .padding()
            }
        }
        .scrollContentBackground(.hidden)
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
        .navigationTitle("\(myGardenVegetable.vegetable.localizedName) Note")
        .task(id: selectedPhotoItem) {
            if let selectedPhotoItem {
                do {
                    if let data = try await selectedPhotoItem.loadTransferable(type: Data.self) {
                        uiImage = UIImage(data: data)
                        imageData = data
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        .sheet(isPresented: $isCameraSelected) {
            ImagePicker(image: $uiImage, sourceType: .camera)
        }
        .onChange(of: uiImage) {
            imageData = uiImage?.pngData()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveNote()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview(traits: .sampleData) {
    @Previewable @Query var myGardenVegetables: [MyGardenVegetable]
    
    NavigationStack {
        AddNoteScreen(myGardenVegetable: myGardenVegetables[0])
    }
}
