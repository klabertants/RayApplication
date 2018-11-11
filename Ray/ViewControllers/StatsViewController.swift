//
//  StatsViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 11/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation
import UIKit
import PNChart
import RangeSeekSlider

final class StatsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(circleChart)
        view.addSubview(pieChart)
        view.addSubview(rangeSeekSlider)
        buildPieLegend()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        inject(navigationBar)
        
        rangeSeekSlider.frame = CGRect(x: 16, y: 500, width: view.bounds.width - 32, height: 64)
        rangeSeekSlider.tintColor = RayColor.blueRayColor
        rangeSeekSlider.hideLabels = true
        rangeSeekSlider.delegate = self
        
        circleChart.backgroundColor = .clear
        circleChart.strokeColor = RayColor.blueRayColor
        circleChart.stroke()
        
        pieChart.stroke()
    }
    
    private func buildPieLegend() {
        pieChart.legendStyle = .stacked
        let legend = pieChart.getLegendWithMaxWidth(170)!
        view.addSubview(legend)
        legend.frame = CGRect(x: 210, y: 316, width: 170, height: 128)
    }
    
    private lazy var circleChart: PNCircleChart = {
       let chart = PNCircleChart(frame: CGRect(x: 29, y: 119, width: 120, height: 120), total: 100, current: 67, clockwise: true)
        return chart!
    }()
    
    private lazy var pieChart: PNPieChart = {
        //frame = (16 296; 343 128)
        let items = [PNPieChartDataItem(value: 7, color: .red, description: "Перевозки"),
                     PNPieChartDataItem(value: 12, color: .blue, description: "Удаленная помощь"),
                     PNPieChartDataItem(value: 31, color: .green, description: "Выгул"),
                     PNPieChartDataItem(value: 50, color: .orange, description: "Работа в приюте")]
        let chart = PNPieChart(frame: CGRect(x: 16, y: 316, width: 170, height: 128), items: items)
        chart?.descriptionTextColor = .white
        chart?.showOnlyValues = true
        chart?.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 14)
        return chart!
    }()
    
    private let rangeSeekSlider = RangeSeekSlider()
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Статистика")
        backButton.view.sizeToFit()
        return NavigationBarController(titlePresenter: titlePresenter,
                                       leftPresenter: backButton,
                                       rightPresenter: EmptyPresenter(of: backButton.view.bounds.size))
    }()
    private lazy var backButton: ImagedButtonPresenter = {
        let buttonPresenter = ImagedButtonPresenter(with: UIImage(named: "back-icon") ?? UIImage())
        buttonPresenter.delegate = self
        return buttonPresenter
    }()
    private let news = [18, 11, 13, 9, 12]
    private let dones = [192, 103, 127, 104, 187]
    private let money = [93712, 71514, 102315, 85513, 120595]
    private let percents = [86, 61, 72, 64, 84]
    
    
    @IBOutlet weak var worthLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
}

extension StatsViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        navigationController?.popViewController(animated: true)
    }
}

extension StatsViewController: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        let perecentRand = arc4random_uniform(4)
        let moneyRand = arc4random_uniform(4)
        let doneRand = arc4random_uniform(4)
        let newsRand = arc4random_uniform(4)
        
        circleChart.current = percents[Int(perecentRand)] as NSNumber
        circleChart.stroke()
        
        worthLabel.text = "Собрано: \(money[Int(moneyRand)])р"
        doneLabel.text = "Выполнено задач: \(dones[Int(doneRand)])"
        newLabel.text = "Новых пользователей: \(news[Int(newsRand)])"
    }
}
