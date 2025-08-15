//
//  ContentView.swift
//  NumberDetector
//
//  Created by Nathaniel Bedggood on 14/08/2025.
//

import SwiftUI
import PencilKit
import CoreML

struct ContentView: View {
    
    @EnvironmentObject var manager: MLModelManager
    @ObservedObject var viewModel: CanvasViewModel
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        VStack {
            
            Button() {
                let image = viewModel.exportCanvasImage(canvasView: canvasView)
                manager.checkProcessedImage(image: image)
            } label:{
                Text("Show Processed Image")
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                          .fill(Color(.gray))
                    )
            }
            .padding()
            
            if let image = manager.processedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("Unable to display image")
            }
            
            
            CanvasView(canvasView: $canvasView)
                .frame(width: 300, height: 300)
                .padding()
            HStack {
                Button() {
                    viewModel.clearCanvas(canvasView: canvasView)
                } label: {
                    Text("Clear")
                        .frame(width: 80)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                              .fill(Color(.red))
                        )
                }
                .padding()
                Button() {
                    let image = viewModel.exportCanvasImage(canvasView: canvasView)
                    manager.makePrediction(for: image)
                } label:{
                    Text("Predict")
                        .frame(width: 80)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                              .fill(Color(.blue))
                        )
                }
                .padding()
            }
            Text("Predicted Number:")
                .foregroundColor(.white)
                .font(.title2)
                .padding(4)
            Text("\(manager.predictedNum)")
                .foregroundColor(.white)
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }

}

#Preview {
    ContentView(viewModel: CanvasViewModel())
        .environmentObject(MLModelManager())
}
