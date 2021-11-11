//
//  Playmate++Bundel.swift
//  Runner
//
//  Created by 정명주 on 2021/11/11.
//

import Foundation

extension Bundle {
    var MapApiKey: String {
        guard let file = self.path(forResource: "KeyInfo", ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["MAP_API_KEY"] as? String else { fatalError("KeyInfo.plist에 MAP_API_KEY를 작성해주세요")}
        return key;
    }
}
