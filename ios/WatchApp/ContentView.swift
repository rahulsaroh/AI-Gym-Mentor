import SwiftUI
import WatchConnectivity

class WatchViewModel: NSObject, ObservableObject, WCSessionDelegate {
    @Published var exerciseName: String = "No Workout"
    @Published var currentSet: Int = 0
    @Published var totalSets: Int = 0
    @Published var timerRunning: Bool = false
    @Published var remainingSeconds: Int = 0
    @Published var heartRate: Int = 0
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let type = message["type"] as? String, type == "workout_update" {
                self.exerciseName = message["exercise"] as? String ?? "Workout"
                self.currentSet = message["set"] as? Int ?? 0
                self.totalSets = message["total_sets"] as? Int ?? 0
                self.timerRunning = message["timer_active"] as? Bool ?? false
                self.remainingSeconds = message["timer_seconds"] as? Int ?? 0
            }
        }
    }
    
    func markSetDone() {
        session.sendMessage(["type": "set_completed"], replyHandler: nil)
    }
}

struct ContentView: View {
    @StateObject var viewModel = WatchViewModel()
    
    var body: some View {
        VCenter {
            if viewModel.exerciseName == "No Workout" {
                Text("Start a workout on your phone")
                    .multilineTextAlignment(.center)
                    .font(.caption)
            } else {
                VStack(spacing: 8) {
                    Text(viewModel.exerciseName)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    if viewModel.totalSets > 0 {
                        Text("Set \(viewModel.currentSet) of \(viewModel.totalSets)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if viewModel.timerRunning {
                        Text("\(viewModel.remainingSeconds)s")
                            .font(.system(size: 32, weight: .bold, design: .monospaced))
                            .foregroundColor(.orange)
                    } else {
                        Button(action: {
                            viewModel.markSetDone()
                        }) {
                            Text("DONE")
                                .fontWeight(.bold)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }
            }
        }
    }
}

private struct VCenter<Content: View>: View {
    let content: () -> Content
    var body: some View {
        VStack {
            Spacer()
            content()
            Spacer()
        }
    }
}
