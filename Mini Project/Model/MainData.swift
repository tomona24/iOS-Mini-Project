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
    var data: [String: Int]
    //    var data: [DataType: Int]
    var subItems: [MainData]?
    var dataType: DataType?
    
    var isHidden = true
    var isExpanded = false
    var level = 1
    
    var isExpandable: Bool {
        if let subItems = subItems {
            return subItems.count > 0
        } else {
            return false
        }
        
    }
    
    var hasData: Bool {
        return data.count > 0
    }
    
    init(title: String, data: [String: Int], subItems: [MainData], isHidden: Bool = true) {
        self.title = title
        self.data = data
        self.subItems = subItems
        self.isHidden = isHidden
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case data
        case subItems
        case dataType
    }
}

enum DataType: String, Decodable {
    
    case totalCases
    case totalDeaths
    case totalRecoveries
    case activeCases
    case totalTests
}


