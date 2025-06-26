
import Foundation

extension Date {
    
    func daysAgo(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: self) ?? self 
    }
    
}
