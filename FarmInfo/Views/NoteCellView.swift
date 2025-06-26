import SwiftUI
import SwiftData

struct NoteCellView: View {
    
    let note: Note
    let index: Int
    let placeHolderImage: URL?
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.1, green: 0.7, blue: 0.3).opacity(0.5),
                                Color(red: 1.0, green: 0.6, blue: 0.2).opacity(0.5)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 90, height: 90)
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 6)
                
                if let photoData = note.photo,
                   let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
                } else {
                    AsyncImage(url: placeHolderImage) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
                    } placeholder: {
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.9, green: 0.9, blue: 0.9).opacity(0.4),
                                            Color(red: 0.9, green: 0.9, blue: 0.9).opacity(0.1)
                                        ]),
                                        center: .center,
                                        startRadius: 10,
                                        endRadius: 45
                                    )
                                )
                                .frame(width: 90, height: 90)
                                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 6)
                            
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(note.localizedNotesTitle(index: index))
                    .font(.custom("Georgia-Bold", size: 20))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                Text(note.body)
                    .font(.custom("Georgia", size: 14))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .lineLimit(2)
                
                Text(note.dateCreated, format: .dateTime)
                    .font(.custom("Georgia", size: 12))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
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
                            gradient: Gradient(colors: [
                                Color(red: 0.1, green: 0.7, blue: 0.3),
                                Color(red: 1.0, green: 0.6, blue: 0.2)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
                    .blur(radius: 1)
            )
        )
        .padding(.horizontal, 12)
    }
}

#Preview(traits: .sampleData) {
    @Previewable @Query var notes: [Note]
    NoteCellView(
        note: notes[0],
        index: 0,
        placeHolderImage: URL(string: "https://www.azamsharp.com/images/pepper.png")
    )
}
