//
//  PreferenceViewModel.swift
//  NestedLocalJson
//
//  Created by Priya Gnaneshwaran on 02/07/25.
//
import UIKit
import Foundation

class PreferenceViewModel {
    
    var rawPreferenceData: [String: Any] = [:]
    var flatData: [(level: Int, item: PreferenceItem)] = []
    
    func loadData() {
        guard
            let path  = Bundle.main.path(forResource: "alerts", ofType: "json"),
            let data  = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let json  = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
            let pref  = json["preference"] as? NSDictionary
        else {
            print("Failed to load JSON")
            return
        }
        rawPreferenceData = pref as! [String : Any]
    }
    
    func loadPreferenceType(index: Int) {
        flatData.removeAll()
        
        let key = index == 0 ? "Alert Type" : "Preferences"
        guard let prefDict = rawPreferenceData[key] as? NSDictionary else { return }
        
        let children = parseOrderedDict(prefDict)
        flatData = flattenPreferenceItems(children)
    }
    
    func parseOrderedDict(_ dict: NSDictionary) -> [PreferenceItem] {
        var result: [PreferenceItem] = []
        
        for key in dict.allKeys {
            guard let keyStr = key as? String, keyStr != "status" else { continue }
            
            if let subDict = dict[keyStr] as? NSDictionary {
                let status   = subDict["status"] as? Int
                let children = parseOrderedDict(subDict)
                result.append(PreferenceItem(title: keyStr, status: status, children: children))
            }
        }
        return result
    }
    
    func flattenPreferenceItems(_ items: [PreferenceItem], level: Int = 0) -> [(level: Int, item: PreferenceItem)] {
        var out: [(Int, PreferenceItem)] = []
        for item in items {
            out.append((level, item))
            if let kids = item.children {
                out.append(contentsOf: flattenPreferenceItems(kids, level: level + 1))
            }
        }
        return out
    }
}
