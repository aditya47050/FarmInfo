import SwiftUI

struct VegetableCellView: View {
    let vegetable: Vegetable
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            // Vegetable Thumbnail Image
            AsyncImage(url: vegetable.thumbnailImage) { image in
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.1, green: 0.7, blue: 0.3).opacity(0.5), // Rich Indian green
                                    Color(red: 1.0, green: 0.6, blue: 0.2).opacity(0.5) // Warm saffron
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90)
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 6)
                    
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
                }
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
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                }
            }
            
            // Vegetable Details
            VStack(alignment: .leading, spacing: 6) {
                Text("vegetable_\(vegetable.vegetableId)_name".localized)
                    .font(.custom("Georgia-Bold", size: 20))
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                Text("vegetable_\(vegetable.vegetableId)_description".localized)
                    .font(.custom("Georgia", size: 14))
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                    .lineLimit(2)
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
                            gradient: Gradient(colors: [Color(red: 0.1, green: 0.7, blue: 0.3), Color(red: 1.0, green: 0.6, blue: 0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
                    .blur(radius: 1) // Subtle glow effect
            )
        )
        .padding(.horizontal, 12)
    }
}

#Preview {
    VegetableCellView(vegetable: PreviewData.loadVegetables()[0])
        .environmentObject(LanguageManager.shared)
}
