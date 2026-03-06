import SwiftUI

struct SimulatorGameView: View {
    @StateObject private var viewModel = SimulatorViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                
                if viewModel.isGameOver {
                    gameOverView
                } else {
                    gamePlayView
                }
            }
            .navigationTitle("Survival Simulator")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if !viewModel.isGameOver && viewModel.currentIndex == 0 && viewModel.score == 0 {
                    viewModel.questions.shuffle()
                }
            }
        }
    }
    
    private var gamePlayView: some View {
        VStack(spacing: 20) {
            ProgressView(value: Double(viewModel.currentIndex), total: Double(viewModel.questions.count))
                .tint(viewModel.currentQuestion.disasterType.color)
                .padding(.horizontal)
                .animation(.spring(), value: viewModel.currentIndex)
            
            Text("Question \(viewModel.currentIndex + 1) of \(viewModel.questions.count)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: viewModel.currentQuestion.disasterType.iconName)
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(
                                    Circle().fill(viewModel.currentQuestion.disasterType.color)
                                        .shadow(color: viewModel.currentQuestion.disasterType.color.opacity(0.5), radius: 5)
                                )
                            
                            Text(viewModel.currentQuestion.disasterType.title)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        
                        Text(viewModel.currentQuestion.scenario)
                            .font(.title3)
                            .fontWeight(.medium)
                            .lineSpacing(6)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                    
                    VStack(spacing: 12) {
                        ForEach(0..<viewModel.currentQuestion.options.count, id: \.self) { index in
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                viewModel.selectAnswer(index)
                            }) {
                                HStack {
                                    Text(viewModel.currentQuestion.options[index])
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(optionTextColor(for: index))
                                    
                                    Spacer()
                                    
                                    if viewModel.selectedAnswer != nil {
                                        if index == viewModel.currentQuestion.correctAnswerIndex {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.green)
                                                .font(.title2)
                                        } else if index == viewModel.selectedAnswer {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title2)
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(optionBackgroundColor(for: index))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(optionBorderColor(for: index), lineWidth: 2)
                                )
                            }
                            .disabled(viewModel.selectedAnswer != nil)
                        }
                    }
                    
                    if viewModel.showExplanation {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.selectedAnswer == viewModel.currentQuestion.correctAnswerIndex ? "Correct!" : "Incorrect!")
                                .font(.headline)
                                .foregroundColor(viewModel.selectedAnswer == viewModel.currentQuestion.correctAnswerIndex ? .green : .red)
                            
                            Text(viewModel.currentQuestion.explanation)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                viewModel.nextQuestion()
                            }) {
                                Text(viewModel.currentIndex < viewModel.questions.count - 1 ? "Next Scenario" : "Finish")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.orange)
                                    .cornerRadius(12)
                                    .shadow(radius: 3)
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding()
            }
        }
    }
    
    private var gameOverView: some View {
        VStack(spacing: 30) {
            Image(systemName: "trophy.fill")
                .font(.system(size: 80))
                .foregroundColor(.yellow)
                .shadow(color: .yellow.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding(.bottom, 10)
            
            Text("Simulation Complete!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack {
                Text("Your Survival Score:")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("\(viewModel.score) / \(viewModel.questions.count)")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .foregroundColor(viewModel.score >= 3 ? .green : .orange)
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            
            if viewModel.score == viewModel.questions.count {
                Text("Perfect! You are completely prepared for any disaster.")
                    .font(.headline)
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                Text("Review the scenarios to improve your disaster readiness!")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                viewModel.restartGame()
            }) {
                Text("Play Again")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    .padding(.horizontal, 40)
            }
        }
        .padding()
    }
    
    private func optionBackgroundColor(for index: Int) -> Color {
        guard let selected = viewModel.selectedAnswer else {
            return Color(.secondarySystemGroupedBackground) 
        }
        
        if index == viewModel.currentQuestion.correctAnswerIndex {
            return Color.green.opacity(0.15) 
        } else if index == selected {
            return Color.red.opacity(0.15) 
        }
        
        return Color(.secondarySystemGroupedBackground) 
    }
    
    private func optionBorderColor(for index: Int) -> Color {
        guard let selected = viewModel.selectedAnswer else {
            return Color.clear 
        }
        
        if index == viewModel.currentQuestion.correctAnswerIndex {
            return Color.green
        } else if index == selected {
            return Color.red
        }
        
        return Color.clear
    }
    
    private func optionTextColor(for index: Int) -> Color {
        guard let selected = viewModel.selectedAnswer else {
            return .primary
        }
        
        if index == viewModel.currentQuestion.correctAnswerIndex {
            return .green
        } else if index == selected {
            return .red
        }
        
        return .secondary
    }
}
