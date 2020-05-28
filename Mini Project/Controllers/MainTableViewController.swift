//
//  MainTableViewController.swift
//  Mini Project
//
//  Created by Leandro Prado on 2020-05-25.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    //    var dataCollection: [MainData] = []
    
    var dataCollection: [MainData] = []
    
    let baseURL = URL(string: "https://enafibogee2zom0.m.pipedream.net")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UITextView.init()
        title.text = "Covid-19 Cases 2"
        title.layer.backgroundColor = .none
        title.font = UIFont.systemFont(ofSize: 30)
        
        navigationItem.titleView = title
        
        fetchData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    fileprivate func fetchInfo(completion: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            // TODO set the dataCollection
            let decoder = JSONDecoder()
            
            if let data = data {
                var collection: [MainData]
                do {
                    collection = try decoder.decode([MainData].self, from: data)
                } catch {
                    print(error)
                    return
                }
                self.dataCollection = collection
                //            let json = data.description
                //            print(data)
                //            print(json)
                completion()
            }
            
        }
        //      indicator.startAnimating()
        // 3. resume
        task.resume()
    }
    
    func fetchData() -> Void {
        
        fetchInfo {
            // TODO update viewtable
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
//        fetchFake()
    }
    
    func fetchFake(){
        let bc1 = MainData.init(title: "Coast", data: [DataType.totalCases.rawValue: 30, DataType.totalDeaths.rawValue: 10, DataType.activeCases.rawValue: 12, DataType.totalRecoveries.rawValue: 6, DataType.totalTests.rawValue: 40], subItems: [])
        let bc2 = MainData.init(title: "Fraser", data: [DataType.totalCases.rawValue: 30, DataType.totalDeaths.rawValue: 10, DataType.activeCases.rawValue: 12, DataType.totalRecoveries.rawValue: 6, DataType.totalTests.rawValue: 40], subItems: [])
        
        
        let bc = MainData.init(title: "British Columbia", data: [DataType.totalCases.rawValue: 1, DataType.totalDeaths.rawValue: 10, DataType.activeCases.rawValue: 12, DataType.totalRecoveries.rawValue: 6, DataType.totalTests.rawValue: 40], subItems: [bc1, bc2])
        let al = MainData.init(title: "Alberta", data: [DataType.totalCases.rawValue: 30, DataType.totalDeaths.rawValue: 10, DataType.activeCases.rawValue: 12, DataType.totalRecoveries.rawValue: 6, DataType.totalTests.rawValue: 40], subItems: [])
        let on = MainData.init(title: "Ontario", data: [DataType.totalCases.rawValue: 30, DataType.totalDeaths.rawValue: 10, DataType.activeCases.rawValue: 12, DataType.totalRecoveries.rawValue: 6, DataType.totalTests.rawValue: 40], subItems: [])
        
        let canada = MainData.init(title: "Canada", data: [DataType.totalCases.rawValue: 30, DataType.totalDeaths.rawValue: 10, DataType.activeCases.rawValue: 12, DataType.totalRecoveries.rawValue: 6, DataType.totalTests.rawValue: 40], subItems: [bc, al, on], isHidden: false)
        
        dataCollection.append(canada)
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
//                let numRows = data.subItems!.count
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
