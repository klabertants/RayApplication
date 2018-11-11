//
//  MapFilterViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol MapFilterViewControllerDelegate: class {
    func filtersChanged(filter: [Bool])
}

final class MapFilterViewController: UIViewController {
    
    init(filter: [Bool]) {
        self.currentFilter = filter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FilterCell.self, forCellReuseIdentifier: "filterCell")
        tableView.allowsSelection = false
        tableView.dataSource = self
        view.addSubview(tableView)
        inject(navigationBar)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = CGRect(x: 0,
                                 y: navigationController?.navigationBar.frame.height ?? 0,
                                 width: view.bounds.width,
                                 height: view.bounds.height - (navigationController?.navigationBar.frame.height ?? 0) - (tabBarController?.tabBar.frame.height ?? 0))
    }
    
    weak var delegate: MapFilterViewControllerDelegate?
    
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Фильтр")
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
    
    private var currentFilter: [Bool]
    private let titles = ["Пункты сбора", "Кэшбоксы", "Задания", "Лечебницы", "Зоомагазины", "Грумсалоны"]
    private let tableView = UITableView(frame: .zero)
}

extension MapFilterViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        navigationController?.popViewController(animated: true)
    }
}

extension MapFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterCell
        cell.selectionCallback = {
            self.currentFilter[indexPath.row] = !self.currentFilter[indexPath.row]
            self.delegate?.filtersChanged(filter: self.currentFilter)
        }
        cell.set(checkBoxOn: currentFilter[indexPath.row])
        cell.set(title: titles[indexPath.row])
        return cell
    }
    
    
}

private final class FilterCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkBox.on = true
        checkBox.delegate = self
        addSubview(checkBox)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let checkBoxFrame = CGRect(x: 16, y: bounds.midY - 16, width: 32, height: 32)
        let labelFrame = CGRect(x: 64, y: bounds.midY - 10, width: bounds.width - 80, height: 20)
        checkBox.frame = checkBoxFrame
        titleLabel.frame = labelFrame
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(checkBoxOn: Bool) {
        checkBox.on = checkBoxOn
    }
    
    var selectionCallback: (() -> Void)?
    
    private let checkBox = BEMCheckBox(frame: CGRect.zero)
    private let titleLabel = UILabel()
}

extension FilterCell: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        selectionCallback?()
    }
}
