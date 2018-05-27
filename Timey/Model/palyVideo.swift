//
//  palyVideo.swift
//  Timey
//
//  Created by Jean Pierre on 1/25/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation



class VideoPlay: UIView {
    
    private var player : AVPlayer!
    
    private var playerLayer : AVPlayerLayer!
    
    init() {
        
        super.init(frame: CGRectZero)
        self.initializePlayerLayer()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializePlayerLayer()
        self.autoresizesSubviews = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializePlayerLayer()
        
    }
    
    
    private func initializePlayerLayer() {
        
        playerLayer = AVPlayerLayer()
        playerLayer.backgroundColor = UIColor.whiteColor().CGColor
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.bounds
    }
    
    func playVideoWithURL(url: NSURL) {
        
        player = AVPlayer(URL: url)
        player.muted = false
        
        playerLayer.player = player
        
        player.play()
        
        loopVideo(player)
    }
    
    func toggleMute() {
        player.muted = !player.muted
    }
    
    func isMuted() -> Bool
    {
        return player.muted
    }
    
    func loopVideo(videoPlayer: AVPlayer) {
        
        NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: nil, queue: nil) { notification in
            
            videoPlayer.seekToTime(kCMTimeZero)
            videoPlayer.play()
        }
    }
    
}
