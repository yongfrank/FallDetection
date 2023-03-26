//
//  ContentView.swift
//  FallDetection
//
//  Created by Frank Chu on 3/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AppConnectivityVM()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("x: \(viewModel.x)")
            Text("y: \(viewModel.y)")
            Text("z: \(viewModel.z)")
        }
        .padding()
    }
    
    // write viewmodel data every 0.1s
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
