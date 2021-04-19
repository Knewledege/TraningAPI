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
