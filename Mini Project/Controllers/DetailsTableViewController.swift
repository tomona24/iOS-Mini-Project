//
//  DetailsTableViewController.swift
//  Mini Project
//
//  Created by Leandro Prado, Cayo Mesquita, Tomona Sako on 2020-05-26.
//  Copyright © 2020 Leandro Prado, Cayo Mesquita, Tomona Sako. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    var data: MainData!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveryLabel: UILabel!
    @IBOutlet weak var activeCasesLabel: UILabel!
    @IBOutlet weak var totalTestsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UITextView.init()
        title.text = data.title
        title.layer.backgroundColor = .none
        title.font = UIFont.systemFont(ofSize: 30)

        self.navigationItem.titleView = title
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 126.0 / 255.0, green: 164.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white
        
//        Original insertion of numbers in cells:
        let unknown = "N/A"
//        Formatted numbers inserted in cells:
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        
        let date = data.date
        dateLabel.text = String(date[..<date.index(date.startIndex, offsetBy: 10)])
        
        if let totalCasesNum = Int(data.data[.totalCases]?.description ?? unknown) {
            let formattedNumber = formater.string(from: NSNumber(value: totalCasesNum))
            totalCasesLabel.text = formattedNumber
        } else {
            totalCasesLabel.text = unknown
        }
        
        if let totalDeathsNum = Int(data.data[.totalDeaths]?.description ?? unknown) {
            let formattedNumber = formater.string(from: NSNumber(value: totalDeathsNum))
            totalDeathsLabel.text = formattedNumber
        } else {
            totalDeathsLabel.text = unknown
        }
        
        if let totalRecoveryNum = Int(data.data[.totalRecoveries]?.description ?? unknown) {
            let formattedNumber = formater.string(from: NSNumber(value: totalRecoveryNum))
            totalRecoveryLabel.text = formattedNumber
        } else {
            totalRecoveryLabel.text = unknown
        }
        
        if let totalTestsNum = Int(data.data[.totalTests]?.description ?? unknown) {
            let formattedNumber = formater.string(from: NSNumber(value: totalTestsNum))
            totalTestsLabel.text = formattedNumber
        } else {
            totalTestsLabel.text = unknown
        }
        
    }

}
