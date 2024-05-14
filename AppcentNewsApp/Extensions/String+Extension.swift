//
//  StringExtension.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 13.05.2024.
//

import Foundation

// String'den Date'e dönüşüm için extension
extension String {
    func toDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        return formatter.date(from: self)
    }
}
