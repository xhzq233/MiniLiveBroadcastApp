# [MiniLiveBroadcastApp](https://github.com/xhzq233/MiniLiveBroadcastApp)

字节校园：「客户端-中级」我也能写迷你版直播app

* [字节校园:「客户端-中级」App演示](https://www.bilibili.com/video/BV1UY411V7kb)
* [字节校园:「客户端-中级」App讲解](https://www.bilibili.com/video/BV17m4y1o7Vq)

**Content**：

- The main body uses UIKit's UITableView, and SwiftUI's UIViewRepresentable packaging video layer, and combines bullet screen gift boards and information into SwiftUI's VIew to be arranged on UITableViewCell.
- Use Notification + Combine to follow the moving of SwiftUI's TextField.
- Delay the processing of clicks to resolve the conflict between double-click gifts and pause video gestures.
- Use Key-Value-Observing to process the audio loading status (loading, completed, failed) to update the state, and add time observer to the player to listen to the video progress.
