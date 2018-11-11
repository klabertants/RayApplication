//
//  TasksViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class TasksViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupUI()
        inject(navigationBar)
    }
    
    private func setupUI() {
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
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
        titlePresenter.set(title: "Задачи")
        adminButton.view.sizeToFit()
        return NavigationBarController(titlePresenter: titlePresenter,
                                       leftPresenter: EmptyPresenter(of: adminButton.view.bounds.size),
                                       rightPresenter: adminButton)
    }()
    private lazy var adminButton: ImagedButtonPresenter = {
        let buttonPresenter = ImagedButtonPresenter(with: UIImage(named: "icon-admin") ?? UIImage())
        buttonPresenter.delegate = self
        return buttonPresenter
    }()
    
    private let tableView = UITableView(frame: .zero)
    private let tasks = [GeoTask(title: "Доставить помощь в приют", reward: "70", subway: "Адмиралтейская", address: "ул. Малая Морская", date: "Каждый день", timeConsumption: "1 час", lat: 59.936394, lon: 30.314312, description: "Нужно помочь перевезти в один из приютов помощь (медицинские и ветеринарные расходные материалы)."),
                         GeoTask(title: "Нужна помощь фотографа", reward: "45", subway: "Купчино", address: "Витебский проспект, 101к2, Санкт-Петербург, Россия", date: "Каждый день", timeConsumption: "30 минут", lat: 59.829296, lon: 30.375723, description: "Для приютских собак наличие хорошего портфолио или даже всего одного снимка среднего качества - это путёвка в новую жизнь!"),
                         GeoTask(title: "Помочь доставить лекарства в приют", reward: "60", subway: "Чернышевская", address: "ул. Кирочная", date: "23.09.2017 14:00", timeConsumption: "2 часа", lat: 59.944189, lon: 30.361583, description: "Нужно помочь привезти лекарства в один из приютов Одинцовского района Подмосковья."),
                         GeoTask(title: "Нужны помощники на занятиях с кинологом", reward: "20", subway: "Фрунзенская", address: "Поселок Шувое, городской округ Егорьевск, Московская область, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 55.472592, lon: 39.079194, description: "Вы можете помочь нашим хвостикам стать на один шаг ближе к счастливому пристройству, а также получить личный опыт по воспитанию и взаимодействию с животными."),
                         GeoTask(title: "Помочь перевезти вещи", reward: "50", subway: "Обводный канал", address: "пр. Лиговский", date: "Один раз", timeConsumption: "1 час", lat: 59.913785, lon: 30.348881, description: "Добрые люди отдают вещи и лекарства для кошачьего мини-приюта. Очень нужна помощь автомобилиста для перевозки подарков."),
                         GeoTask(title: "Погулять с собакой", reward: "20", subway: "Горьковская", address: "пр. Кронверкский", date: "Каждый день", timeConsumption: "50 минут", lat: 59.956822, lon: 30.318658, description: "У работников не хватает времени и сил выгулять всех животных. Нужно приехать и погулять с собаками в любой удобный для вас день и время. Положительные эмоции гарантируем!"),
                         GeoTask(title: "Купить корм", reward: "30", subway: "Садовая", address: "пл. Сенная", date: "Раз в неделю", timeConsumption: "30 минут", lat: 59.927041, lon: 30.316696, description: "Каждую неделю в магазине у станции метро Садовая нужно покупать корм для собак и кошек."),
                         GeoTask(title: "Раздавать листовки", reward: "65", subway: "Звенигородская", address: "пр. Загородный", date: "Каждый день", timeConsumption: "1 час", lat: 59.923460, lon: 30.335116, description: "Для информирования населения о проводимых нами регулярных акций и фестивалей мы раздаем на улице листовки с анонсами мероприятий."),
                         GeoTask(title: "Помощь в приюте близ м. Бабушкинская", reward: "30", subway: "м. Бабушкинская", address: "Поселок Измайлово, сельское поселение Булатниковское, Ленинский район, Московская область, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 55.563595, lon: 37.645231, description: "Всегда актуальны: помощь в выгуле собак, профессиональная фотосъемка животных для последующего поиска дома, помощь в приготовлении горячей пищи."),
                         GeoTask(title: "Погулять с собаками в приюте", reward: "25", subway: "Приморская", address: "Поселок городского типа Большие Вяземы, Одинцовский район, Московская область, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 55.628586, lon: 36.994420, description: "В приюте проживает более 250 собак. У работников не хватает времени выгулять всех животных. Нужно приехать и погулять с собаками в любое время."),
                         GeoTask(title: "Помощь в частном приюте", reward: "30", subway: "Приморская", address: "улица Одоевского, 29, Санкт-Петербург, Россия", date: "Каждый день", timeConsumption: "2 час", lat: 59.948456, lon: 30.234633, description: "Частному приюту 'Домашний' очень нужна помощь в поиске хозяев для собак и щенков, живущих в приюте."),
                         GeoTask(title: "Помощь в приюте", reward: "70", subway: "Фрунзенская", address: "Московский проспект, 73к5, Санкт-Петербург, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 59.906179, lon: 30.317530, description: "Приюту всегда нужна помощь кормами, мед.препаратами, различными строительными и отделочными материалами.")]
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        cell.fill(with: tasks[indexPath.row])
        return cell
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TaskPointInfoView.viewHeight + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let taskVC = UIStoryboard(name: "Task", bundle: nil).instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        taskVC.geoTask = tasks[indexPath.row]
        navigationController?.pushViewController(taskVC, animated: true)
    }
}

private final class TaskCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with geoTask: GeoTask) {
        if let taskView = geoTaskView {
            geoTaskView?.removeFromSuperview()
            geoTaskView = nil
        }
        geoTaskView = TaskPointInfoView(geoTask: geoTask, width: bounds.width, yOffset: 0)
        geoTaskView?.hideCloseButton()
        if let newTaskView = geoTaskView {
            addSubview(newTaskView)
        }
    }
    
    private var geoTaskView: TaskPointInfoView?
    static let identifier = "TaskCell"
}

extension TasksViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        let adminVC = AdminTasksViewController()
        navigationController?.pushViewController(adminVC, animated: true)
    }
}
