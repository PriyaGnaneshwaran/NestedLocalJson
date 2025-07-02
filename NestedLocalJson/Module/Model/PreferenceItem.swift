//
//  AlertsPayload.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 30/06/25.
//


class PrefRow {
    var title: String
    var level: Int
    var status: Int
    var children: [PrefRow]
    var isExpanded: Bool

    init(title: String, level: Int, status: Int, children: [PrefRow] = [], isExpanded: Bool = false) {
        self.title = title
        self.level = level
        self.status = status
        self.children = children
        self.isExpanded = isExpanded
    }
}
