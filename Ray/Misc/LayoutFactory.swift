//
//  LayoutFactory.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import Foundation
import UIKit

protocol LayoutFactory {
    associatedtype Layout
    func makeLayout(in rect: CGRect) -> Layout
}
