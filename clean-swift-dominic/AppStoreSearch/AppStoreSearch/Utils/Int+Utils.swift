//
//  Int+Utils.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/6/25.
//

import Foundation

extension Int {
    func makeUserRatingCount() -> String {
        switch self {
        case let (count) where self > 10000:
            let double = Double(count) / 10000
            return "\(Int(round(double)))만"
        case let (count) where self > 1000:
            let double = Double(count) / 1000
            return "\(Int(round(double)))천"
        case let (count) where self > 100:
            let double = Double(count) / 100
            return "\(Int(round(double)))백"
        case let (count) where self > 10:
            let double = Double(count) / 10
            return "\(Int(round(double)))십"
        default:
            return "\(self)개"
        }
    }
}
