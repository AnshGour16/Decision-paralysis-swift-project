import SwiftUI

struct HomeView: View {
    let disasters = DisasterData.shared.allDisasters
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    @State private var headerPulse = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 8) {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                    .font(.title2)
                                    .scaleEffect(headerPulse ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: headerPulse)
                                
                                Text("THREAT DATABASE")
                                    .font(.system(size: 24, weight: .black, design: .monospaced))
                                    .foregroundColor(.primary)
                            }
                            
                            Text("Select a crisis scenario below to access critical survival protocols and actionable intelligence.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 10)
                        .onAppear {
                            headerPulse = true
                        }
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(Array(disasters.enumerated()), id: \.element.id) { index, disaster in
                                NavigationLink(destination: DisasterDetailView(disaster: disaster)) {
                                    DisasterGridCard(disaster: disaster, index: index)
                                }
                                .buttonStyle(BouncyCardButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 12) {
                            Divider()
                                .padding(.horizontal, 40)
                                .padding(.top, 10)
                            
                            HStack(spacing: 15) {
                                Image(systemName: "shield.checkered")
                                    .font(.title)
                                    .foregroundColor(.green)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Always Be Prepared.")
                                        .font(.system(.headline, design: .rounded))
                                        .fontWeight(.bold)
                                    
                                    Text("Knowledge is your first line of defense during the critical seconds.")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(uiColor: .secondarySystemGroupedBackground))
                                    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                            )
                            .padding(.horizontal)
                            .padding(.bottom, 30)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Dashboard")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct BouncyCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct DisasterGridCard: View {
    let disaster: DisasterInfo
    let index: Int
    @State private var isAppearing = false
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(.white.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: disaster.type.iconName)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
            }
            
            Spacer()
            
            Text(disaster.type.title)
                .font(.system(.headline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                .padding(.bottom, 16)
        }
        .frame(height: 160)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [disaster.type.color.opacity(0.8), disaster.type.color.opacity(1.0)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Image(systemName: "network")
                    .resizable()
                    .opacity(0.1)
                    .scaleEffect(2.0)
                    .offset(x: 40, y: 40)
                    .foregroundColor(.white)
            }
        )
        .cornerRadius(24)
        .shadow(color: disaster.type.color.opacity(0.4), radius: 10, x: 0, y: 8)
        
        .scaleEffect(isAppearing ? 1.0 : 0.8)
        .opacity(isAppearing ? 1 : 0)
        .rotation3DEffect(
            .degrees(isAppearing ? 0 : 15),
            axis: (x: 1, y: 0, z: 0)
        )
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.7).delay(Double(index) * 0.1)) {
                isAppearing = true
            }
        }
    }
}
