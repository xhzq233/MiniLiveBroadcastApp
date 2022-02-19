//
//  URLImage.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/17.
//

import SwiftUI

struct URLImage: View {
    let urlString:String
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            if let image = phase.image {
                image.resizable().aspectRatio(contentMode: .fit)
                // Displays the loaded image.
            } else if phase.error != nil {
                Text(phase.error.debugDescription)
                    .font(.caption2)
                    .fixedSize()
                    .background(Color.red)  // Indicates an error.
            } else {
                ProgressView()
                    .progressViewStyle(.circular)  // Acts as a placeholder.
            }
        }
    }
}
