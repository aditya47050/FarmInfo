
import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
