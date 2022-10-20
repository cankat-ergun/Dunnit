//
//  Interactor.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 12.10.2022.
//

import Foundation
import UIKit

protocol MainInteracting {
    func requestDays(request: ToDoMissionModel.Day.Request)
    var presentor: MainPresenting? {get set}
    func requestTasks(request: ToDoMissionModel.Task.Request)
    func requestDelete(request: ToDoMissionModel.Data.Request)
}

class MainInteractor: MainInteracting {
    var selectedDay: String = ""
    
    func requestTasks(request: ToDoMissionModel.Task.Request) {
        UserDefaults.standard.set(request.day, forKey: "selectedDay")
        let taskDict = UserDefaults.standard.object(forKey: "TaskDict") as? [String : [String]]
        let tasksForDay = taskDict?[request.day] ?? []
        presentor?.presentTasks(response: .init(tasks: tasksForDay, selectedDay: request.day))
    }
    var presentor: MainPresenting?
    
    func requestDays(request: ToDoMissionModel.Day.Request) {
        let daysOfTheWeek = UserDefaults.standard.object(forKey: "daysOfTheWeek") as? [String] ?? []
        presentor?.presentDays(response: .init(days: daysOfTheWeek))
    }
    
    func requestDelete(request: ToDoMissionModel.Data.Request){
        var data = UserDefaults.standard.object(forKey: "TaskDict") as? [String : [String]]
        do {
            var newData = data?[request.day]?.remove(at: request.indexPath.row)
            let taskArray = data?[request.day] ?? []
            //print("the item at \(request.indexPath.row) has been removed")
            UserDefaults.standard.set(data, forKey: "TaskDict")
            presentor?.presentDelete(response: .init(isSuccess: true, tasks: taskArray, selectedDay: request.day))
            
        } catch {
            print(error.localizedDescription)
            presentor?.presentDelete(response: .init(isSuccess: false, tasks: data?[request.day] ?? [], selectedDay: request.day))

        }
        
        
        
    }
    
}

