
import Foundation
import SwiftData

@Model
class MyGardenVegetable {
    
    var vegetable: Vegetable
    var plantOption: PlantOption
    var datePlanted: Date = Date()
    
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    
    init(vegetable: Vegetable, plantOption: PlantOption) {
        self.vegetable = vegetable
        self.plantOption = plantOption
    }
    
    var daysToHarvest: Int {
        plantOption == .seed ? vegetable.daysToHarvestSeeds: vegetable.daysToHarvestSeedlings
    }
}
