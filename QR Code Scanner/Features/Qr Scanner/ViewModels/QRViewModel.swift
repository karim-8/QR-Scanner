//
//  QrViewModel.swift
//  QR Code Scanner
//
//  Created by Karim Soliman on 04/12/2024.
//

import SwiftUI
import Combine

class QRCodeScannerViewModel: ObservableObject {
    @Published var scannedCode: QRCode? = nil
    @Published var isShowingScanner: Bool = false

    func updateScannedCode(with code: String) {
        self.scannedCode = QRCode(value: code)
        self.isShowingScanner = false
    }
}
