import SwiftUI
import MapKit

struct RallyPoint: Codable {
    var locationName: String
    var instructions: String
    var latitude: Double
    var longitude: Double
}

struct PinLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct RallyPointView: View {
    
    @State private var locationName: String = ""
    @State private var instructions: String = ""
    @State private var isSaved = false
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var pinLocation = PinLocation(coordinate: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090))
    
    @State private var showHowTo = false
    @State private var headerPulse = false
    
    let rallySaveKey = "saved_rally_point"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                    .scaleEffect(headerPulse ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: headerPulse)
                                
                                Text("FAMILY RALLY POINT")
                                    .font(.system(size: 22, weight: .black, design: .monospaced))
                                    .foregroundColor(.primary)
                            }
                            
                            Text("Drop a pin where your family will meet if cell networks go down during a disaster.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                        }
                        .padding(.top, 10)
                        .onAppear {
                            headerPulse = true
                            loadSavedPoint()
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Button(action: {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                    showHowTo.toggle()
                                }
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }) {
                                HStack {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundColor(.orange)
                                    Text("How to Use This Tool")
                                        .font(.system(.subheadline, design: .rounded))
                                        .fontWeight(.bold)
                                    Spacer()
                                    Image(systemName: showHowTo ? "chevron.up" : "chevron.down")
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                }
                                .padding()
                            }
                            
                            if showHowTo {
                                VStack(alignment: .leading, spacing: 14) {
                                    HowToStep(step: "1", icon: "hand.tap.fill", color: .orange,
                                               title: "Drag the Map", 
                                               description: "Scroll around to navigate to your city or neighbourhood.")
                                    HowToStep(step: "2", icon: "mappin.circle.fill", color: .red,
                                               title: "Tap to Drop a Pin", 
                                               description: "Tap anywhere on the map to place your family meeting pin.")
                                    HowToStep(step: "3", icon: "pencil", color: .blue,
                                               title: "Name the Location", 
                                               description: "Add a name everyone recognises — e.g. \"Big Gate at City Park\".")
                                    HowToStep(step: "4", icon: "doc.text.fill", color: .green,
                                               title: "Add Backup Instructions", 
                                               description: "Write what to do if this spot is also unreachable — e.g. \"Go to Grandma's if flooded\".")
                                    HowToStep(step: "5", icon: "arrow.down.circle.fill", color: .purple,
                                               title: "Save Offline", 
                                               description: "Tap SAVE. Your rally point is stored offline — no internet needed ever again.")
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 16)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Image(systemName: "map.fill")
                                    .foregroundColor(.orange)
                                Text("Tap Map to Set Pin")
                                    .font(.headline)
                            }
                            .padding(.horizontal)
                            
                            ZStack {
                                Map(coordinateRegion: $region, annotationItems: [pinLocation]) { pin in
                                    MapAnnotation(coordinate: pin.coordinate) {
                                        VStack(spacing: 0) {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.orange)
                                                    .frame(width: 36, height: 36)
                                                    .shadow(color: .orange.opacity(0.6), radius: 6, x: 0, y: 3)
                                                Image(systemName: "figure.family")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(.white)
                                            }
                                            Image(systemName: "triangle.fill")
                                                .font(.system(size: 10))
                                                .foregroundColor(.orange)
                                                .offset(y: -2)
                                        }
                                    }
                                }
                                .frame(height: 240)
                                .cornerRadius(16)
                                .onTapGesture { location in
                                    let mapSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 240)
                                    let tappedCoord = regionToCoordinate(tapLocation: location, mapSize: mapSize)
                                    withAnimation(.spring()) {
                                        pinLocation = PinLocation(coordinate: tappedCoord)
                                    }
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                }
                                
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Text("TAP TO MOVE PIN")
                                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                                            .foregroundColor(.white)
                                            .padding(6)
                                            .background(Color.black.opacity(0.5))
                                            .cornerRadius(8)
                                            .padding(10)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                Text(String(format: "Lat: %.4f, Lon: %.4f", pinLocation.coordinate.latitude, pinLocation.coordinate.longitude))
                                    .font(.system(size: 11, design: .monospaced))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal)
                        }
                        
                        VStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 6) {
                                Label("Location Name", systemImage: "tag.fill")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                
                                TextField("e.g. Big gate at Centennial Park", text: $locationName)
                                    .padding(12)
                                    .background(Color(uiColor: .systemBackground))
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.orange.opacity(0.4), lineWidth: 1))
                            }
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Label("Backup Instructions", systemImage: "list.bullet.clipboard.fill")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                
                                TextField("e.g. If flooded, go to Grandma's house on MG Road", text: $instructions, axis: .vertical)
                                    .lineLimit(3...5)
                                    .padding(12)
                                    .background(Color(uiColor: .systemBackground))
                                    .cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue.opacity(0.4), lineWidth: 1))
                            }
                        }
                        .padding(.horizontal)
                        
                        Button(action: saveRallyPoint) {
                            HStack {
                                Image(systemName: isSaved ? "checkmark.seal.fill" : "square.and.arrow.down.fill")
                                Text(isSaved ? "Rally Point Saved Offline!" : "SAVE RALLY POINT OFFLINE")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                isSaved
                                ? LinearGradient(colors: [.green, .teal], startPoint: .leading, endPoint: .trailing)
                                : LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                            .shadow(color: (isSaved ? Color.green : Color.orange).opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal)
                        .animation(.spring(), value: isSaved)
                        
                        if isSaved {
                            HStack {
                                Image(systemName: "wifi.slash")
                                Text("Stored locally. Works with zero internet.")
                            }
                            .foregroundColor(.green)
                            .font(.caption)
                            .padding(.bottom, 10)
                        }
                        
                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Rally Point")
                        .font(.headline)
                }
            }
        }
    }
    
    func saveRallyPoint() {
        let point = RallyPoint(
            locationName: locationName,
            instructions: instructions,
            latitude: pinLocation.coordinate.latitude,
            longitude: pinLocation.coordinate.longitude
        )
        if let data = try? JSONEncoder().encode(point) {
            UserDefaults.standard.set(data, forKey: rallySaveKey)
        }
        withAnimation { isSaved = true }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation { isSaved = false }
        }
    }
    
    func loadSavedPoint() {
        guard let data = UserDefaults.standard.data(forKey: rallySaveKey),
              let point = try? JSONDecoder().decode(RallyPoint.self, from: data) else { return }
        locationName = point.locationName
        instructions = point.instructions
        let coord = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
        pinLocation = PinLocation(coordinate: coord)
        region.center = coord
    }
    
    func regionToCoordinate(tapLocation: CGPoint, mapSize: CGSize) -> CLLocationCoordinate2D {
        let latDelta = region.span.latitudeDelta
        let lonDelta = region.span.longitudeDelta
        let centerLat = region.center.latitude
        let centerLon = region.center.longitude
        
        let tapLat = centerLat + (0.5 - tapLocation.y / mapSize.height) * latDelta
        let tapLon = centerLon + (tapLocation.x / mapSize.width - 0.5) * lonDelta
        return CLLocationCoordinate2D(latitude: tapLat, longitude: tapLon)
    }
}

struct HowToStep: View {
    let step: String
    let icon: String
    let color: Color
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 38, height: 38)
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 18))
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Step \(step): \(title)")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.bold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
