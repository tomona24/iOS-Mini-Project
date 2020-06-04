//
//  MainTableViewController.swift
//  Mini Project
//
//  Created by Leandro Prado, Cayo Mesquita, Tomona Sako on 2020-05-26.
//  Copyright © 2020 Leandro Prado, Cayo Mesquita, Tomona Sako. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    weak var delegate: MainTableViewController?
    var dataCollection: [MainData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UITextView.init()
        title.text = "Covid-19 Cases"
        title.layer.backgroundColor = .none
        title.font = UIFont.systemFont(ofSize: 30)
        
        self.navigationItem.titleView = title
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 126.0 / 255.0, green: 164.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = .white

    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCollection.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataCollection[indexPath.row]
        var cellIdentifier: String
        switch data.level {
        case 1:
            cellIdentifier = "CountryCell"
        case 2:
            cellIdentifier = "ProvinceCell"
        case 3:
            cellIdentifier = "RegionCell"
        default:
            cellIdentifier = "CountryCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DataTableViewCell
        
        // Configure the cell...
        cell.label?.text = data.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue", let destVC = segue.destination as? DetailsTableViewController, let indexPath = sender as? IndexPath {
            destVC.data = dataCollection[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataCollection[indexPath.row]
        
        if data.isExpandable {
            if data.isExpanded {
                let numRows = setNotExpandedRecursivelly(data)
                let indexRow = indexPath.row + 1
                var indexes:[IndexPath] = []
                for index in 1..<numRows {
                    dataCollection.remove(at: indexRow)
                    indexes.append(IndexPath.init(row: indexPath.row + index, section: 0))
                }
                
                tableView.deleteRows(at: indexes, with: .automatic)
            } else {
                data.isExpanded = true
                for index in 0..<data.subItems!.count{
                    let child = data.subItems![index]
                    child.isHidden = false
                    child.level = data.level + 1
                    let newIndexRow = indexPath.row + index + 1
                    dataCollection.insert(child, at: newIndexRow)                
                    tableView.insertRows(at: [IndexPath.init(row: newIndexRow, section: 0)], with: .automatic)
                }
            }
        }
    }
    
    func setNotExpandedRecursivelly(_ data:MainData) -> Int {
        if data.isExpandable, data.isExpanded {
            data.isExpanded = false
            var sum = 0
            for child in data.subItems! {
                sum += setNotExpandedRecursivelly(child)
            }
            return 1 + sum
        }
        return 1
    }
    
    
}
