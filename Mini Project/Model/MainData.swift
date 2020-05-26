//
//  MainData.swift
//  Mini Project
//
//  Created by Leandro Prado on 2020-05-25.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import Foundation

struct MainData {
    var title: String
    var data: [Data: Int]
    var subItens: [MainData]
    
    var isHidden: Bool = true

    var isExpandable: Bool {
        return subItens.count > 0
    }
    
    var hasData: Bool {
        return data.count > 0
    }
}

enum Data {
    case totalCases, totalDeaths, totalRecoveries, activeCases, totalTests
        
}
