//
//  WatchConnectivityVM.swift
//  FallDetection Watch App
//
//  Created by Frank Chu on 3/26/23.
//

import Foundation
import WatchConnectivity

import CoreMotion

final class ViewModel: NSObject, ObservableObject {
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
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        } else {
            print("not supported")
        }
    }
}

extension ViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session Activated")
    }
    
    func syncData() {
        print("Syncing Data")
        let data = ["x": x, "y": y, "z": z]
        WCSession.default.sendMessage(data, replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}
