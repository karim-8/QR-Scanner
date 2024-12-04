//
//  ContentView.swift
//  QR Code Scanner
//
//  Created by Karim Soliman on 04/12/2024.
//

import SwiftUI

struct QRCodeScannerView: View {
    @ObservedObject var viewModel: QRCodeScannerViewModel

    var body: some View {
        VStack(spacing: 20) {
            if let code = viewModel.scannedCode {
                Text("Scanned Code: \(code.value)")
                    .font(.headline)
                    .padding()
            } else {
                Text("No QR Code Scanned")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Button(action: {
                viewModel.isShowingScanner = true
            }) {
                Text("Scan QR Code")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .sheet(isPresented: $viewModel.isShowingScanner) {
            QRCodeScannerController(viewModel: viewModel)
        }
    }
}
