import SwiftUI
import CoreLocation

enum DisasterType: String, CaseIterable, Identifiable, Codable {
    case earthquake, flood, fire, cyclone, tsunami, heatwave, pandemic
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .earthquake: return "waveform.path.ecg"
        case .flood: return "water.waves"
        case .fire: return "flame.fill"
        case .cyclone: return "hurricane"
        case .tsunami: return "water.waves.and.arrow.up"
        case .heatwave: return "thermometer.sun.fill"
        case .pandemic: return "cross.vial.fill"
        }
    }
    
    var title: String {
        rawValue.capitalized
    }
    
    var color: Color {
        switch self {
        case .earthquake: return .brown
        case .flood: return .blue
        case .fire: return .red
        case .cyclone: return .gray
        case .tsunami: return .teal
        case .heatwave: return .orange
        case .pandemic: return .purple
        }
    }
}

struct DisasterInfo: Identifiable, Sendable {
    let id = UUID()
    let type: DisasterType
    let example: String
    let causes: String?
    let contentList: [InfoSection]
}

struct InfoSection: Identifiable, Sendable {
    let id = UUID()
    let heading: String
    let points: [String]
    let systemImage: String?
}

struct KitItem: Identifiable, Codable, Equatable, Sendable {
    var id = UUID()
    var name: String
    var isPacked: Bool
}
