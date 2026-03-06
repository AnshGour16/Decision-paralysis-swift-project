import SwiftUI

struct EarthquakeShakeDemo: View {
    @State private var intensity: Double = 0.0
    @State private var isSimulating = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Seismic Intensity Trainer")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.brown)
            
            HStack {
                Text("Magnitude:")
                Slider(value: $intensity, in: 0...9, step: 0.1)
                Text(String(format: "%.1f", intensity))
                    .bold()
                    .frame(width: 40)
            }
            .tint(.brown)
            .disabled(isSimulating)
            
            shakingEffect
            
            Button(action: startSimulation) {
                Text(isSimulating ? "SIMULATING..." : "TEST STRUCTURE")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isSimulating ? Color.gray : Color.brown)
                    .cornerRadius(12)
            }
            .disabled(isSimulating)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.brown.opacity(0.3), lineWidth: 1))
    }
    
    private var shakingEffect: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.brown.opacity(0.1))
                .frame(height: 120)
            
            VStack {
                Image(systemName: "building.2.fill")
                    .font(.system(size: 60))
                    .foregroundColor(intensity > 6.0 ? .red : .brown)
                    .offset(x: isSimulating ? CGFloat.random(in: -intensity...intensity) * 2 : 0)
                    
                Text(getInstructions())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(intensity > 6.0 ? .red : .brown)
                    .padding(.top, 4)
            }
        }
    }
    
    func getInstructions() -> String {
        if intensity < 3.0 { return "Minor shaking. Stay calm." }
        if intensity < 6.0 { return "Moderate shaking. Move away from glass." }
        return "SEVERE QUAKE: DROP, COVER, AND HOLD ON!"
    }
    
    func startSimulation() {
        isSimulating = true
        let generator = UIImpactFeedbackGenerator(style: intensity > 6 ? .heavy : .light)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if !isSimulating { timer.invalidate(); return }
            generator.impactOccurred()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isSimulating = false
        }
    }
}

struct FloodQuizView: View {
    @State private var waterLevel: CGFloat = 0
    @State private var hasEvacuated = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Flash Flood Simulator")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.blue)
            
            Text("Water levels are rising rapidly. When do you act?")
                .font(.caption)
                .multilineTextAlignment(.center)
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 180)
                
                VStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.top, 20)
                
                Rectangle()
                    .fill(Color.blue.opacity(0.6))
                    .frame(height: waterLevel)
                    .animation(.linear(duration: 0.5), value: waterLevel)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                
                if hasEvacuated {
                    Text("SUCCESSFULLY EVACUATED")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                        .offset(y: -70)
                } else if waterLevel > 120 {
                    Text("TRAPPED!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                        .offset(y: -70)
                }
            }
            .frame(height: 180)
            
            HStack(spacing: 15) {
                Button("Wait Inside") {
                    withAnimation { waterLevel += 40 }
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                }
                .buttonStyle(FillButtonStyle(color: .gray))
                .disabled(hasEvacuated || waterLevel > 120)
                
                Button("EVACUATE UPHILL") {
                    withAnimation { hasEvacuated = true }
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
                .buttonStyle(FillButtonStyle(color: .blue))
                .disabled(hasEvacuated || waterLevel > 120)
            }
            
            Button("Reset Scenario") {
                withAnimation {
                    waterLevel = 0
                    hasEvacuated = false
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.3), lineWidth: 1))
    }
}

