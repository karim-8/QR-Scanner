//
//  QRCodeScanner.swift
//  QR Code Scanner
//
//  Created by Karim Soliman on 04/12/2024.
//

import SwiftUI
import AVFoundation

struct QRCodeScannerController: UIViewControllerRepresentable {
    @ObservedObject var viewModel: QRCodeScannerViewModel

        // Integrate Camera For Scanning
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerController

        init(parent: QRCodeScannerController) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first,
               let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
               let stringValue = readableObject.stringValue {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.viewModel.updateScannedCode(with: stringValue)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              captureSession.canAddInput(videoInput) else {
            return viewController
        }

        captureSession.addInput(videoInput)

        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)

        captureSession.startRunning()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
