//
//  VideoPlayerManager.swift
//  MiniLiveBroadcastApp
//
//  Created by 夏侯臻 on 2022/2/12.
//

import AVFoundation

struct VideoPlayerManager {
    
    let player = AVPlayer() //视频播放器
    
    var sourceURL:URL?                      //视频路径
    var sourceScheme:String?                   //路径Scheme
    var urlAsset:AVURLAsset?                //视频资源
    var playerItem:AVPlayerItem?            //视频资源载体
    var playerLayer:AVPlayerLayer = AVPlayerLayer.init()          //视频播放器图形化载体
    var timeObserver:Any?                   //视频播放器周期性调用的观察者
    
    var data:Data?                          //视频缓冲数据
    
    var session:URLSession?                 //视频下载session
    var task:URLSessionDataTask?            //视频下载NSURLSessionDataTask
    
    var response:HTTPURLResponse?           //视频下载请求响应
    var pendingRequests = [AVAssetResourceLoadingRequest]()  //存储AVAssetResourceLoadingRequest的数组
    
    var cacheFileKey:String?                                 //缓存文件key值
    var queryCacheOperation:Operation?                       //查找本地视频缓存数据的NSOperation
    
    var cancelLoadingQueue:DispatchQueue?
}
