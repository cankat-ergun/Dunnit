//
//  NewTaskInteractor.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 15.10.2022.
//

import Foundation

protocol NewTaskInteracting {
    func requestSaveTask(task: String, day: String)
    var newTaskPresenter: NewTaskPresenting? {get set}
}
class NewTaskInteractor: NewTaskInteracting {
    var newTaskPresenter: NewTaskPresenting?
    
    
    func requestSaveTask(task: String, day: String) {
        if task.isEmpty == true {
            //Boş data girişi yapılamaz uyarısı. Dismisslemeyecek ekranı.
            print("Can't enter empty task")
            newTaskPresenter?.presentAlert(isSuccesful: false, isEmpty: true)
            
        } else {
            
            do {
                let existingTasks = UserDefaults.standard.object(forKey: "TaskDict")
                var existingTaskValues = existingTasks as? [String: [String]]
                existingTaskValues?[day]?.append(task)
                UserDefaults.standard.set(existingTaskValues, forKey: "TaskDict")
                newTaskPresenter?.presentAlert(isSuccesful: true, isEmpty: false)
                
            } catch {
                print(error.localizedDescription)
                newTaskPresenter?.presentAlert(isSuccesful: false, isEmpty: false)
            }
        }
    }
    
    
}

//    func displayAlert(isSuccessful: Bool) {
//
//        let dialogMessage = UIAlertController(title: "Success", message: "New Task Saved", preferredStyle: .alert)
//
//        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//            self.dismiss(animated: true, completion: nil)
//        })
//
//        dialogMessage.addAction(ok)
//
//        self.present(dialogMessage, animated: true, completion: nil)
//    }
//}

