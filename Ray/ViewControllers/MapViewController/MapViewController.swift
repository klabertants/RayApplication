//
//  MapViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: RayViewController {
    
    override init() {
        super.init()
        
        let imageSize = CGSize(width: 30, height: 30)
        let image = UIImage(named: "tab-maps")?.resize(targetSize: imageSize).withRenderingMode(.alwaysOriginal)
        tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let layout = makeLayout(in: view.bounds)
        mapView.frame = layout.mapViewFrame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        view.addSubview(taskInfoView)
        inject(navigationBar)
    }
    
    func toAnnotation(_ geoTask: GeoTask) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = geoTask.title
        let coords = CLLocationCoordinate2D(latitude: geoTask.lat, longitude: geoTask.lon)
        annotation.coordinate = coords
        return annotation
    }
    
    private let tasks = [[GeoTask(title: "Доставить помощь в приют", reward: "70", subway: "Адмиралтейская", address: "ул. Малая Морская", date: "Каждый день", timeConsumption: "1 час", lat: 59.936394, lon: 30.314312, description: "Нужно помочь перевезти в один из приютов помощь (медицинские и ветеринарные расходные материалы)."),
                          GeoTask(title: "Нужна помощь фотографа", reward: "45", subway: "Купчино", address: "Витебский проспект, 101к2, Санкт-Петербург, Россия", date: "Каждый день", timeConsumption: "30 минут", lat: 59.829296, lon: 30.375723, description: "Для приютских собак наличие хорошего портфолио или даже всего одного снимка среднего качества - это путёвка в новую жизнь!")],
                         [GeoTask(title: "Помочь доставить лекарства в приют", reward: "60", subway: "Чернышевская", address: "ул. Кирочная", date: "23.09.2017 14:00", timeConsumption: "2 часа", lat: 59.944189, lon: 30.361583, description: "Нужно помочь привезти лекарства в один из приютов Одинцовского района Подмосковья."),
                          GeoTask(title: "Нужны помощники на занятиях с кинологом", reward: "20", subway: "Фрунзенская", address: "Поселок Шувое, городской округ Егорьевск, Московская область, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 55.472592, lon: 39.079194, description: "Вы можете помочь нашим хвостикам стать на один шаг ближе к счастливому пристройству, а также получить личный опыт по воспитанию и взаимодействию с животными.")],
                         [GeoTask(title: "Помочь перевезти вещи", reward: "50", subway: "Обводный канал", address: "пр. Лиговский", date: "Один раз", timeConsumption: "1 час", lat: 59.913785, lon: 30.348881, description: "Добрые люди отдают вещи и лекарства для кошачьего мини-приюта. Очень нужна помощь автомобилиста для перевозки подарков."),
                          GeoTask(title: "Погулять с собакой", reward: "20", subway: "Горьковская", address: "пр. Кронверкский", date: "Каждый день", timeConsumption: "50 минут", lat: 59.956822, lon: 30.318658, description: "У работников не хватает времени и сил выгулять всех животных. Нужно приехать и погулять с собаками в любой удобный для вас день и время. Положительные эмоции гарантируем!")],
                         [GeoTask(title: "Купить корм", reward: "30", subway: "Садовая", address: "пл. Сенная", date: "Раз в неделю", timeConsumption: "30 минут", lat: 59.927041, lon: 30.316696, description: "Каждую неделю в магазине у станции метро Садовая нужно покупать корм для собак и кошек."),
                          GeoTask(title: "Раздавать листовки", reward: "65", subway: "Звенигородская", address: "пр. Загородный", date: "Каждый день", timeConsumption: "1 час", lat: 59.923460, lon: 30.335116, description: "Для информирования населения о проводимых нами регулярных акций и фестивалей мы раздаем на улице листовки с анонсами мероприятий.")],
                         [GeoTask(title: "Помощь в приюте близ м. Бабушкинская", reward: "30", subway: "м. Бабушкинская", address: "Поселок Измайлово, сельское поселение Булатниковское, Ленинский район, Московская область, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 55.563595, lon: 37.645231, description: "Всегда актуальны: помощь в выгуле собак, профессиональная фотосъемка животных для последующего поиска дома, помощь в приготовлении горячей пищи."),
                          GeoTask(title: "Погулять с собаками в приюте", reward: "25", subway: "Приморская", address: "Поселок городского типа Большие Вяземы, Одинцовский район, Московская область, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 55.628586, lon: 36.994420, description: "В приюте проживает более 250 собак. У работников не хватает времени выгулять всех животных. Нужно приехать и погулять с собаками в любое время.")],
                         [GeoTask(title: "Помощь в частном приюте", reward: "30", subway: "Приморская", address: "улица Одоевского, 29, Санкт-Петербург, Россия", date: "Каждый день", timeConsumption: "2 час", lat: 59.948456, lon: 30.234633, description: "Частному приюту 'Домашний' очень нужна помощь в поиске хозяев для собак и щенков, живущих в приюте."),
                          GeoTask(title: "Помощь в приюте", reward: "70", subway: "Фрунзенская", address: "Московский проспект, 73к5, Санкт-Петербург, Россия", date: "Каждый день", timeConsumption: "1 час", lat: 59.906179, lon: 30.317530, description: "Приюту всегда нужна помощь кормами, мед.препаратами, различными строительными и отделочными материалами.")]]
    
    private lazy var annotations: [[MKPointAnnotation]] = {
        var result = [[MKPointAnnotation]]()
        for item in tasks {
            result.append(item.map(toAnnotation))
        }
        return result
    }()
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: "pin")
        updateFilters()
        view.addSubview(mapView)
        moveToCurrentRegion()
    }
    
    private func updateFilters() {
        for idx in 0..<filter.count {
            mapView.removeAnnotations(annotations[idx])
        }
        for (idx, item) in filter.enumerated() {
            if (item) {
                mapView.addAnnotations(annotations[idx])
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func updateFromDatabase() {
        return
    }
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @objc private func handleLocationButtonTapped() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
           moveToCurrentRegion()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func moveToCurrentRegion() {
        guard let currentLocation = locationManager.location else { return }
        moveTo(coordinates: currentLocation.coordinate)
    }
    
    private func moveTo(coordinates: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinates,
                                        latitudinalMeters: CLLocationDistance(exactly: 1000)!,
                                        longitudinalMeters: CLLocationDistance(exactly: 1000)!)
        mapView.setRegion(region, animated: true)
    }
    
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    
    private var filter = [Bool](repeating: true, count: 6)
    
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Карта")
        return NavigationBarController(titlePresenter: titlePresenter,
                                       leftPresenter: locationButton,
                                       rightPresenter: filterButton)
    }()
    private lazy var filterButton: ImagedButtonPresenter = {
        let buttonPresenter = ImagedButtonPresenter(with: UIImage(named: "filter-icon") ?? UIImage())
        buttonPresenter.delegate = self
        return buttonPresenter
    }()
    private lazy var locationButton: ImagedButtonPresenter = {
        let buttonPresenter = ImagedButtonPresenter(with: UIImage(named: "location-button") ?? UIImage())
        buttonPresenter.delegate = self
        return buttonPresenter
    }()
    
    private lazy var taskInfoView: TaskPointInfoView = {
        let task = GeoTask(title: "", reward: "", subway: "", address: "", date: "", timeConsumption: "", lat: 0, lon: 0, description: "")
        let pointView = TaskPointInfoView(geoTask: task, width: view.bounds.width, yOffset: view.bounds.height - (tabBarController?.tabBar.frame.height ?? 0))
        return pointView
    }()
}

extension MapViewController: LayoutFactory {
    struct Layout {
        let mapViewFrame: CGRect
    }
    
    func makeLayout(in rect: CGRect) -> MapViewController.Layout {
        let tabBarFrameHeight = tabBarController?.tabBar.frame.height ?? 0
        let mapViewFrame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tabBarFrameHeight)
        return Layout(mapViewFrame: mapViewFrame)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            moveToCurrentRegion()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        moveTo(coordinates: annotation.coordinate)
        let lat = annotation.coordinate.latitude
        let lon = annotation.coordinate.longitude
        for row in tasks {
            for task in row {
                if lat == task.lat && lon == task.lon {
                    taskInfoView.set(geoTask: task)
                    taskInfoView.show()
                }
            }
        }
    }
}

extension MapViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        if imagedButtonPresenter === locationButton {
            handleLocationButtonTapped()
        } else if imagedButtonPresenter === filterButton {
            let filterVC = MapFilterViewController(filter: filter)
            filterVC.delegate = self
            navigationController?.pushViewController(filterVC, animated: true)
        }
    }
}

extension MapViewController: MapFilterViewControllerDelegate {
    func filtersChanged(filter: [Bool]) {
        self.filter = filter
        updateFilters()
    }
}
