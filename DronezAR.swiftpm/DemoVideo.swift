//
//  DemoVideo.swift
//  DronezAR
//
//  Created by Ayush Singh on 19/04/23.
//

import SwiftUI
import AVKit

struct DemoVideo: View {
    var body: some View {
        let fileUrl = Bundle.main.url(forResource: "demovideo", withExtension: "mp4")!
            VStack {
                HStack{
                    VideoPlayer(player: AVPlayer(url: fileUrl))
                }
            }
    }
}

struct DemoVideo_Previews: PreviewProvider {
    static var previews: some View {
        DemoVideo()
    }
}

