//
//  ContentView.swift
//  FallDetection Watch App
//
//  Created by Frank Chu on 3/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("x: \(viewModel.x)")
            Text("y: \(viewModel.y)")
            Text("z: \(viewModel.z)")
            
            Button {
                viewModel.x = 0.0
                viewModel.y = 0.0
                viewModel.z = 0.0
            } label: {
                Text("reset")
            }

        }
        .onAppear {
            viewModel.startRecording()
        }
    }
}

import CoreMotion
class ViewModel: ObservableObject {
    @Published var workoutManager = WorkoutManager()
//    @Published var motionManager = MotionManager()
    
    var motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    @Published var z = 0.0
    
    func startRecording() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, let motion = motion else { return }
            self.x = self.x > motion.userAcceleration.x ? self.x : motion.userAcceleration.x
            self.y = self.y > motion.userAcceleration.y ? self.y : motion.userAcceleration.y
            self.z = self.z > motion.userAcceleration.z ? self.z : motion.userAcceleration.z
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
