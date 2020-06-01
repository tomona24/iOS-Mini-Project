//
//  LoadingViewController.swift
//  Mini Project
//
//  Created by Leandro Prado on 2020-06-01.
//  Copyright © 2020 Leandro Prado. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

     @IBOutlet weak var indicator: UIActivityIndicatorView!
       
    override func viewDidLoad() {
           super.viewDidLoad()
           indicator.startAnimating() //start Loading
           indicator.style = .whiteLarge //setting size
           indicator.hidesWhenStopped = true //when load stops, hide the indicator
           indicator.color = .green //色設定
       }
    
       @IBAction func stop(_ sender: Any) {
           indicator.stopAnimating() //stop loading
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoadingSegue" {
            let destinationViewController = segue.destination as? MainTableViewController
            destinationViewController?.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
