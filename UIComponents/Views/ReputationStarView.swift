//
//  ReputationStarView.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/21.
//

import Foundation
import UIKit

public class ReputationStarView: UIView{
    static let starNumber = 5
    private lazy var stackView: UIStackView = generateStackView()
    private var starNormViews: [UIImageView]! = nil
    private var starFillViews: [UIImageView]! = nil
    
    public init(_ size: CGFloat = 24.0){
        super.init(frame: .zero)
        
        self.starNormViews = self.generateStarViews(fill: false, size: size)
        self.starFillViews = self.generateStarViews(fill: true, size: size)
        
        self.configViews()
        self.updateMaskLayers(value: 0.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func updateMaskLayers(value: Float){
        self.layoutIfNeeded()
        
        let integer = Int(floor(value))
        let fraction = value.truncatingRemainder(dividingBy: 1)
        // マスクViewを追加する
        for index in 0..<ReputationStarView.starNumber{
            let imageView = starFillViews[index]
            let maskLayer = CAShapeLayer()
            maskLayer.frame = imageView.bounds
            
            let frame = maskLayer.frame
            let width: CGFloat
            
            if integer > index{
                width = frame.width
            }else if index == integer{
                width = CGFloat(fraction) * frame.width
            }else{
                width = 0.0
            }
            
            let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.height)
            let roundrRectangle = UIBezierPath(rect: newFrame)
            maskLayer.path = roundrRectangle.cgPath
            
            imageView.layer.mask = maskLayer
            imageView.setNeedsDisplay()
        }
    }
    
    func configViews(){
        self.addSubview(stackView)
        for index in 0..<ReputationStarView.starNumber{
            // FillImageを枠組み用のImageViewに追加
            let normView = starNormViews[index]
            let fillView = starFillViews[index]
            normView.addSubview(fillView)
            
            // Fill/Norm ImageViewのレイアウトをつける
            NSLayoutConstraint.activate([             
                fillView.centerYAnchor.constraint(equalTo: normView.centerYAnchor),
                fillView.centerXAnchor.constraint(equalTo: normView.centerXAnchor),
                fillView.widthAnchor.constraint(equalTo: normView.widthAnchor),
                fillView.heightAnchor.constraint(equalTo: normView.heightAnchor),
            ])
            
            self.stackView.addArrangedSubview(normView)
        }
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func generateStarViews(fill: Bool, size: CGFloat) -> [UIImageView]{
        var views: [UIImageView] = []
        for _ in 0..<ReputationStarView.starNumber{
            let image = (fill ? UIImage.Common.StarFill : UIImage.Common.Star)
            let resizeImage = image.resize(size: CGSize(width: size, height: size)) ?? image
            let view = UIImageView(image: resizeImage.withRenderingMode(.alwaysTemplate))
            view.tintColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            views.append(view)
        }
        return views
    }
    
    func generateStackView() -> UIStackView{
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.spacing = 0
        return view
    }
}
