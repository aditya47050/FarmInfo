
import Foundation

struct VegetableHTTPClient {
    
    func fetchVegetables() async throws -> [Vegetable] {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://raw.githubusercontent.com/aditya47050/indian_vegetables/refs/heads/main/indian_vegetables.json")!)
        return try JSONDecoder().decode([Vegetable].self, from: data)
    }
     
}
