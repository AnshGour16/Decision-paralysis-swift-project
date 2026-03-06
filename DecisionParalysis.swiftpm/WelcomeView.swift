import SwiftUI

struct WelcomeView: View {
    @Binding var hasStarted: Bool
    
    @State private var appear = false
    @State private var floatAnim = false
    @State private var radarSpin = 0.0
    @State private var pulseRings = false
    @State private var buttonHover = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.15, blue: 0.3),
                    Color(red: 0.05, green: 0.05, blue: 0.1)
                ]),
                startPoint: appear ? .topLeading : .bottomTrailing,
                endPoint: appear ? .bottomTrailing : .topLeading
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 8.0).repeatForever(autoreverses: true), value: appear)
            
            Image(systemName: "square.grid.3x3.square")
                .resizable()
                .opacity(0.03)
                .scaleEffect(3.0)
                .rotationEffect(.degrees(45))
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                ZStack {
                    ForEach(0..<3) { i in
                        Circle()
                            .stroke(Color.cyan.opacity(0.4 - Double(i) * 0.1), lineWidth: 2)
                            .frame(width: 150 + CGFloat(i) * 60, height: 150 + CGFloat(i) * 60)
                            .scaleEffect(pulseRings ? 1.4 : 0.8)
                            .opacity(pulseRings ? 0 : 1)
                            .animation(
                                .easeOut(duration: 2.5)
                                .repeatForever(autoreverses: false)
                                .delay(Double(i) * 0.8),
                                value: pulseRings
                            )
                    }
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 4, dash: [10, 15, 30, 15]))
                        .foregroundColor(.cyan)
                        .frame(width: 180, height: 180)
                        .rotationEffect(.degrees(radarSpin))
                        .animation(.linear(duration: 15).repeatForever(autoreverses: false), value: radarSpin)
                    
                    ZStack {
                        Circle()
                            .fill(
                                RadialGradient(
                                    gradient: Gradient(colors: [.cyan.opacity(0.8), .blue]),
                                    center: .center, startRadius: 10, endRadius: 60
                                )
                            )
                            .frame(width: 120, height: 120)
                            .shadow(color: .cyan.opacity(0.5), radius: 20, x: 0, y: 0)
                        
                        Image(systemName: "exclamationmark.shield.fill")
                            .font(.system(size: 60, weight: .thin))
                            .foregroundColor(.white)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .scaleEffect(floatAnim ? 1.05 : 0.95)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: floatAnim)
                    }
                }
                .offset(y: appear ? 0 : -50)
                
                VStack(spacing: 16) {
                    Text("DECISION PARALYSIS")
                        .font(.system(size: 28, weight: .black, design: .monospaced))
                        .foregroundColor(.white)
                        .tracking(3)
                        .shadow(color: .black.opacity(0.5), radius: 5)
                    
                    Text("Surviving the Critical Seconds")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.cyan)
                        .opacity(0.9)
                        .offset(y: floatAnim ? -3 : 3)
                        .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: floatAnim)
                }
                .opacity(appear ? 1 : 0)
                .offset(y: appear ? 0 : 30)
                
                Spacer()
                
                Button(action: {
                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    withAnimation(.easeInOut(duration: 0.1)) {
                        buttonHover = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                            hasStarted = true
                        }
                    }
                }) {
                    HStack(spacing: 12) {
                        Text("START NOW")
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                        
                        Image(systemName: "chevron.right.2")
                            .font(.system(size: 16, weight: .bold))
                            .offset(x: floatAnim ? 5 : 0)
                            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: floatAnim)
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 40)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.cyan)
                            
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                .blur(radius: 2)
                        }
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.cyan.opacity(0.5), lineWidth: 4)
                            .scaleEffect(buttonHover ? 1.2 : 1)
                            .opacity(buttonHover ? 0 : 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .cyan.opacity(0.6), radius: 15, x: 0, y: 10)
                }
                .scaleEffect(appear ? 1.0 : 0.8)
                .opacity(appear ? 1 : 0)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                appear = true
            }
            withAnimation(.easeOut(duration: 0.5)) {
                pulseRings = true
            }
            floatAnim = true 
            radarSpin = 360 
        }
    }
}
