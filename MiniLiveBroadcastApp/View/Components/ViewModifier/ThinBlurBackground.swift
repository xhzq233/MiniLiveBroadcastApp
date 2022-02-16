//
//  ThinBlurBackground.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/16.
//

import SwiftUI

struct ThinBlurBackground<T>: ViewModifier where T:ShapeStyle {
    let shapeStyle:T
    func body(content: Content) -> some View {
        content
            .padding(.backgroundPadding)
            .background(shapeStyle, in: Capsule())
    }
}

extension View {
    func thinBlurBackground<T>(shapeStyle:T) -> some View where T:ShapeStyle {
        self.modifier(ThinBlurBackground(shapeStyle: shapeStyle))
    }
}
