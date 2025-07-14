//
//  ViewController.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 30/06/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var alertSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainTableHeight: UITableView!
    
    let viewModel = PreferenceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.viewModel.loadData()
        self.viewModel.switchStatement(0)
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ParentTableViewCell", bundle: nil), forCellReuseIdentifier: "ParentTableViewCell")
    }
    
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        viewModel.switchStatement(sender.selectedSegmentIndex)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParentTableViewCell", for: indexPath) as! ParentTableViewCell
        let model = viewModel.parent[indexPath.row]
        cell.updateCell(model)
        cell.onHeightChange = { [weak tableView] in
            guard let tableView = tableView else { return }
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.toggleParent(indexPath.row)
        self.tableView.reloadData()
    }
}
