//
//  AppConnectivityVM.swift
//  FallDetection
//
//  Created by Frank Chu on 3/26/23.
//

import Foundation
import WatchConnectivity

class AppConnectivityVM: NSObject, ObservableObject {
    @Published var x = 0.0
    @Published var y = 0.0
    @Published var z = 0.0
    @Published var isConnected = false
    
//    var historyData
    override init() {
        super.init()
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
}

extension AppConnectivityVM: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage")
        if let x = message["x"] as? Double {
            self.x = x
        }
        if let y = message["y"] as? Double {
            self.y = y
        }
        if let z = message["z"] as? Double {
            self.z = z
        }
    }
}
