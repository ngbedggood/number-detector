//
//  CanvasView.swift
//  NumberDetector
//
//  Created by Nathaniel Bedggood on 14/08/2025.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    
    @Binding var canvasView: PKCanvasView
        
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        let fixedWidthPen = PKInkingTool(.pen, color: .black, width: 20)
        canvasView.tool = fixedWidthPen
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
    }
       
}
