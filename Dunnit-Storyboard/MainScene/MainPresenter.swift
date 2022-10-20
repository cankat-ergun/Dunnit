//
//  MainPresenter.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 14.10.2022.
//

import Foundation

protocol MainPresenting {
    func presentDays(response: ToDoMissionModel.Day.Response)
    var viewController: MainViewController? {get set}
    func presentTasks(response: ToDoMissionModel.Task.Response)
    func presentDelete(response: ToDoMissionModel.Data.Response)
}

class MainPresentor: MainPresenting {
    func presentDelete(response: ToDoMissionModel.Data.Response) {
        // Success veya fail durumunda ekstra birşey ekleyecek olursam diye response.isSuccess diye aldım buraya.
        viewController?.displayTasks(viewModel: .init(tasks: response.tasks, selectedDay: response.selectedDay))
    }
    
   
    
    func presentTasks(response: ToDoMissionModel.Task.Response) {
        viewController?.displayTasks(viewModel: .init(tasks: response.tasks, selectedDay: response.selectedDay))

    }
    
    weak var viewController: MainViewController?
    func presentDays(response: ToDoMissionModel.Day.Response) {
        viewController?.displayDays(viewModel: .init(days: response.days))
    }
    

}

