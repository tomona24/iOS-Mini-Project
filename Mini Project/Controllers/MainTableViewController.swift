//
//  MainTableViewController.swift
//  Mini Project
//
//  Created by Leandro Prado on 2020-05-25.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var dataCollection: [MainData] = []
    
    var visibleList: [MainData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bc1 = MainData.init(title: "Coast", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])
        let bc2 = MainData.init(title: "Fraser", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])
        
        
        let bc = MainData.init(title: "British Columbia", data: [.totalCases: 1, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [bc1, bc2])
        let al = MainData.init(title: "Alberta", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])
        let on = MainData.init(title: "Ontario", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])

        let canada = MainData.init(title: "Canada", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [bc, al, on], isHidden: false)
        
        dataCollection.append(canada)
        visibleList.append(canada)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return visibleList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = visibleList[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue", let destVC = segue.destination as? DetailsTableViewController, let indexPath = sender as? IndexPath {
            destVC.data = visibleList[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = visibleList[indexPath.row]
        
        if data.isExpandable {
            if data.isExpanded {
                let numRows = data.subItems.count
                let indexRow = indexPath.row + 1
                var indexes:[IndexPath] = []
                for index in 1...numRows {
                    visibleList[indexRow].isExpanded = false
                    visibleList.remove(at: indexRow)
                    indexes.append(IndexPath.init(row: indexPath.row + index, section: 0))
                }
                
                tableView.deleteRows(at: indexes, with: .automatic)
            } else {
                for item in data.subItems {
                    item.isHidden = false
                    let newIndexRow = indexPath.row + 1
                    visibleList.insert(item, at: newIndexRow)
                
                    tableView.insertRows(at: [IndexPath.init(row: newIndexRow, section: 0)], with: .automatic)
                }
            }
            data.isExpanded = !data.isExpanded
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
