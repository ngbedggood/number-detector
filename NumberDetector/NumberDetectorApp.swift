//
//  NumberDetectorApp.swift
//  NumberDetector
//
//  Created by Nathaniel Bedggood on 14/08/2025.
//

import SwiftUI

@main
struct NumberDetectorApp: App {
    @StateObject var manager = MLModelManager()
    @StateObject private var viewModel = CanvasViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environmentObject(manager)
        }
    }
}
