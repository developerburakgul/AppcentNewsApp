//
//  DateExtension.swift
//  AppcentNewsApp
//
//  Created by Burak Gül on 13.05.2024.
//

import Foundation

extension Date {
    func toCustomString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
