//
//  Date+Utils.swift
//  AppStoreSearch
//
//  Created by 도미닉 on 7/6/25.
//

import Foundation

extension Date {
    func localizedRelativeTime() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if let yearDifference = calendar.dateComponents([.year], from: self, to: now).year, yearDifference > 0 {
            return "\(yearDifference)년 전"
        }

        if let monthDifference = calendar.dateComponents([.month], from: self, to: now).month, monthDifference > 0 {
            return "\(monthDifference)개월 전"
        }

        if let dayDifference = calendar.dateComponents([.day], from: self, to: now).day {
            if dayDifference >= 7 {
                let weeks = dayDifference / 7
                return "\(weeks)주 전"
            }
        }
        
        if let dayDifference = calendar.dateComponents([.day], from: self, to: now).day {
            if dayDifference == 0 {
                return "오늘"
            } else if dayDifference == 1 {
                return "어제"
            } else {
                return "\(dayDifference)일 전"
            }
        }
        
        if let hourDifference = calendar.dateComponents([.hour], from: self, to: now).hour, hourDifference > 0 {
            return "\(hourDifference)시간 전"
        }
        if let minuteDifference = calendar.dateComponents([.minute], from: self, to: now).minute, minuteDifference > 0 {
            return "\(minuteDifference)분 전"
        }
        if let secondDifference = calendar.dateComponents([.second], from: self, to: now).second, secondDifference > 0 {
            return "\(secondDifference)초 전"
        }

        return "방금 전"
    }
}
