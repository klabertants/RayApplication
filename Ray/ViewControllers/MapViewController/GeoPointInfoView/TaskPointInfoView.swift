//
//  TaskPointInfoView.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

enum TaskInfoViewState {
    case showed
    case hidden
}

struct GeoTask {
    init(title: String, reward: String, subway: String, address: String, date: String, timeConsumption: String, lat: Double, lon: Double, description: String) {
        self.title = title
        self.reward = reward
        self.subway = subway
        self.address = address
        self.date = date
        self.timeConsumption = timeConsumption
        self.lat = lat
        self.lon = lon
        self.description = description
    }
    
    let title: String
    let reward: String
    let subway: String
    let address: String
    let date: String
    let timeConsumption: String
    let lat: Double
    let lon: Double
    let description: String
}

final class TaskPointInfoView: UIView {
    
    static let viewHeight = CGFloat(200)
    
    init(geoTask: GeoTask, width: CGFloat, yOffset: CGFloat) {
        self.geoTask = geoTask
        self.state = .hidden
        super.init(frame: CGRect(x: 0, y: yOffset, width: width, height: TaskPointInfoView.viewHeight))
        addSubviews()
        setupUI()
    }
    
    func show() {
        guard state == .hidden else { return }
        state = .showed
        UIView.animate(withDuration: 0.2) {
            self.frame.origin.y -= TaskPointInfoView.viewHeight
        }
    }
    
    func set(geoTask: GeoTask) {
        self.geoTask = geoTask
        
        titleLabel.text = geoTask.title
        subwayLabel.text = geoTask.subway
        addressLabel.text = geoTask.address
        rewardLabel.text = geoTask.reward
        dateLabel.text = geoTask.date
        timeConsumptionLabel.text = geoTask.timeConsumption
    }
    
