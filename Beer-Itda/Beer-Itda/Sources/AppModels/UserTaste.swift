//
//  UserStyle.swift
//  Beer-Itda
//
//  Created by 초이 on 2021/08/05.
//

import Foundation

class UserTaste {
    
    // singleton variable
    static let shared = UserTaste()
    
    var style: [SelectedStyleSmall] = []
    var scent: [Aroma] = []
}

// MARK: - StyleSmall
struct SelectedStyleSmall {
    let bigId: Int
    let midId: Int
    let style: StyleSmall
}
