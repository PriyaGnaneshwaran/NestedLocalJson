//
//  ViewController.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 30/06/25.
//

import UIKit

class ViewController: UIViewController {
    
    var currentRows: [(level: Int, title: String)] = []
    
    @IBOutlet weak var alertSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = PreferenceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ParentTableViewCell", bundle: nil), forCellReuseIdentifier: "ParentTableViewCell")
        self.tableView.register(UINib(nibName: "ChildTableViewCell", bundle: nil), forCellReuseIdentifier: "ChildTableViewCell")
        self.tableView.register(UINib(nibName: "GrandChildTableViewCell", bundle: nil), forCellReuseIdentifier: "GrandChildTableViewCell")
        
        viewModel.loadData()
        viewModel.loadPreferenceType(index: alertSegment.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        
    }
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        viewModel.loadPreferenceType(index: sender.selectedSegmentIndex)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.flatData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.flatData[indexPath.row]
        let level = data.level
        let item = data.item
        
        switch level {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ParentTableViewCell", for: indexPath) as! ParentTableViewCell
            cell.lblTitle.text = item.title
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChildTableViewCell", for: indexPath) as! ChildTableViewCell
            cell.lblTitle.text = item.title
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GrandChildTableViewCell", for: indexPath) as! GrandChildTableViewCell
            cell.lblTitle.text = item.title
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
