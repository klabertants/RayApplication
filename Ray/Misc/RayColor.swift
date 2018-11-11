//
//  RayColor.swift
//  Ray
//
//  Created by Дмитрий Ткаченко on 09/11/2018.
//  Copyright © 2018 LilHack. All rights reserved.
//

import UIKit

final class RayColor: UIColor {
    static var oragneRayColor: UIColor {
        return color(with: 0xF59331)
    }
    
    static var blueRayColor: UIColor {
        return color(with: 0x2A3D8B)
    }
    
    static var tabBarColor: UIColor {
        //return color(with: 0xD79120)
        return color(with: 0xEABA6B)
    }
    
    static var multiButtonGreen: UIColor {
        return color(with: 0x00C800)
    }
    
    static var multiButtonYellow: UIColor {
        return color(with: 0xE7EA00)
    }
    
    static var multiButtonRed: UIColor {
        return color(with: 0xD92D3A)
    }
    
    static var multiButtonOrange: UIColor {
        return color(with: 0xE49000)
    }
    
    static var gameColor: UIColor {
        return color(with: 0x2E7866)
    }
    
    static var creme: UIColor {
        return color(with: 0xF9F9ED)
    }
    
    static var lightBlue: UIColor {
        return color(with: 0xF2F9F9)
    }
    
    static var pinky: UIColor {
        return color(with: 0xF7F2EF)
    }
    
    static var navBarTitleColor: UIColor {
        return color(with: 0x0063FF)
    }
}

private extension RayColor {
    static func color(hex: UInt, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(((hex >> 16) & 0xff)) / 255,
                       green: CGFloat(((hex >> 8) & 0xff)) / 255,
                       blue: CGFloat((hex & 0xff)) / 255,
                       alpha: alpha)
    }
    
    static func color(with hex: UInt) -> UIColor {
        return color(hex: hex, alpha: 1)
    }
    
    static func color(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red) / 255,
                       green: CGFloat(green) / 255,
                       blue: CGFloat(blue) / 255,
                       alpha: 1)
    }
}
