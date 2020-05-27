//
//  MainData.swift
//  Mini Project
//
//  Created by Leandro Prado on 2020-05-25.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import Foundation

class MainData: Decodable {
    var title: String
    var data: [DataType: Int]
    var subItems: [MainData]
    
    var isHidden = true
    var isExpanded = false
    var level = 1

    var isExpandable: Bool {
        return subItems.count > 0
    }
    
    var hasData: Bool {
        return data.count > 0
    }
    
    init(title: String, data: [DataType: Int], subItems: [MainData], isHidden: Bool = true) {
        self.title = title
        self.data = data
        self.subItems = subItems
        self.isHidden = isHidden
    }
    
}

enum DataType: String, Decodable {
    
    case totalCases
    case totalDeaths
    case totalRecoveries
    case activeCases
    case totalTests
}
