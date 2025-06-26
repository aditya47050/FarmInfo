import SwiftUI

struct PestCellView: View {
    let pest: Pest
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            // Pest Thumbnail Image
            AsyncImage(url: pest.photo) { image in
                ZStack {
                    // Gradient Background
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.1, green: 0.7, blue: 0.3).opacity(0.5), // Rich green
                                    Color(red: 1.0, green: 0.95, blue: 0.9).opacity(0.5) // Warm cream
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90) // Slightly larger for a bolder look
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 6)
                    
                    // Image
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 6, x: 0, y: 4)
                }
            } placeholder: {
                ZStack {
                    // Gradient Placeholder Background
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
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0.1, green: 0.7, blue: 0.3))) // Green tint
                }
            }
            
            // Pest Details
            VStack(alignment: .leading, spacing: 6) {
                Text(pest.localizedName)
                    .font(.custom("Georgia-Bold", size: 18)) // Elegant font
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                
                Text(pest.localizedBody)
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
        )
        .padding(.horizontal, 12)
    }
}

#Preview(traits: .sampleData) {
    PestCellView(pest: PreviewData.loadPests()[0])
}
