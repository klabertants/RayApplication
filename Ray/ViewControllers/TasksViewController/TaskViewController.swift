//
//  TaskViewController.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 10/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class TaskViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        inject(navigationBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = geoTask?.title
        subwayLabel.text = geoTask?.subway
        addressLabel.text = geoTask?.address
        dateLabel.text = geoTask?.date
        timeConsumptionLabel.text = geoTask?.timeConsumption
        rewardLabel.text = geoTask?.reward
        descriptionView.text = geoTask?.description
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch taskState {
        case .start:
            taskState = .inProgress
            taskButton.setImage(UIImage(named: "button-inprogress"), for: .normal)
        case .inProgress:
            taskState = .finish
            taskButton.setImage(UIImage(named: "button-complete"), for: .normal)
        case .finish:
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .camera
                present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subwayLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeConsumptionLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    private lazy var navigationBar: NavigationBarController = {
        let titlePresenter = NavigationTitlePresenter()
        titlePresenter.set(title: "Задание")
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
    var geoTask: GeoTask?
    private var taskState = TaskState.start
}

extension TaskViewController: ImagedButtonPresenterDelegate {
    func handleTap(_ imagedButtonPresenter: ImagedButtonPresenter) {
        navigationController?.popViewController(animated: true)
    }
}

extension TaskViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.popToRootViewController(animated: true)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension TaskViewController: UINavigationControllerDelegate {
    
}

private enum TaskState {
    case start
    case inProgress
    case finish
}
