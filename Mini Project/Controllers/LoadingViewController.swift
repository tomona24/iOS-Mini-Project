//
//  LoadingViewController.swift
//  Mini Project
//
//  Created by Leandro Prado, Cayo Mesquita, Tomona Sako on 2020-05-26.
//  Copyright © 2020 Leandro Prado, Cayo Mesquita, Tomona Sako. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var loadedCollectionData: [MainData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating() //start Loading
        indicator.style = .large //setting size
        indicator.hidesWhenStopped = true //when load stops, hide the indicator
        indicator.color = UIColor(red: 126.0 / 255.0, green: 164.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        fetchData()
    }
    
    
    fileprivate func fetchInfo(completion: @escaping () -> Void) {
        let baseURL = URL(string: "https://enafibogee2zom0.m.pipedream.net")!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            // set the dataCollection
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
            // go to MainTableViewController
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.performSegue(withIdentifier: "LoadingSegue", sender: nil)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navC = segue.destination as! UINavigationController
        let nextVC = navC.topViewController as! MainTableViewController
        if segue.identifier == "LoadingSegue" {
            nextVC.dataCollection = loadedCollectionData
        }
    }
    
}

