//
//  Mission.swift
//  Moonshot
//
//  Created by Dmitry on 10.06.2021.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Appolo \(id)"
    }
    //отображение нужного изображение по номеру id
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
            if let launchDate = launchDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                return formatter.string(from: launchDate)
            } else {
                return "N/A"
            }
        }
}
