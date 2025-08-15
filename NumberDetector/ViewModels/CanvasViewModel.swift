//
//  CanvasViewModel.swift
//  NumberDetector
//
//  Created by Nathaniel Bedggood on 15/08/2025.
//

import Foundation
import PencilKit


class CanvasViewModel: ObservableObject {
    
    
    func clearCanvas(canvasView: PKCanvasView) {
        canvasView.drawing = PKDrawing()
    }
    
    func exportCanvasImage(canvasView: PKCanvasView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: canvasView.bounds.size)
        return renderer.image { ctx in
            UIColor.white.setFill()
            ctx.fill(canvasView.bounds)
            
            canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
                .draw(in: canvasView.bounds)
        }
    }
    
}
