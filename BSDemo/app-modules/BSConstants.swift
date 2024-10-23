//
//  BSConstants.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import UIKit

class BSConstants: NSObject {
    
    //story board name
    static let mainStoryBoard = "Main"
    
#if DEV
    static let baseUrl = "akram"
#else
    static let baseUrl = "jony"
#endif

}
