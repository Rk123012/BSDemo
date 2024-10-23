//
//  NSObject+Extensions.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import Foundation

extension NSObject{
    var className : String{
        return String(describing: type(of: self))
    }
    
    class var className : String{
        return String(describing: self)
    }
}
