//
//  GradationView.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/21.
//

import Foundation
import UIKit

public class GradationView: UIView{
    private var gradationLayer: CAGradientLayer
    
    let colors: [CGColor]
    
    public init(startPoint: CGPoint, endPoint: CGPoint, colors: [CGColor]){
        self.gradationLayer = CAGradientLayer()
        self.colors = colors
        self.gradationLayer.colors = colors
        self.gradationLayer.startPoint = startPoint
        self.gradationLayer.endPoint = endPoint
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        print("size:", self.frame)
        
        self.gradationLayer.frame = self.bounds
        self.gradationLayer.colors = colors
        self.layer.addSublayer(self.gradationLayer)
    }
}
