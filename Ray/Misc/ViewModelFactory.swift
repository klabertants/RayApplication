//
//  ViewModel.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation

protocol ViewModelFactory {
    associatedtype ViewModel
    func makeViewModel() -> ViewModel
}
