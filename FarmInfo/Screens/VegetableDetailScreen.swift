import SwiftUI
import SwiftData

struct VegetableDetailScreen: View {
    let vegetable: Vegetable
    @Environment(\.modelContext) private var context
    
    @State private var showSeedOrSeedlingMenu: Bool = false
    
    private func saveVegetableToMyGarden(with plantOption: PlantOption) {
        let myGardenVegetable = MyGardenVegetable(vegetable: vegetable, plantOption: plantOption)
        context.insert(myGardenVegetable)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Vegetable Image
                AsyncImage(url: vegetable.thumbnailImage) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 8)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.gray.opacity(0.4), Color.gray.opacity(0.2)]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(height: 250)
                        .overlay(
                            ProgressView()
                                .scaleEffect(1.8)
                                .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 0.1, green: 0.7, blue: 0.3)))
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding(.bottom, 12)
                
                // Description
                Text(vegetable.localizedDescription)
                    .font(.body)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .lineSpacing(6)
                    .padding(.bottom, 12)
                
                Divider()
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.1, green: 0.7, blue: 0.3).opacity(0.3), Color.clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                
                Text(NSLocalizedString("quick_facts_title".localized, comment: "Quick Facts section title"))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.1, green: 0.7, blue: 0.3))
                    .padding(.top, 8)
                
                DetailRow(icon: "leaf.fill", title: "seed_depth_title".localized, value: vegetable.localizedSeedDepth)
                DetailRow(icon: "thermometer.medium", title: "germination_temp_title".localized, value: vegetable.germinationSoilTemp)
                DetailRow(icon: "calendar", title: "days_to_germination_title".localized, value: "\(vegetable.daysToGermination) " + "days_unit".localized)
                DetailRow(icon: "sun.max.fill", title: "light_requirement_title".localized, value: vegetable.localizedLight)
                DetailRow(icon: "drop.fill", title: "watering_title".localized, value: vegetable.localizedWatering)
                DetailRow(icon: "leaf.arrow.triangle.circlepath", title: "companions_title".localized, value: vegetable.localizedGoodCompanions)
                DetailRow(icon: "exclamationmark.triangle.fill", title: "bad_companions_title".localized, value: vegetable.localizedBadCompanions)
                DetailRow(icon: "heart.fill", title: "health_benefits_title".localized, value: vegetable.localizedHealthBenefits.isEmpty ? "na_value".localized : vegetable.localizedHealthBenefits)
                
                if let pests = vegetable.pests {
                    DetailRow(icon: "ladybug.fill", title: NSLocalizedString("pests_title".localized, comment: "Pests label"), value: pests.isEmpty ? NSLocalizedString("na_value", comment: "N/A value") : pests.map { $0.localizedName }.joined(separator: ", "))
                }
                
                Divider()
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.1, green: 0.7, blue: 0.3).opacity(0.3), Color.clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                
                SectionHeader(title: NSLocalizedString("growing_tips_title".localized, comment: "Growing Tips section title"))
                Text(vegetable.localizedGrowingDescription)
                    .font(.body)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                
                SectionHeader(title: NSLocalizedString("harvest_tips_title".localized, comment: "Harvest Tips section title"))
                Text(vegetable.localizedHarvestDescription)
                    .font(.body)
                    .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSeedOrSeedlingMenu = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.1, green: 0.7, blue: 0.3))
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                }
            }
        }
        .sheet(isPresented: $showSeedOrSeedlingMenu) {
            SeedOrSeedlingView(onSelected: { option in
                saveVegetableToMyGarden(with: option)
            })
            .presentationDetents([.fraction(0.3)])
            .presentationBackground(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.95, blue: 0.9), Color(red: 0.95, green: 0.9, blue: 0.85)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .navigationTitle(vegetable.localizedName)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.2, green: 0.7, blue: 0.4).opacity(0.1), Color(red: 1.0, green: 0.95, blue: 0.9).opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Color(red: 0.1, green: 0.7, blue: 0.3))
            .padding(.top, 16)
            .underline(color: Color(red: 0.1, green: 0.7, blue: 0.3).opacity(0.5))
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .foregroundColor(Color(red: 0.1, green: 0.7, blue: 0.3))
                .frame(width: 28, height: 28)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                Text(value)
                    .font(.body)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        VegetableDetailScreen(vegetable: PreviewData.loadVegetables()[0])
    }
}
