//
//  AlertsPayload.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 30/06/25.
//


struct PreferenceItem {
    let title: String
    let status: Int?
    var children: [PreferenceItem]?
//    let subTitle: String?
    
    init(title: String, status: Int? = nil, children: [PreferenceItem]? = nil) {
        self.title = title
        self.status = status
        self.children = children
//        self.subTitle = subTitle
    }
}
