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
            
            Text("new feature installed")

        }
        .onAppear {
            viewModel.startRecording()
        }
        .onChange(of: viewModel.x) { _ in
            viewModel.syncData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
