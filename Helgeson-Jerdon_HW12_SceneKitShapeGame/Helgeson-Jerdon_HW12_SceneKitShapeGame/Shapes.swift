//
//  Shapes.swift
//  
//
//  Created by Jerdon Helgeson on 4/17/18.
//

import Foundation


public enum Shapes:Int {
    
    case Box = 0
    case Sphere = 1
    case Pyramid = 2
    case Torus = 3
    case Capsule = 4
    case Cylinder = 5
    case Cone = 6
    case Tube = 7
    
    // 2
    static func random() -> Shapes {
        let maxValue = Tube.rawValue
        let rand = arc4random_uniform(UInt32(maxValue+1))
        let daShape = Shapes(rawValue: Int(rand))!
        return daShape
    }
}
