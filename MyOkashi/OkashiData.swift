//
//  OkashiData.swift
//  MyOkashi
//
//  Created by 習田武志 on 2022/07/09.
//

import Foundation

// お菓子データ検索用クラス
class OkashiData: ObservableObject {
    
    // Web API検索用メソッド　第一引数：keyword 検索したいワード
    func searchOkashi(keyword: String) async {
        // デバックエリアに出力
        print(keyword)
    }
}
