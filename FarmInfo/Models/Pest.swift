import Foundation
import SwiftData

@Model
class Pest: Decodable {
    var name: String
    var body: String
    var symptoms: String
    var treatment: String
    var photo: URL
    var vegetable: Vegetable?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.body = try container.decode(String.self, forKey: .body)
        self.symptoms = try container.decode(String.self, forKey: .symptoms)
        self.treatment = try container.decode(String.self, forKey: .treatment)
        self.photo = try container.decode(URL.self, forKey: .photo)
    }
    
    enum CodingKeys: String, CodingKey {
        case name, symptoms, treatment, photo
        case body = "description"
    }
    
    // Localized properties
    var localizedName: String {
        NSLocalizedString("pest_\(name)_name".localized, comment: "Name of pest \(name)")
    }
    
    var localizedBody: String {
        NSLocalizedString("pest_\(name)_body".localized, comment: "Description of pest \(name)")
    }
    
    var localizedSymptoms: String {
        NSLocalizedString("pest_\(name)_symptoms".localized, comment: "Symptoms of pest \(name)")
    }
    
    var localizedTreatment: String {
        NSLocalizedString("pest_\(name)_treatment".localized, comment: "Treatment for pest \(name)")
    }
    
    var localizedDescriptionTitle: String {
        NSLocalizedString("description_title".localized, comment: "Title for Description section")
    }

    var localizedSymptomsTitle: String {
        NSLocalizedString("symptoms_title".localized, comment: "Title for Symptoms section")
    }

    var localizedTreatmentTitle: String {
        NSLocalizedString("treatment_title".localized, comment: "Title for Treatment section")
    }
    
}
