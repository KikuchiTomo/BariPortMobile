//
//  TitleBackView.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/23.
//

import Foundation
import UIKit
import AVFoundation

public class TitleBackView: UIView{
    private let player = AVPlayer(url: Bundle.current.url(forResource: "kitaQ", withExtension: "mov")!)
    private var isFirst: Bool = true
    private var observers: (player: NSObjectProtocol,
                                willEnterForeground: NSObjectProtocol,
                                bounds: NSKeyValueObservation)?
    
    public init(){
        super.init(frame: .zero)
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if isFirst{
            player.play()
                      
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = bounds
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.zPosition = 0
            layer.insertSublayer(playerLayer, at: 0)
            
            let dimOverlay = CALayer()
            dimOverlay.frame = bounds
            dimOverlay.backgroundColor = UIColor.black.cgColor
            dimOverlay.zPosition = 0
            dimOverlay.opacity = 0.7
            layer.addSublayer(dimOverlay)
            
            let graLayer = CAGradientLayer()
            graLayer.colors = [UIColor.primary.cgColor, UIColor.init(white: 0.0, alpha: 0.0).cgColor]
            graLayer.startPoint = .init(x: 0.5, y: 1.0)
            graLayer.endPoint = .init(x: 0.5, y: 0.0)
            // 画面縦に半分だけ表示
            graLayer.frame = .init(origin: .init(x: bounds.origin.x, y: bounds.size.height / 2.0), size: .init(width: bounds.size.width, height: bounds.size.height / 2.0))
            layer.addSublayer(graLayer)
            
            let playerObserver = NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main) { [weak playerLayer] _ in
                    playerLayer?.player?.seek(to: .zero)
                    playerLayer?.player?.play()
                }
            
            let willEnterForegroundObserver = NotificationCenter.default.addObserver(
                forName: UIApplication.willEnterForegroundNotification,
                object: nil,
                queue: .main) { [weak playerLayer] _ in
                    playerLayer?.player?.play()
                }
            
            let boundsObserver = layer.observe(\.bounds) { [weak playerLayer, weak dimOverlay] view, _ in
                DispatchQueue.main.async {
                    playerLayer?.frame = view.bounds
                    dimOverlay?.frame = view.bounds
                }
            }
            
            observers = (playerObserver, willEnterForegroundObserver, boundsObserver)
            isFirst = false
        }
    }
    
    deinit{
        if let observers = observers {
            NotificationCenter.default.removeObserver(observers.player)
            NotificationCenter.default.removeObserver(observers.willEnterForeground)
            observers.bounds.invalidate()
        }
    }
}
