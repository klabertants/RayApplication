//
//  PetsViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit
import VK_ios_sdk

final class PetsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(PetCell.self, forCellReuseIdentifier: PetCell.identifier)
        tableView.register(AddPetCell.self, forCellReuseIdentifier: AddPetCell.identifier)
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
        titlePresenter.set(title: "Питомцы")
        return NavigationBarController(titlePresenter: titlePresenter,
                                       leftPresenter: nil,
                                       rightPresenter: nil)
    }()
    
    private let tableView = UITableView()
    private let pets = [PetVisit(petImage: UIImage(named: "dog-dexter")!, petName: "Декстер", date: "28.11.2018", time: "13:00"),
                        PetVisit(petImage: UIImage(named: "dog-grand")!, petName: "Гранд", date: "14.11.2018", time: "15:00"),
                        PetVisit(petImage: UIImage(named: "dog-eva")!, petName: "Ева", date: "01.12.2018", time: "9:00"),
                        PetVisit(petImage: UIImage(named: "cat-masya")!, petName: "Мася", date: "05.12.2018", time: "11:00"),
                        PetVisit(petImage: UIImage(named: "cat-richard")!, petName: "Ричард", date: "17.11.2018", time: "18:00"),
                        PetVisit(petImage: UIImage(named: "cat-tomasina")!, petName: "Томасина", date: "24.11.2018", time: "20:00")]
}

final class PetCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [petImageView, petNameLabel, dateLabel, shareButton].forEach(addSubview)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        petImageView.frame = CGRect(x: 16, y: 16, width: 64, height: 64)
        petImageView.layer.cornerRadius = 32
        petNameLabel.frame = CGRect(x: 96, y: 24, width: 256, height: 20)
        dateLabel.frame = CGRect(x: 96, y: 50, width: 256, height: 20)
        let shareButtonSize = CGSize(width: 60, height: 30)
        shareButton.frame = CGRect(x: bounds.width - 16 - shareButtonSize.width,
                                   y: bounds.midY - shareButtonSize.halfHeight,
                                   size: shareButtonSize)
    }
    
    func set(petVisit: PetVisit) {
        petImageView.image = petVisit.petImage
        petNameLabel.text = petVisit.petName
        dateLabel.text = petVisit.date + ", " + petVisit.time
    }
    
    private func setupUI() {
        petImageView.clipsToBounds = true
        petNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        shareButton.setImage(UIImage(named: "share-vk"), for: .normal)
        shareButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    @objc private func handleTap() {
        shareHandler?()
    }
    
    func hideShareButton() {
        shareButton.isHidden = true
    }
    
    
    private let petImageView = UIImageView()
    private let petNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let shareButton = UIButton()
    
    var shareHandler: (() -> Void)?
    
    static let identifier = "PetCell"
}

final class AddPetCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(addLabel)
        addLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        addLabel.text = "✚ Добавить питомца"
        addLabel.textAlignment = .center
        addLabel.textColor = RayColor.blueRayColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addLabel.frame = CGRect(x: 16, y: bounds.midY - 10, width: bounds.width - 32, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let addLabel = UILabel()
    static let identifier = "AddPetCell"
}

struct PetVisit {
    init(petImage: UIImage, petName: String, date: String, time: String) {
        self.petImage = petImage
        self.petName = petName
        self.date = date
        self.time = time
    }
    
    let petImage: UIImage
    let petName: String
    let date: String
    let time: String
}

extension PetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PetCell.identifier, for: indexPath) as! PetCell
            cell.set(petVisit: pets[indexPath.row])
            let petVisit = pets[indexPath.row]
            cell.shareHandler = {
                let shareDialog = VKShareDialogController()
                shareDialog.text = "\(petVisit.date) в \(petVisit.time) я играю с \(petVisit.petName). Присоединяйся!"
                shareDialog.completionHandler = { controller, result in
                    controller?.dismiss(animated: true, completion: nil)
                }
                self.present(shareDialog, animated: true, completion: nil)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPetCell.identifier, for: indexPath) as! AddPetCell
            return cell
        }
        
    }

}

extension PetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let newVC = NewPetsViewController()
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(96)
    }
}
