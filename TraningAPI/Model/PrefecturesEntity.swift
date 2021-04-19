//
//  Prefectures.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
struct Prefectures: Codable {
    let name_ja:String
    let population:Int
    let cases:Int
    let deaths:Int
    let pcr:Int
    let hospitalize:Int
    let severe:Int
    let discharge:Int
    let symptom_confirming:Int
    let last_updated:LastUpdated

    struct LastUpdated: Codable{
        let cases_date:Int
        let deaths_date:Int
        let pcr_date:Int
        let hospitalize_date:Int
        let severe_date:Int
        let discharge_date:Int
        let symptom_confirming_date:Int
    }

}

class DecodePrefectures{
    var prefectures: [Prefectures]?
    init(data:Data){
        do{
            self.prefectures = try JSONDecoder().decode([Prefectures].self, from: data)
        }catch{
//            prefectures = nil
        }
    }
}

class Details{
    static func DetailsToArray(prefectures: Prefectures) -> [[String]]{
        var details: [[String]] = [[]]
        details = [
            ["人口", prefectures.population.description],
            ["感染者数", prefectures.cases.description, prefectures.last_updated.cases_date.description],
            ["死者数", prefectures.deaths.description, prefectures.last_updated.deaths_date.description],
            ["PCR検査数", prefectures.pcr.description, prefectures.last_updated.pcr_date.description],
            ["入院者数", prefectures.hospitalize.description, prefectures.last_updated.hospitalize_date.description],
            ["重症者数", prefectures.severe.description, prefectures.last_updated.severe_date.description],
            ["退院者数", prefectures.discharge.description, prefectures.last_updated.discharge_date.description],
            ["自覚症状者数", prefectures.symptom_confirming.description, prefectures.last_updated.symptom_confirming_date.description] ]
        return details
    }
}