    @objc private func hide() {
        guard state == .showed else { return }
        state = .hidden
        UIView.animate(withDuration: 0.2) {
            self.frame.origin.y += TaskPointInfoView.viewHeight
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = makeLayout(in: bounds)
        titleLabel.frame = layout.titleLabelFrame
        subwayIcon.frame = layout.subwayIconFrame
        subwayLabel.frame = layout.subwayLabelFrame
        addressIcon.frame = layout.addressIconFrame
        addressLabel.frame = layout.addressLabelFrame
        rewardIcon.frame = layout.rewardIconFrame
        rewardLabel.frame = layout.rewardLabelFrame
        dateIcon.frame = layout.dateIconFrame
        dateLabel.frame = layout.dateLabelFrame
        timeConsumptionIcon.frame = layout.timeConsumptionIconFrame
        timeConsumptionLabel.frame = layout.timeConsumptionLabelFrame
        closeButton.frame = layout.closeButtonFrame
    }
    
    func hideCloseButton() {
        closeButton.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        let subviews = [titleLabel, subwayIcon, subwayLabel, addressIcon, addressLabel,
                        dateIcon, dateLabel, timeConsumptionIcon, timeConsumptionLabel,
                        closeButton, rewardLabel, rewardIcon]
        subviews.forEach(addSubview)
    }
    
    private func setupUI() {
        backgroundColor = RayColor.creme
        
        titleLabel.text = geoTask.title
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        subwayLabel.text = geoTask.subway
        subwayLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        addressLabel.text = geoTask.address
        addressLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        rewardLabel.text = geoTask.reward
        rewardLabel.textAlignment = .right
        dateLabel.text = geoTask.date
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        timeConsumptionLabel.text = geoTask.timeConsumption
        timeConsumptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        
        subwayIcon.image = UIImage(named: "icon-subway")
        subwayIcon.contentMode = .scaleAspectFit
        addressIcon.image = UIImage(named: "icon-address")
        addressIcon.contentMode = .scaleAspectFit
        rewardIcon.image = UIImage(named: "icon-reward")
        rewardIcon.contentMode = .scaleAspectFit
        dateIcon.image = UIImage(named: "icon-date")
        dateIcon.contentMode = .scaleAspectFit
        timeConsumptionIcon.image = UIImage(named: "icon-timeconsumption")
        timeConsumptionIcon.contentMode = .scaleAspectFit
        
        closeButton.setImage(UIImage(named: "icon-close"), for: .normal)
        closeButton.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    private let titleLabel = UILabel()
    private let subwayIcon = UIImageView()
    private let subwayLabel = UILabel()
    private let addressIcon = UIImageView()
    private let addressLabel = UILabel()
    private let rewardIcon = UIImageView()
    private let rewardLabel = UILabel()
    private let dateIcon = UIImageView()
    private let dateLabel = UILabel()
    private let timeConsumptionIcon = UIImageView()
    private let timeConsumptionLabel = UILabel()
    private let closeButton = UIButton()
    
    private var geoTask: GeoTask
    
    private var state: TaskInfoViewState
}

extension TaskPointInfoView: LayoutFactory {
    struct Layout {
        let titleLabelFrame: CGRect
        let rewardIconFrame: CGRect
        let rewardLabelFrame: CGRect
        let subwayIconFrame: CGRect
        let subwayLabelFrame: CGRect
        let addressIconFrame: CGRect
        let addressLabelFrame: CGRect
        let dateIconFrame: CGRect
        let dateLabelFrame: CGRect
        let timeConsumptionIconFrame: CGRect
        let timeConsumptionLabelFrame: CGRect
        let closeButtonFrame: CGRect
    }
    
    func makeLayout(in rect: CGRect) -> TaskPointInfoView.Layout {
        let sideOffset = CGFloat(20)
        let iconSize = CGSize(width: 20, height: 20)
        let labelHeight = CGFloat(20)
        let titleLabelFrame = CGRect(x: sideOffset, y: 20, width: 256, height: 20)
        let subwayIconFrame = CGRect(x: sideOffset, y: titleLabelFrame.maxY + 16, size: iconSize)
        let subwayLabelFrame = CGRect(x: subwayIconFrame.maxX + 8,
                                      y: subwayIconFrame.midY - labelHeight / 2,
                                      width: 128,
                                      height: labelHeight)
        let rewardIconFrame = CGRect(x: rect.width - 40, y: subwayLabelFrame.minY, size: iconSize)
        let rewardLabelFrame = CGRect(x: rect.width - 40 - 8 - 64, y: subwayLabelFrame.minY, width: 64, height: 20)
        let addressIconFrame = CGRect(x: sideOffset, y: subwayIconFrame.maxY + sideOffset, size: iconSize)
        let addressLabelFrame = CGRect(x: addressIconFrame.maxX + 8,
                                       y: addressIconFrame.midY - labelHeight / 2,
                                       width: 128,
                                       height: labelHeight)
        let dateIconFrame = CGRect(x: sideOffset, y: addressIconFrame.maxY + sideOffset, size: iconSize)
        let dateLabelFrame = CGRect(x: dateIconFrame.maxX + 8, y: dateIconFrame.midY - labelHeight / 2,
                                    width: 128,
                                    height: labelHeight)
        let timeConsumptionIconFrame = CGRect(x: sideOffset, y: dateIconFrame.maxY + sideOffset, size: iconSize)
        let timeConsumptionLabelFrame = CGRect(x: timeConsumptionIconFrame.maxX + 8,
                                               y: timeConsumptionIconFrame.midY - labelHeight / 2,
                                               width: 128,
                                               height: labelHeight)
        let closeButtonFrame = CGRect(x: rect.width - 40, y: 20, width: 20, height: 20)
        return Layout(titleLabelFrame: titleLabelFrame,
                      rewardIconFrame: rewardIconFrame,
                      rewardLabelFrame: rewardLabelFrame,
                      subwayIconFrame: subwayIconFrame,
                      subwayLabelFrame: subwayLabelFrame,
                      addressIconFrame: addressIconFrame,
                      addressLabelFrame: addressLabelFrame,
                      dateIconFrame: dateIconFrame,
                      dateLabelFrame: dateLabelFrame,
                      timeConsumptionIconFrame: timeConsumptionIconFrame,
                      timeConsumptionLabelFrame: timeConsumptionLabelFrame,
                      closeButtonFrame: closeButtonFrame)
    }
}
