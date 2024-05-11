//
//  DeviceRotationViewModifier.swift
//  Millie
//
//  Created by 김기남 on 2024/05/08.
//

import SwiftUI

fileprivate struct DeviceRotationViewModifier: ViewModifier {
    let action: (Bool) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation.isLandscape {
                    action(UIDevice.current.orientation.isPortrait)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation.isLandscape {
                    action(UIDevice.current.orientation.isPortrait)
                }
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (Bool) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
