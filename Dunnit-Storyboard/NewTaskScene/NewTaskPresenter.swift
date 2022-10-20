//
//  NewTaskPresenter.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 15.10.2022.
//

import Foundation
import UIKit

protocol NewTaskPresenting {
    func presentSavedTasks(completed: Bool, tasks: [String])
    var newTaskViewController: NewTaskViewController? {get set}
    func presentAlert(isSuccesful: Bool, isEmpty: Bool)
}
class NewTaskPresentor: NewTaskPresenting {
   
    
    func presentSavedTasks(completed: Bool, tasks: [String]) {
        
    }
    
    var newTaskViewController: NewTaskViewController?
    var alertModel: ToDoMissionModel.Alert? = .init(title: "", message: "")
    
    func presentAlert(isSuccesful: Bool, isEmpty: Bool) {
        if isEmpty == true {
            alertModel?.title = "Failed"
            alertModel?.message = "Write a task."
        }
        else if isSuccesful == true {
            alertModel?.title = "Success"
            alertModel?.message = "Saved your data succesfully"
        } else {
            alertModel?.title = "Failed"
            alertModel?.message = "There was a problem saving your data"
        }
        
        newTaskViewController?.displayAlert(alertMessage: alertModel ?? .init(title: "Server Issue", message: "Problem on the server side. Please try again soon."), isEmpty: isEmpty)

    }
}

