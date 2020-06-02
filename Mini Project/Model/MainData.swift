//
//  MainData.swift
//  Mini Project
//
//  Created by Leandro Prado, Cayo Mesquita, Tomona Sako on 2020-05-26.
//  Copyright © 2020 Leandro Prado, Cayo Mesquita, Tomona Sako. All rights reserved.
//

import Foundation

class MainData {
    var title: String
    var data: [DataType: Int]
    var subItems: [MainData]?
    
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
    
    init(title: String, data: [DataType: Int], subItems: [MainData], isHidden: Bool = true) {
        self.title = title
        self.data = data
        self.subItems = subItems
        self.isHidden = isHidden
    }
    
    init(from json: DataJson){
        self.title = json.title
        self.data = [:]
        for entry in json.data {
            if let key = DataType.init(rawValue: entry.key) {
                data[key] = entry.value
            }
        }
        if let subitems = json.subItems {
            self.subItems = subitems.map { MainData.init(from: $0) }
        }
    }
    
    enum CodingKeys: String {
        case title
        case data
        case subItems
        case dataType
    }
}

enum DataType: String, Decodable {
    
    case totalCases = "numtotal"
    case totalDeaths = "numdeaths"
    case totalRecoveries = "numrecover"
    case activeCases
    case totalTests = "numtested"
}

struct DataJson: Decodable{
    var title: String
    var data: [String: Int]
    var subItems: [DataJson]?
}


