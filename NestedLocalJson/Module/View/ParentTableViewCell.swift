//
//  ParentTableViewCell.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 02/07/25.
//

import UIKit

class ParentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var parentHeight: NSLayoutConstraint!
    
    var children: [PreferenceItem] = []
    let viewModel = PreferenceViewModel()
    var parentItem: PreferenceItem?
    
    var sizeObserver: NSKeyValueObservation?
    var onHeightChange: (() -> Void)?
    
    let selectedImage   = UIImage(systemName: "checkmark.circle.fill")
    let unselectedImage = UIImage(systemName: "checkmark.circle")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTableView()
        sizeObserver = tableView.observe(\.contentSize, options: [.new]) { [weak self] tableView, change in
            guard let self = self, let newSize = change.newValue else { return }
            self.parentHeight.constant = newSize.height
            self.layoutIfNeeded()
            self.onHeightChange?()
        }
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "ChildTableViewCell", bundle: nil), forCellReuseIdentifier: "ChildTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func updateCell(_ item: PreferenceItem) {
        self.lblTitle.text = item.title
        let image = item.isExpanded ? selectedImage : unselectedImage
        self.img.image = image
        self.parentItem = item
        self.children = item.isExpanded ? item.children : []
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.parentHeight.constant = tableView.contentSize.height
    }
}

extension ParentTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildTableViewCell", for: indexPath) as! ChildTableViewCell
        let model = children[indexPath.row]
        cell.configure(model)
        cell.onToggleChild = { [weak self] in
            guard let self = self else { return }
            self.tableView.layoutIfNeeded()
            onHeightChange?()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        children[indexPath.row].isExpanded.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