struct FireSafetyTracker: View {
    @State private var timeRemaining = 120 
    @State private var timer: Timer? = nil
    @State private var isEscaping = false
    @State private var stepsCompleted = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("2-Minute Escape Drill")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.red)
            
            HStack {
                Image(systemName: "timer")
                    .font(.title2)
                    .foregroundColor(timeRemaining < 30 ? .red : .primary)
                Text("\(timeRemaining / 60):\(String(format: "%02d", timeRemaining % 60))")
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .foregroundColor(timeRemaining < 30 ? .red : .primary)
            }
            
            ProgressView(value: Double(stepsCompleted), total: 4.0)
                .tint(stepsCompleted == 4 ? .green : .red)
            
            VStack(spacing: 10) {
                EscapeStepButton(title: "1. Feel Door for Heat", isDone: stepsCompleted >= 1) { advanceStep() }
                EscapeStepButton(title: "2. Stay Low Under Smoke", isDone: stepsCompleted >= 2) { advanceStep() }
                EscapeStepButton(title: "3. Exit via Secondary Route", isDone: stepsCompleted >= 3) { advanceStep() }
                EscapeStepButton(title: "4. Call 911 from Outside", isDone: stepsCompleted >= 4) {
                    advanceStep()
                    timer?.invalidate()
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }
            }
            
            if !isEscaping && stepsCompleted == 0 {
                Button("START DRILL") {
                    isEscaping = true
                    startTimer()
                }
                .buttonStyle(FillButtonStyle(color: .red))
            } else if stepsCompleted == 4 {
                Text("Escaped Safely in \(120 - timeRemaining)s!")
                    .foregroundColor(.green)
                    .bold()
                Button("Reset") { reset() }
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.red.opacity(0.3), lineWidth: 1))
    }
    
    func advanceStep() {
        if isEscaping && timeRemaining > 0 && stepsCompleted < 4 {
            withAnimation { stepsCompleted += 1 }
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 && stepsCompleted < 4 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
    
    func reset() {
        timer?.invalidate()
        timeRemaining = 120
        stepsCompleted = 0
        isEscaping = false
    }
}

struct MockWeatherWidget: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Tactical Weather Radar")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.purple)
            
            ZStack {
                Circle()
                    .stroke(Color.purple.opacity(0.2), lineWidth: 2)
                    .frame(width: 140, height: 140)
                
                Image(systemName: "hurricane")
                    .font(.system(size: 80))
                    .foregroundColor(.purple)
                    .rotationEffect(.degrees(rotation))
                    .animation(.linear(duration: 4.0).repeatForever(autoreverses: false), value: rotation)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 10, height: 10)
                    .offset(x: 40, y: 40)
                    .overlay(Text("YOU").font(.system(size: 8, weight: .bold)).offset(y: 12))
            }
            .frame(height: 160)
            
            VStack(spacing: 4) {
                Text("Category 4 Intercept Imminent")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.red)
                Text("Wind speeds exceeding 130 mph. Finding an interior, windowless room is your ONLY priority.")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.purple.opacity(0.3), lineWidth: 1))
        .onAppear {
            rotation = 360
        }
    }
}

struct TsunamiWarningDemo: View {
    @State private var tideLevel: CGFloat = 80
    @State private var phase = 0 
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Tsunami Warning Signs")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.teal)
            
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.orange.opacity(0.3))
                    .frame(height: 150)
                
                Rectangle()
                    .fill(Color.teal.opacity(0.7))
                    .frame(height: tideLevel)
                    .animation(.easeInOut(duration: phase == 2 ? 0.5 : 3.0), value: tideLevel)
                    .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                
                if phase == 1 {
                    Text("OCEAN DRAWDOWN")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.red)
                        .offset(y: -20)
                } else if phase == 2 {
                    Text("WAVE STRIKE")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .offset(y: -60)
                }
            }
            .frame(height: 150)
            
            HStack {
                Button("1. Normal") { setPhase(0) }
                    .buttonStyle(MiniButtonStyle(isActive: phase == 0, color: .gray))
                Button("2. Drawdown") { setPhase(1) }
                    .buttonStyle(MiniButtonStyle(isActive: phase == 1, color: .orange))
                Button("3. Strike") { setPhase(2) }
                    .buttonStyle(MiniButtonStyle(isActive: phase == 2, color: .red))
            }
            
            Text(getDescription())
                .font(.caption2)
                .multilineTextAlignment(.center)
                .frame(height: 30)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.teal.opacity(0.3), lineWidth: 1))
    }
    
    func setPhase(_ newPhase: Int) {
        phase = newPhase
        if phase == 0 { tideLevel = 80 }
        else if phase == 1 { tideLevel = 20; UINotificationFeedbackGenerator().notificationOccurred(.warning) }
        else if phase == 2 { tideLevel = 150; UIImpactFeedbackGenerator(style: .heavy).impactOccurred() }
    }
    
    func getDescription() -> String {
        switch phase {
        case 1: return "The ocean rapidly recedes, exposing the sea floor. Do NOT investigate. RUN inland immediately."
        case 2: return "The wave hits with crushing force, traveling faster than you can run."
        default: return "Normal sea levels."
        }
    }
}

