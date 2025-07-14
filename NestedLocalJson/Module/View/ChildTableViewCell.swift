//
//  ChildTableViewCell.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 02/07/25.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var childHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    let selectedImage   = UIImage(systemName:"checkmark.circle.fill")
    let unselectedImage = UIImage(systemName: "checkmark.circle")
    
    var children: [PreferenceItem] = []
    let viewModel = PreferenceViewModel()
    var sizeObserver: NSKeyValueObservation?
    
    var onToggleChild: (() -> Void)?
    
    private var item: PreferenceItem!
        
    func configure(_ item: PreferenceItem) {
        self.item = item
        lblTitle.text = item.title
        let imageName = item.isExpanded ? selectedImage : unselectedImage
        img.image = imageName
        children = item.isExpanded && !item.children.isEmpty ? item.children : []
        tableView.isHidden = children.isEmpty
        tableView.reloadData()
        tableView.layoutIfNeeded()
        childHeight.constant = tableView.contentSize.height
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTableView()
        sizeObserver = self.tableView.observe(\.contentSize, options: [.new]) {  [ weak self ] tableView, change in
            guard let self = self , let newValue = change.newValue else { return }
            self.childHeight.constant = newValue.height
            self.onToggleChild?()
        }
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: "GrandChildTableViewCell", bundle: nil), forCellReuseIdentifier: "GrandChildTableViewCell")
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ChildTableViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("grand Child tableView numberOfRowsInSection called, count: \(children.count)")
        return children.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrandChildTableViewCell", for: indexPath) as! GrandChildTableViewCell
        let child = children[indexPath.row]
        cell.configure(child)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard indexPath.row < children.count else { return }
        children[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        onToggleChild?()
    }
}
