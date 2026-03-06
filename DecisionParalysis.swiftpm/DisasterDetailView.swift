import SwiftUI

struct DisasterDetailView: View {
    let disaster: DisasterInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if UIImage(named: disaster.type.rawValue) != nil {
                    Image(disaster.type.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                } else {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [disaster.type.color.opacity(0.6), disaster.type.color]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        Image(systemName: disaster.type.iconName)
                            .font(.system(size: 80, weight: .light))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(disaster.type.title)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                    
                    if !disaster.example.isEmpty {
                        Text("Example: **\(disaster.example)**")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                }
                
                if let causes = disaster.causes {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What causes it?")
                            .font(.system(.title2, design: .rounded).weight(.bold))
                        
                        Text(.init(causes))
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                }
                
                Divider()
                
                ForEach(disaster.contentList) { section in
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 8) {
                            if let icon = section.systemImage {
                                Image(systemName: icon)
                                    .font(.title2)
                                    .foregroundColor(disaster.type.color)
                            }
                            Text(section.heading)
                                .font(.system(.title2, design: .rounded).weight(.semibold))
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(section.points, id: \.self) { point in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(disaster.type.color)
                                        .font(.system(size: 16))
                                        .padding(.top, 3)
                                    Text(.init(point))
                                        .font(.system(.body, design: .rounded))
                                        .lineSpacing(2)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
                    
                    if section.id != disaster.contentList.last?.id {
                        Divider()
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Interactive Feature")
                        .font(.system(.title2, design: .rounded).weight(.bold))
                    
                    interactiveFeature(for: disaster.type)
                        .padding(.top, 4)
                }
                .padding(.bottom, 40)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .navigationTitle(disaster.type.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func interactiveFeature(for type: DisasterType) -> some View {
        switch type {
        case .earthquake: EarthquakeShakeDemo()
        case .flood: FloodQuizView()
        case .fire: FireSafetyTracker()
        case .cyclone: MockWeatherWidget()
        case .tsunami: TsunamiWarningDemo()
        case .heatwave: WaterReminderView()
        case .pandemic: HygieneChecklist()
        }
    }
}
