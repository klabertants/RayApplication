//
//  AdminTasksViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 11/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class AdminTasksViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupUI()
        inject(navigationBar)
    }
    
    private func setupUI() {
        tableView.register(AdminTaskCell.self, forCellReuseIdentifier: AdminTaskCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let tableViewFrame = CGRect(x: view.frame.origin.x,
                                    y: view.frame.origin.y,
                                    width: view.frame.width,
                                    height: view.frame.height - (tabBarController?.tabBar.frame.height ?? 0))
        tableView.frame = tableViewFrame
    }
    
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Панель администратора")
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
    
    private let tableView = UITableView(frame: .zero)
    let tasks = [AdminTask(title: "Довезти корм", name: "Федор Моисеев", when: "2 часа назад", state: .done),
                 AdminTask(title: "Погулять с собаками", name: "Александр Марков", when: "3 часа назад", state: .done),
                 AdminTask(title: "Вылечить кота", name: "Евгений Шлыков", when: "30 минут назад", state: .inProgress),
                 AdminTask(title: "Купить препараты", name: "Александр Васильев", when: "Только что", state: .new)]
}

enum AdminTaskState {
    case new
    case inProgress
    case done
}

struct AdminTask {
    let title: String
    let name: String
    let when: String
    let state: AdminTaskState
}

extension AdminTasksViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        navigationController?.popViewController(animated: true)
    }
}

extension AdminTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminTaskCell.identifier, for: indexPath) as! AdminTaskCell
        cell.fill(with: tasks[indexPath.item])
        return cell
    }
    
}

extension AdminTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

private class AdminTaskCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [titleLabel, nameLabel, whenLabel, whoIcon, whenIcon, stateIcon].forEach(addSubview)
        whenIcon.image = UIImage(named: "icon-timeconsumption")
        whoIcon.image = UIImage(named: "icon-person")
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        whenLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 16, y: 16, width: 256, height: 20)
        whoIcon.frame = CGRect(x: 16, y: 44, width: 16, height: 16)
        nameLabel.frame = CGRect(x: 36, y: 44, width: 256, height: 20)
        whenIcon.frame = CGRect(x: 16, y: 72, width: 16, height: 16)
        whenLabel.frame = CGRect(x: 36, y: 72, width: 256, height: 20)
        stateIcon.frame = CGRect(x: bounds.width - 8 - 40, y: bounds.midY - 20, width: 40, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with task: AdminTask) {
        titleLabel.text = task.title
        nameLabel.text = task.name
        whenLabel.text = task.when
        switch task.state {
        case .done:
            stateIcon.image = UIImage(named: "state-done")
        case .inProgress:
            stateIcon.image = UIImage(named: "state-inprogress")
        case .new:
            stateIcon.image = UIImage(named: "state-new")
        }
    }
    
    private let titleLabel = UILabel()
    private let nameLabel = UILabel()
    private let whenLabel = UILabel()
    private let whoIcon = UIImageView()
    private let whenIcon = UIImageView()
    private let stateIcon = UIImageView()
    static let identifier = "AdminTaskCell"
}
