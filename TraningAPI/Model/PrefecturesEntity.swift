//
//  Prefectures.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import RealmSwift


class Prefectures: Object, Codable {
    @objc dynamic var name_ja:String = ""
    @objc dynamic var population:Int = 0
    @objc dynamic var cases:Int = 0
    @objc dynamic var deaths:Int = 0
    @objc dynamic var pcr:Int = 0
    @objc dynamic var hospitalize:Int = 0
    @objc dynamic var severe:Int = 0
    @objc dynamic var discharge:Int = 0
    @objc dynamic var symptom_confirming:Int = 0
    //リレーショナルにした
    @objc dynamic var last_updated:LastUpdated? = LastUpdated()


    var updated:Date = Date()
    enum CodingKeys: String, CodingKey {
           case name_ja
           case population
           case cases
           case deaths
           case pcr
           case hospitalize
           case severe
           case discharge
           case symptom_confirming
           case last_updated
    }
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name_ja = try container.decode(String.self, forKey: .name_ja)
        population = try container.decode(Int.self, forKey: .population)
        cases = try container.decode(Int.self, forKey: .cases)
        deaths = try container.decode(Int.self, forKey: .deaths)
        pcr = try container.decode(Int.self, forKey: .pcr)
        hospitalize = try container.decode(Int.self, forKey: .hospitalize)
        severe = try container.decode(Int.self, forKey: .severe)
        discharge = try container.decode(Int.self, forKey: .discharge)
        symptom_confirming = try container.decode(Int.self, forKey: .symptom_confirming)
        last_updated = try container.decode(LastUpdated.self, forKey: .last_updated)
//        super.init() なくても大丈夫
    }
    
    /// Fatal error: Use of unimplemented initializer 'init()' for class 'TraningAPI.Prefectures'
    ///上記エラーが発生する
    required override init()
    {
        super.init()
    }
}

class LastUpdated: Object, Codable{
    @objc dynamic var cases_date:Int = 0
    @objc dynamic var deaths_date:Int = 0
    @objc dynamic var pcr_date:Int = 0
    @objc dynamic var hospitalize_date:Int = 0
    @objc dynamic var severe_date:Int = 0
    @objc dynamic var discharge_date:Int = 0
    @objc dynamic var symptom_confirming_date:Int = 0
}


class DecodePrefectures{
    var prefectures: [Prefectures]?
    init(data:Data){
        do{
            self.prefectures = try JSONDecoder().decode([Prefectures].self, from: data)
        }catch{
//            prefectures = nil
            print("デコードできませんでした")
        }
    }
}

class Details{
    static func DetailsToArray(prefectures: Prefectures) -> [[String]]{
        var details: [[String]] = [[]]
        details = [
            ["人口", prefectures.population.description],
            ["感染者数", prefectures.cases.description, prefectures.last_updated?.cases_date.description ?? "0"],
            ["死者数", prefectures.deaths.description, prefectures.last_updated?.deaths_date.description ?? "0"],
            ["PCR検査数", prefectures.pcr.description, prefectures.last_updated?.pcr_date.description ?? "0"],
            ["入院者数", prefectures.hospitalize.description, prefectures.last_updated?.hospitalize_date.description ?? "0"],
            ["重症者数", prefectures.severe.description, prefectures.last_updated?.severe_date.description ?? "0"],
            ["退院者数", prefectures.discharge.description, prefectures.last_updated?.discharge_date.description ?? "0"],
            ["自覚症状者数", prefectures.symptom_confirming.description, prefectures.last_updated?.symptom_confirming_date.description ?? "0"] ]
        return details
    }
}
