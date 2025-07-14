//
//  AlertsPayload.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 30/06/25.
//

import Foundation

class PreferenceItem {
    var title: String
    var status: Int
    var children: [PreferenceItem]
    var isExpanded: Bool 
    
    init(title: String, status: Int, children: [PreferenceItem], isExpanded: Bool = false) {
        self.title = title
        self.status = status
        self.children = children
        self.isExpanded = isExpanded
    }
}
