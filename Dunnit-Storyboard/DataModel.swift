//
//  DataModel.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 12.10.2022.
//

import Foundation

struct ToDoMissionModel {
    struct Day {
        struct Request: Codable {
            
        }
        struct Response: Codable {
            let days: [String]
        }
        struct ViewModel: Codable {
            let days: [String]
            
        }
    }
    struct Task {
        struct Request: Codable {
            let day: String
        }
        struct Response: Codable {
            let tasks: [String]
            let selectedDay: String
        }
        struct ViewModel: Codable {
            let tasks: [String]
            let selectedDay: String
            
        }
    }
    struct Data: Codable {
        
        var data: [String: [String]]
        struct Request: Codable {
            let day: String
            let indexPath: IndexPath
        }
        struct Response: Codable {
            let isSuccess: Bool
            let tasks: [String]
            let selectedDay: String
        }
    }
    struct Alert {
        var title: String
        var message: String
    }
}
