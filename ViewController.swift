//
//  ViewController.swift
//  artBook
//
//  Created by Erhan Acisu on 22.09.2019.
//  Copyright © 2019 Emirhan Acisu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
       
    }
    
    @objc func addButtonClicked()
    {
        performSegue(withIdentifier: "toDetails", sender: nil)
    }


}

