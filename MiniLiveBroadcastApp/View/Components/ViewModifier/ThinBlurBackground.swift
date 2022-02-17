//
//  ThinBlurBackground.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/16.
//

import SwiftUI

extension View {
    func thinBlurBackground<S>(shapeStyle: Material, shape: S) -> some View where S: Shape {
        self.padding(.backgroundPadding)
            .background(shapeStyle, in: shape)
    }
    func thinBlurBackground(shapeStyle: Material) -> some View {
        self.padding(.backgroundPadding)
            .background(shapeStyle, in: Capsule())
    }
    func thinBlurBackground() -> some View {
        self.padding(.backgroundPadding)
            .background(.thinMaterial, in: Capsule())
    }
    func thinBlurBackground<S>(shape: S) -> some View where S: Shape {
        self.padding(.backgroundPadding)
            .background(.thinMaterial, in: shape)
    }
}
