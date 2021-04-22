//
//  Prefectures.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import RealmSwift
import PromiseKit

//    MARK: - 都道府県情報テーブル
class Prefectures: Object, Codable {
    @objc dynamic var id:Int = 0
    @objc dynamic var name_ja:String = ""
    @objc dynamic var population:Int = 0
    @objc dynamic var cases:Int = 0
    @objc dynamic var deaths:Int = 0
    @objc dynamic var pcr:Int = 0
    @objc dynamic var hospitalize:Int = 0
    @objc dynamic var severe:Int = 0
    @objc dynamic var discharge:Int = 0
    @objc dynamic var symptom_confirming:Int = 0
    //更新日のデータがネストだったため、リレーショナルにした
    @objc dynamic var last_updated:LastUpdated? = LastUpdated()

    //最終更新日時がAPIのレスポンスに含まれていないためこちらで生成
    @objc dynamic var updated:Date = Date()
    enum CodingKeys: String, CodingKey {
        case id
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
        id = try container.decode(Int.self, forKey: .id)
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
        super.init()
    }
    
    //テーブルのプライマリキーを指定
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    /// Fatal error: Use of unimplemented initializer 'init()' for class 'TraningAPI.Prefectures'
    ///上記エラーが発生する
    required override init()
    {
        super.init()
    }
}
//jsonがネストされていた更新日部分のテーブル
//    MARK: - 更新日テーブル
//    jsonがネストされていた更新日部分のテーブル
class LastUpdated: Object, Codable{
    @objc dynamic var cases_date:Int = 0
    @objc dynamic var deaths_date:Int = 0
    @objc dynamic var pcr_date:Int = 0
    @objc dynamic var hospitalize_date:Int = 0
    @objc dynamic var severe_date:Int = 0
    @objc dynamic var discharge_date:Int = 0
    @objc dynamic var symptom_confirming_date:Int = 0
}

//    MARK: - Jsonデータを復号
class DecodePrefectures{
    static func jsonDecode(data:Data) -> Promise<[Prefectures]>{
        var result: [Prefectures]
        let (promise, resolver) = Promise<[Prefectures]>.pending()
        do{
            result = try JSONDecoder().decode([Prefectures].self, from: data)
            resolver.fulfill(result)
        }catch{
            resolver.reject(APIError.decodeError)
            print("デコードできませんでした")
        }
        return promise
    }
    deinit {
        print("decodeprefectures deinit")
    }
}

//    MARK: -PrefecturesをViewで扱いやすいように配列に変換
class Details{
    static func detailsToArray(prefectures: Prefectures) -> [[String]]{
        var details: [[String]] = [[]]
        details = [
            [DetailsConst.POPULATION, prefectures.population.description],
            [DetailsConst.ITEM_NAME,DetailsConst.PERSONS,DetailsConst.LAST_UPDATE],
            [DetailsConst.CASES, prefectures.cases.description, prefectures.last_updated?.cases_date.description ?? "0"],
            [DetailsConst.DEATHS, prefectures.deaths.description, prefectures.last_updated?.deaths_date.description ?? "0"],
            [DetailsConst.PCR, prefectures.pcr.description, prefectures.last_updated?.pcr_date.description ?? "0"],
            [DetailsConst.HOSPITALIZE, prefectures.hospitalize.description, prefectures.last_updated?.hospitalize_date.description ?? "0"],
            [DetailsConst.SEVERE, prefectures.severe.description, prefectures.last_updated?.severe_date.description ?? "0"],
            [DetailsConst.DISCHARGE, prefectures.discharge.description, prefectures.last_updated?.discharge_date.description ?? "0"],
            [DetailsConst.SYMPTOM_CONFIRMING, prefectures.symptom_confirming.description, prefectures.last_updated?.symptom_confirming_date.description ?? "0"] ]
        return details
    }
}

//    MARK: -定数クラス
final class DetailsConst{
    public static let ITEM_NAME = "項目"
    public static let PERSONS = "人数"
    public static let LAST_UPDATE = "最終更新日"
    public static let POPULATION = "人口"
    public static let CASES = "感染者数"
    public static let DEATHS = "死者数"
    public static let PCR = "PCR検査数"
    public static let HOSPITALIZE = "入院者数"
    public static let SEVERE = "重症者数"
    public static let DISCHARGE = "退院者数"
    public static let SYMPTOM_CONFIRMING = "自覚症状者数"
}
