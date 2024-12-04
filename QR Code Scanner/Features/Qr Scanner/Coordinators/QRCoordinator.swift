//
//  QRCoordinator.swift
//  QR Code Scanner
//
//  Created by Karim Soliman on 04/12/2024.
//

import SwiftUI

class QRCodeScannerCoordinator: ObservableObject {
    @Published var viewModel: QRCodeScannerViewModel = QRCodeScannerViewModel()

    func start() -> some View {
        QRCodeScannerView(viewModel: viewModel)
    }
}
