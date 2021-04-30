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
import GRDB

/*
//    MARK: - 都道府県情報テーブル
class Prefectures: Object, Codable {
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var population:Int = 0
    @objc dynamic var cases:Int = 0
    @objc dynamic var deaths:Int = 0
    @objc dynamic var pcr:Int = 0
    @objc dynamic var hospitalize:Int = 0
    @objc dynamic var severe:Int = 0
    @objc dynamic var discharge:Int = 0
    @objc dynamic var symptomConfirming:Int = 0
    //更新日のデータがネストだったため、リレーショナルにした
    @objc dynamic var lastUpdated:LastUpdated? = LastUpdated()

    //最終更新日時がAPIのレスポンスに含まれていないためこちらで生成
    @objc dynamic var updated:Date = Date()
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name_ja"
        case population
        case cases
        case deaths
        case pcr
        case hospitalize
        case severe
        case discharge
        case symptomConfirming = "symptom_confirming"
        case lastUpdated = "last_updated"
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        population = try container.decode(Int.self, forKey: .population)
        cases = try container.decode(Int.self, forKey: .cases)
        deaths = try container.decode(Int.self, forKey: .deaths)
        pcr = try container.decode(Int.self, forKey: .pcr)
        hospitalize = try container.decode(Int.self, forKey: .hospitalize)
        severe = try container.decode(Int.self, forKey: .severe)
        discharge = try container.decode(Int.self, forKey: .discharge)
        symptomConfirming = try container.decode(Int.self, forKey: .symptomConfirming)
        lastUpdated = try container.decode(LastUpdated.self, forKey: .lastUpdated)
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
    @objc dynamic var casesDate:Int = 0
    @objc dynamic var deathsDate:Int = 0
    @objc dynamic var pcrDate:Int = 0
    @objc dynamic var hospitalizeDate:Int = 0
    @objc dynamic var severeDate:Int = 0
    @objc dynamic var dischargeDate:Int = 0
    @objc dynamic var symptomConfirmingDate:Int = 0
    enum CodingKeys: String, CodingKey {
        case casesDate = "cases_date"
        case deathsDate = "deaths_date"
        case pcrDate = "pcr_date"
        case hospitalizeDate = "hospitalize_date"
        case severeDate = "severe_date"
        case dischargeDate = "discharge_date"
        case symptomConfirmingDate = "symptom_confirming_date"
    }
}
*/
struct Prefectures : Codable, FetchableRecord, PersistableRecord  {
    var id:Int
    var name:String
    var population:Int
    var cases:Int
    var deaths:Int
    var pcr:Int
    var hospitalize:Int
    var severe:Int
    var discharge:Int
    var symptomConfirming:Int
    var lastUpdated:LastUpdate
    static var databaseTableName: String {
        return "prefectures"  // テーブル名
    }

//    static func create(_ db: Database) throws {
//        try db.create(table: databaseTableName, body: { (t: TableDefinition) in
//            t.column("id", .integer).primaryKey(onConflict: .replace, autoincrement: false)
//            t.column("name", .text).notNull()
//            t.column("age", .integer).notNull()
//            t.column("lastUpdate", .integer).notNull()
//        })
//    }
    var updated:Date = Date()
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name_ja"
        case population
        case cases
        case deaths
        case pcr
        case hospitalize
        case severe
        case discharge
        case symptomConfirming = "symptom_confirming"
        case lastUpdated = "last_updated"
    }
}
struct LastUpdate : Codable {
    var casesDate:Int
    var deathsDate:Int
    var pcrDate:Int
    var hospitalizeDate:Int
    var severeDate:Int
    var dischargeDate:Int
    var symptomConfirmingDate:Int
    enum CodingKeys: String, CodingKey {
        case casesDate = "cases_date"
        case deathsDate = "deaths_date"
        case pcrDate = "pcr_date"
        case hospitalizeDate = "hospitalize_date"
        case severeDate = "severe_date"
        case dischargeDate = "discharge_date"
        case symptomConfirmingDate = "symptom_confirming_date"
    }
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
class RegionModel{

    static let regions: [Region] = [
        .hokkaidou,
        .tohoku,
        .kanto,
        .chubu,
        .kinki,
        .chugoku,
        .shikoku,
        .kyushu
    ]
    static var nameIsHidden: [Bool] = [false,false,false,false,false,false,false,false]
    enum Region: Int {
        case hokkaidou
        case tohoku
        case kanto
        case chubu
        case kinki
        case chugoku
        case shikoku
        case kyushu

    //    var id: Int { return self.rawValue + 1 }

        var name: String {
            switch self {
            case .hokkaidou: return "北海道"
            case .tohoku:   return "東北"
            case .kanto:    return "関東"
            case .chubu:    return "中部"
            case .kinki:    return "近畿"
            case .chugoku:  return "中国"
            case .shikoku:  return "四国"
            case .kyushu:   return "九州"
            }
        }
        var prefecturesID: [Int] {
            switch self {
            case .hokkaidou: return [0]
            case .tohoku: return [1,2,3,4,5,6]
            case .kanto: return [7,8,9,10,11,12,13]
            case .chubu: return [14,15,16,17,18,19,20,21,22]
            case .kinki: return [23,24,25,26,27,28]
            case .chugoku: return [29,30,31,32,33,34]
            case .shikoku: return [25,36,37,38]
            case .kyushu: return [39,40,41,42,43,44,45,46]
            }
        }
        
//        func getNameIsHidden(isHidden: Bool) -> Bool{
//
//        }
    }
}
//    MARK: -PrefecturesをViewで扱いやすいように配列に変換
class Details{
    static func detailsToArray(prefectures: Prefectures) -> [[String]]{
        var details: [[String]] = [[]]
        details = [
            [DetailsConst.CASES, prefectures.cases.description, prefectures.lastUpdated.casesDate.description ?? "0"],
            [DetailsConst.DEATHS, prefectures.deaths.description, prefectures.lastUpdated.deathsDate.description ?? "0"],
            [DetailsConst.PCR, prefectures.pcr.description, prefectures.lastUpdated.pcrDate.description ?? "0"],
            [DetailsConst.HOSPITALIZE, prefectures.hospitalize.description, prefectures.lastUpdated.hospitalizeDate.description ?? "0"],
            [DetailsConst.SEVERE, prefectures.severe.description, prefectures.lastUpdated.severeDate.description ?? "0"],
            [DetailsConst.DISCHARGE, prefectures.discharge.description, prefectures.lastUpdated.dischargeDate.description ?? "0"],
            [DetailsConst.SYMPTOMCONFIRMING, prefectures.symptomConfirming.description, prefectures.lastUpdated.symptomConfirmingDate.description ?? "0"] ]
        return details
    }
}

//    MARK: -定数クラス
final class DetailsConst{
    public static let ITEMNAME = "項目"
    public static let PERSONS = "人数"
    public static let LASTUPDATE = "最終更新日"
    public static let POPULATION = "人口："
    public static let CASES = "感染者数"
    public static let DEATHS = "死者数"
    public static let PCR = "PCR検査数"
    public static let HOSPITALIZE = "入院者数"
    public static let SEVERE = "重症者数"
    public static let DISCHARGE = "退院者数"
    public static let SYMPTOMCONFIRMING = "自覚症状者数"
}
