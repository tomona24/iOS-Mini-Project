//
//  LoadingViewController.swift
//  Mini Project
//
//  Created by Tomona Sako on 2020/06/01.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet var indicator: UIActivityIndicatorView!
    var loadedCollectionData: [MainData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating() //start Loading
        indicator.style = .large //setting size
        indicator.hidesWhenStopped = true //when load stops, hide the indicator
        indicator.color = .systemGreen //set the color
        // Do any additional setup after loading the view.
        fetchData()
//        fetchFake()
    }

    @IBAction func goNextView(_ sender: Any) {
            self.performSegue(withIdentifier: "loadedJSON", sender: nil)
    }
    
    
        fileprivate func fetchInfo(completion: @escaping () -> Void) {
            let baseURL = URL(string: "https://enafibogee2zom0.m.pipedream.net")!
            let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                // TODO set the dataCollection
                let decoder = JSONDecoder()

                if let data = data {
                    var collection: [DataJson]
                    do {
                        collection = try decoder.decode([DataJson].self, from: data)
                    } catch {
                        print(error)
                        return
                    }
                    for item in collection {
                        self.loadedCollectionData.append(MainData.init(from: item))
                    }
                    completion()
                }

            }
            // 3. resume
            task.resume()
        }
        
        func fetchData() -> Void {
    
            fetchInfo {
                // TODO update viewtable
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                    self.performSegue(withIdentifier: "loadedJSON", sender: nil)
                }
            }
            }

    func fetchFake(){
        let bc1 = MainData.init(title: "Coast", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])
        let bc2 = MainData.init(title: "Fraser", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])


        let bc = MainData.init(title: "British Columbia", data: [.totalCases: 1, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [bc1, bc2])
        let al = MainData.init(title: "Alberta", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])
        let on = MainData.init(title: "Ontario", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [])

        let canada = MainData.init(title: "Canada", data: [.totalCases: 30, .totalDeaths: 10, .activeCases: 12, .totalRecoveries: 6, .totalTests: 40], subItems: [bc, al, on], isHidden: false)

        loadedCollectionData.append(canada)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navC = segue.destination as! UINavigationController
        let nextVC = navC.topViewController as! MainTableViewController
        if segue.identifier == "loadedJSON" {
            nextVC.dataCollection = loadedCollectionData
        }
    }
    
}
