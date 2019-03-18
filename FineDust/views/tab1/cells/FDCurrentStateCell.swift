//
//  FDCurrentStateCell.swift
//  FineDust
//
//  Created by YangJehPark on 2018. 5. 11..
//  Copyright © 2018년 YangJehPark. All rights reserved.
//

import UIKit
import UICountingLabel

protocol FDCurrentStateCellDelegate {
    func stateIconImageViewTouched()
}

class FDCurrentStateCell: FDCurrentTableCell {

    static let defaultHeight: CGFloat = UITableViewAutomaticDimension
    
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    @IBOutlet weak var stateIconImageView: UIImageView?
    @IBOutlet weak var stateDescriptionLabel: UILabel?
    @IBOutlet weak var stateAdviceLabel: UILabel?
    @IBOutlet weak var stateIndexNameLabel: UILabel!
    @IBOutlet weak var stateIndexValueLabel: UICountingLabel!
    @IBOutlet weak var stateIndexSlider: UISlider!
    @IBOutlet weak var stateIndexView: UIView!
    
    var delegate: FDCurrentStateCellDelegate?
    private var isAnimatedOnce = false
    private var stateIndexName = "Index"
    private enum Animation: TimeInterval {
        case duration = 2
        case delay = 0.5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        locationLabel?.numberOfLines = 0
        stateIconImageView?.tintColor = .white
        stateIconImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stateIconImageViewTouched)))
        stateIndexSlider.minimumValue = 0
        stateIndexSlider.maximumValue = 350
        stateIndexSlider.setThumbImage(UIImage(named: "arrow_down")!, for: .normal)
        stateIndexValueLabel.format = "%d"
        stateIndexValueLabel.method = .easeInOut
        for view in stateIndexView.subviews {
            if let level = AQIStandards.Level(rawValue: view.tag) {
                view.backgroundColor = AQIStandards.getLevelBackgroundColor(level)
            }
        }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(taped))
        tapRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer)
    }
    
    override func setup(data: FDData?) {
        super.setup(data: data)
        locationLabel?.text = data?.localizedAddressName ?? data?.pointName
        timeLabel?.text = data?.measureTime
        let level = AQIStandards.getLevel(data?.mainIndex)
        stateIconImageView?.image = AQIStandards.Level.icon(level)
        stateDescriptionLabel?.text = AQIStandards.getLevelTitle(level)
        stateAdviceLabel?.text = AQIStandards.getHealthImplications(level)
        stateIndexNameLabel.text = (data?.mainName ?? "Index")+" : "
        stateIndexSlider.isHidden = (data?.mainIndex == nil)
        animatedOnce(value: data?.mainIndex ?? 0)
    }
    
    @objc func taped() {
        AlertHelper.show(nil, title: "Help".localized, attributedBody: AQIStandards.attributedHelpString, completionHandler: nil)
    }
    
    @objc func stateIconImageViewTouched() {
        delegate?.stateIconImageViewTouched()
    }
    
    private func animatedOnce(value: Double) {
        if isAnimatedOnce == false {
            isAnimatedOnce = true
            animateStateIndexSlider(value: Float(value))
            let time = DispatchTime.now() + .milliseconds(Int(Animation.delay.rawValue)*1000)
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.animateStateIndexValueLabel(value: CGFloat(value))
            }
            animateStateIndexValueLabel(value: CGFloat(value))
        }
    }
    
    private func animateStateIndexSlider(value: Float) {
        stateIndexSlider.value = 0
        UIView.animate(withDuration: Animation.duration.rawValue, delay: Animation.delay.rawValue, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.stateIndexSlider.setValue(value, animated: true)
        }, completion: { (complete) in
            
        })
    }
    
    @objc private func animateStateIndexValueLabel(value: CGFloat) {
        stateIndexValueLabel.countFromZero(to: value, withDuration: Animation.duration.rawValue)
    }
}
