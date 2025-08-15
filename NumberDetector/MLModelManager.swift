//
//  MLModelManager.swift
//  NumberDetector
//
//  Created by Nathaniel Bedggood on 14/08/2025.
//

import Foundation
import CoreML
import SwiftUI
import Accelerate
import Vision


class MLModelManager: ObservableObject {
    
    private var classifier: MNISTClassifier?
    @Published var predictedNum: Int
    
    init() {
        classifier = try? MNISTClassifier(configuration: .init())
        self.predictedNum = 0
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize = CGSize(width: 28, height: 28)) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func imageToPixelBuffer(_ image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue!,
                         kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue!] as CFDictionary
            var pxbuffer: CVPixelBuffer?
            let width = Int(image.size.width)
            let height = Int(image.size.height)

            CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                                kCVPixelFormatType_OneComponent8, // grayscale
                                attrs, &pxbuffer)
            guard let buffer = pxbuffer else { return nil }

            CVPixelBufferLockBaseAddress(buffer, .readOnly)
            let context = CGContext(data: CVPixelBufferGetBaseAddress(buffer),
                                    width: width,
                                    height: height,
                                    bitsPerComponent: 8,
                                    bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                    space: CGColorSpaceCreateDeviceGray(),
                                    bitmapInfo: 0)!
            
            context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
            CVPixelBufferUnlockBaseAddress(buffer, .readOnly)
            return buffer
    }
    
    
    func makePrediction(for image: UIImage) {
        if let resized = resizeImage(image),
           let pixelBuffer = imageToPixelBuffer(resized)
        {
            do {
                let prediction = try classifier?.prediction(image: pixelBuffer)
                predictedNum = Int(prediction?.classLabel ?? -1)
            } catch {
                print("Prediction Error: \(error.localizedDescription)")
            }
        }
    }
    
}
