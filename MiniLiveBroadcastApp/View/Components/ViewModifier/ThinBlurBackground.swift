//
//  ThinBlurBackground.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/16.
//

import SwiftUI

struct ThinBlurBackground<S>: ViewModifier where S:Shape {
    let shapeStyle:Material
    let shape:S
    func body(content: Content) -> some View {
        content
            .padding(.backgroundPadding)
            .background(shapeStyle, in: shape)
    }
}

extension View {
    
    func thinBlurBackground<S>(shapeStyle:Material,shape:S) -> some View where S:Shape {
        self.modifier(ThinBlurBackground(shapeStyle: shapeStyle, shape: shape))
    }
    func thinBlurBackground(shapeStyle:Material) -> some View {
        self.modifier(ThinBlurBackground(shapeStyle: shapeStyle, shape: Capsule()))
    }
    func thinBlurBackground() -> some View {
        self.modifier(ThinBlurBackground(shapeStyle: .thinMaterial,shape: Capsule()))
    }
    func thinBlurBackground<S>(shape:S) -> some View where S:Shape {
        self.modifier(ThinBlurBackground(shapeStyle: .thinMaterial, shape: shape))
    }
}
