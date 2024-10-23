//
//  URLComponents+Extension.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import Foundation
extension URLComponents {
    
    mutating func addQueryItems(queryInformation : [String:Any]?) {
       
        if let receivedQueryInformation = queryInformation {
            var updatedQueryItems = [URLQueryItem]()
            if let existingnewQueryItems = self.queryItems {
                updatedQueryItems.append(contentsOf: existingnewQueryItems)
            }
            for queryItemKey in receivedQueryInformation.keys {
                if let value = receivedQueryInformation[queryItemKey] {
                    let queryItem = URLQueryItem(name: queryItemKey, value: "\(value)")
                    updatedQueryItems.append(queryItem)
                }
            }
            self.queryItems = updatedQueryItems
        }
        
    }

}
