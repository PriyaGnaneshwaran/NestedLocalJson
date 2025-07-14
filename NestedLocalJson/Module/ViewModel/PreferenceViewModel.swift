//
//  PreferenceViewModel.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 02/07/25.
//
import UIKit
import Foundation

class PreferenceViewModel {
    
    private(set) var parent: [PreferenceItem] = []
    private(set) var rawReferanceData: [String:Any] = [:]
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "alerts", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
              let pref = json["preference"] as? [String:Any] else {
            return
        }
        self.rawReferanceData = pref
        self.switchStatement(0)
    }
    
    func switchStatement(_ index: Int) {
        let index = (index == 0) ? "Alert Type" : "Preferences"
        guard let dict = rawReferanceData[index] as? [String:Any] else {
            self.parent =  []
            return
        }
        self.parent = parse(dict)
    }
    
    func toggleParent(_ i: Int) {
        self.parent[i].isExpanded.toggle()
    }
    
    func parse(_ dict: [String:Any], _ level: Int = 0) -> [PreferenceItem] {
        var items: [PreferenceItem] = []
        for (key,value) in dict {
            guard  key != "status" ,  let childDict = value as? [String:Any] else {
                continue
            }
            let status = childDict["status"] as? Int ?? 0
            let children = parse(childDict, level + 1)
            items.append(PreferenceItem(title: key, status: status, children: children))
            
        }
        return items
    }
}
    