struct HygieneChecklist: View {
    @State private var scrubTime: CGFloat = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Text("20-Second Scrub Trainer")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.green)
            
            Text("Proper handwashing destroys virus lipid envelopes.")
                .font(.caption)
                .foregroundColor(.secondary)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(scrubTime >= 20 ? Color.green : Color.blue)
                    .frame(width: max(0, min((scrubTime / 20.0) * UIScreen.main.bounds.width * 0.7, UIScreen.main.bounds.width * 0.7)), height: 20)
                    .animation(.linear(duration: 0.1), value: scrubTime)
            }
            .padding(.horizontal, 20)
            
            Text("\(Int(scrubTime)) seconds")
                .font(.title2)
                .bold()
                .foregroundColor(scrubTime >= 20 ? .green : .primary)
            
            Button(action: {
                if scrubTime >= 20 {
                    scrubTime = 0
                    return
                }
                timer?.invalidate()
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    if scrubTime < 20 {
                        scrubTime += 0.1
                    } else {
                        timer?.invalidate()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                }
            }) {
                Text(scrubTime >= 20 ? "Reset" : "Hold to Scrub")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(scrubTime >= 20 ? Color.gray : Color.green)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.green.opacity(0.3), lineWidth: 1))
    }
}

struct WaterReminderView: View {
    @State private var hydrationLevel: CGFloat = 0.2
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Heat Stroke Preventer")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.orange)
            
            Text("Drink water constantly, before you feel thirsty.")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack(spacing: 20) {
                ZStack(alignment: .bottom) {
                    Image(systemName: "figure.stand")
                        .font(.system(size: 80))
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Rectangle()
                        .fill(hydrationLevel > 0.8 ? Color.blue : (hydrationLevel > 0.4 ? Color.orange : Color.red))
                        .frame(height: 80 * hydrationLevel)
                        .mask(
                            Image(systemName: "figure.stand")
                                .font(.system(size: 80))
                        )
                        .animation(.spring(), value: hydrationLevel)
                }
                
                VStack(spacing: 15) {
                    Button("Drink Water") {
                        if hydrationLevel < 1.0 { hydrationLevel += 0.2 }
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    }
                    .buttonStyle(FillButtonStyle(color: .blue))
                    
                    Button("Sweat / Time") {
                        if hydrationLevel > 0.1 { hydrationLevel -= 0.15 }
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.orange.opacity(0.3), lineWidth: 1))
    }
}

struct FillButtonStyle: ButtonStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? color.opacity(0.7) : color)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct EscapeStepButton: View {
    let title: String
    let isDone: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isDone ? .green : .gray)
                Text(title)
                    .foregroundColor(isDone ? .primary : .secondary)
                    .strikethrough(isDone)
                Spacer()
            }
            .padding(12)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(8)
        }
        .disabled(isDone)
    }
}

struct MiniButtonStyle: ButtonStyle {
    let isActive: Bool
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .bold()
            .foregroundColor(isActive ? .white : color)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(isActive ? color : color.opacity(0.1))
            .cornerRadius(8)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
