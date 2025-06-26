import SwiftUI

struct PestDetailScreen: View {
    let pest: Pest
    
    var body: some View {
        ScrollView {
            // Image Section
            AsyncImage(url: pest.photo) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 6)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.9, green: 0.9, blue: 0.9).opacity(0.4),
                                    Color(red: 0.9, green: 0.9, blue: 0.9).opacity(0.1)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(maxWidth: .infinity, maxHeight: 250)
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0.1, green: 0.6, blue: 0.3))) // Green tint
                }
            }
            .padding(.bottom, 16)
            
            // Description
            SectionView(
                iconName: "info.circle.fill",
                title: pest.localizedDescriptionTitle,
                content: pest.localizedBody
            )
            
            // Symptoms
            SectionView(
                iconName: "exclamationmark.triangle.fill",
                title: pest.localizedSymptomsTitle,
                content: pest.localizedSymptoms
            )
            
            // Treatment
            SectionView(
                iconName: "bandage.fill",
                title: pest.localizedTreatmentTitle,
                content: pest.localizedTreatment
            )
        }
        .padding()
        .navigationTitle(pest.localizedName)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.7, blue: 0.4).opacity(0.1),
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
    }
}

struct SectionView: View {
    let iconName: String
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .foregroundColor(Color(red: 0.1, green: 0.6, blue: 0.3)) // Indian green
                    .font(.title2)
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.1, green: 0.6, blue: 0.3)) // Indian green
            }
            .padding(.bottom, 4)
            
            Text(content)
                .font(.body)
                .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4)) // Softer gray for readability
                .multilineTextAlignment(.leading)
                .lineSpacing(4)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color(red: 1.0, green: 0.95, blue: 0.9).opacity(0.2)) // Subtle cream background
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        PestDetailScreen(pest: PreviewData.loadPests()[0])
    }
}
