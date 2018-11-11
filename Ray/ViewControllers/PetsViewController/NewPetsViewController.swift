//
//  NewPetsViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 11/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class NewPetsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(PetCell.self, forCellReuseIdentifier: PetCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        inject(navigationBar)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - tabBarHeight)
    }
    
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Выбрать")
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
    
    private let tableView = UITableView()
    private let pets = [PetVisit(petImage: UIImage(named: "dog-eva")!, petName: "Ева", date: "4 года", time: "Девочка"),
                        PetVisit(petImage: UIImage(named: "cat-masya")!, petName: "Мася", date: "4 года", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "cat-richard")!, petName: "Ричард", date: "8 лет", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "cat-tomasina")!, petName: "Томасина", date: "3 года", time: "Девочка"),
                        PetVisit(petImage: UIImage(named: "cat-avrora")!, petName: "Аврора", date: "3 года", time: "Девочка"),
                        PetVisit(petImage: UIImage(named: "cat-abrikos")!, petName: "Абрикос", date: "7 лет", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "cat-bonya")!, petName: "Бонифаций", date: "10 лет", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "cat-dafna")!, petName: "Дафна", date: "11 месяцев", time: "Девочка"),
                        PetVisit(petImage: UIImage(named: "cat-goliaf")!, petName: "Голиаф", date: "7 месяцев", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "cat-zhulyen")!, petName: "Жульен", date: "3 года", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "dog-bandit")!, petName: "Бандит", date: "8 недель", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "dog-black")!, petName: "Блэк", date: "7 недель", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "dog-hammer")!, petName: "Хаммер", date: "3 года", time: "Мальчик"),
                        PetVisit(petImage: UIImage(named: "dog-giselle")!, petName: "Жизель", date: "3 месяца", time: "Девочка"),
                        PetVisit(petImage: UIImage(named: "dog-lampa")!, petName: "Лампа", date: "1 год", time: "Девочка"),
                        PetVisit(petImage: UIImage(named: "dog-gwen")!, petName: "Гвэн", date: "8 месяцев", time: "Девочка")]
}

extension NewPetsViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        navigationController?.popViewController(animated: true)
    }
}

extension NewPetsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PetCell.identifier, for: indexPath) as! PetCell
        cell.set(petVisit: pets[indexPath.row])
        let petVisit = pets[indexPath.row]
        cell.hideShareButton()
        return cell
    }
    
}

extension NewPetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(96)
    }
}
