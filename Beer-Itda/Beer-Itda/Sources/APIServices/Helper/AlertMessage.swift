//
//  AlertMessage.swift
//  Beer-Itda
//
//  Created by Zoe on 2022/02/05.
//

import Foundation

class AlertMessage: Error {
    
    // MARK: - Vars & Lets
    
    var title = ""
    var body = ""
    
    // MARK: - Intialization
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
}
