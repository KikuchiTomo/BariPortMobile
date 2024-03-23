//
//  SupportSummaryView.swift
//  UIComponents
//
//  Created by Tomo Kikuchi on 2024/03/21.
//

import Foundation
import UIKit

public class SupportSummaryView: UIView{
    private lazy var reputationStarView: ReputationStarView = generateReputationView()
    private lazy var reputationValueView: UILabel = generateReputationValueView()
    private lazy var reputationLabelView: UILabel = generateReputationLabelView()
    private (set) public lazy var supportLinkButton: SupportButton = generateSupportButton()
    private lazy var labelGuide: UILayoutGuide = UILayoutGuide()
    
    public var value: Float = 0.0{
        didSet{
            let repValue = min(max(value, 0.0), 5.0)
            self.reputationStarView.updateMaskLayers(value: repValue)
            self.reputationValueView.text =  String(format: "%.1f", repValue)
            self.setNeedsDisplay()
        }
    }
    
    public init(){
        super.init(frame: .zero)
        self.layoutViews()
        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SupportSummaryView{
    func generateReputationView() -> ReputationStarView{
        let view = ReputationStarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func generateReputationValueView() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 22)
        view.text = "0.0"
        view.textAlignment = .center
        view.textColor = UIColor.primary
        return view
    }
    
    func generateReputationLabelView() -> UILabel{
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.text = LocalizationString.reputationFromCorporationsLabel.localized
        return view
    }
    
    func generateSupportButton() -> SupportButton{
        let view = SupportButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func layoutViews(){
        addSubview(supportLinkButton)
        addSubview(reputationStarView)
        addSubview(reputationLabelView)
        addSubview(reputationValueView)
        addLayoutGuide(labelGuide)
        
        NSLayoutConstraint.activate([
            supportLinkButton.topAnchor.constraint(equalTo: topAnchor),
            supportLinkButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            supportLinkButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0),
            supportLinkButton.heightAnchor.constraint(equalToConstant: 60),
                    
            labelGuide.topAnchor.constraint(equalTo: supportLinkButton.bottomAnchor),
            labelGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            labelGuide.leftAnchor.constraint(equalTo: leftAnchor),
            labelGuide.heightAnchor.constraint(equalToConstant: 90),
            
            reputationValueView.bottomAnchor.constraint(equalTo: labelGuide.centerYAnchor, constant: -3),
            reputationValueView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            reputationValueView.leftAnchor.constraint(equalTo: labelGuide.rightAnchor),
            
            reputationStarView.topAnchor.constraint(equalTo: labelGuide.centerYAnchor, constant: 3),
            reputationStarView.bottomAnchor.constraint(equalTo: labelGuide.bottomAnchor),
            reputationStarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            reputationStarView.leftAnchor.constraint(equalTo: labelGuide.rightAnchor),
            
            reputationLabelView.centerYAnchor.constraint(equalTo: labelGuide.centerYAnchor),
            reputationLabelView.centerXAnchor.constraint(equalTo: labelGuide.centerXAnchor),
            reputationLabelView.widthAnchor.constraint(equalTo: labelGuide.widthAnchor, multiplier: 0.8)
        ])
    }
}
