//
//  PublicBoardView.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/14.
//

import SwiftUI

struct PublicBoardView: View {
    
    @ObservedObject var model:PublicBoardViewModel
    let textFieldModel:AutoFitTextFieldViewModel
    
    var body: some View {
        ZStack {
            VideoPlayerView(videoManager: model.videoManager)
                .onTapGesture {
                    model.videoManager.updatePlayerState()
                }
            VStack {
                Spacer(minLength: 0)
                HStack {
                    ZStack{
                        AutoFitTextFieldView(model: textFieldModel)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: .screenWidth / 1.2)
                    }
                }
                ProgressView(value: model.progress)
                    .padding(.bottomPadding)
            }
            .opacity(model.isVideoReady ? 1 : 0)
        }
        .alert(isPresented: $model.isVideoLoadFailed){
            Alert(title: Text("Video Load Failed"),
                  message: Text(model.errorDescription),
                  dismissButton: .default(Text("Ok")))
        }
        .ignoresSafeArea()
    }
}

struct PublicBoardView_Previews: PreviewProvider {
    static var previews: some View {
        PublicBoardView(model: PublicBoardViewModel(), textFieldModel: AutoFitTextFieldViewModel())
    }
}
