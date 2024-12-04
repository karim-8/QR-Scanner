//
//  QR_Code_ScannerApp.swift
//  QR Code Scanner
//
//  Created by Karim Soliman on 04/12/2024.
//

import SwiftUI

@main
struct QR_Code_ScannerApp: App {
    @StateObject private var coordinator = QRCodeScannerCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
