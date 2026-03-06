import SwiftUI

struct ContentView: View {
    @State private var hasStarted = false
    
    var body: some View {
        if hasStarted {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Database", systemImage: "books.vertical.fill")
                    }
                
                SimulatorGameView()
                    .tabItem {
                        Label("Simulator", systemImage: "gamecontroller.fill")
                    }
                
                RallyPointView()
                    .tabItem {
                        Label("Rally Point", systemImage: "mappin.and.ellipse")
                    }
            }
            .accentColor(.orange)
        } else {
            WelcomeView(hasStarted: $hasStarted)
        }
    }
}
