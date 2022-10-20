//
//  NewTaskViewController.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 14.10.2022.
//

import UIKit

protocol NewTaskDisplaying {
    func displayAlert(alertMessage: ToDoMissionModel.Alert, isEmpty: Bool)
}
class NewTaskViewController: UIViewController {
    var selectedDay: String = UserDefaults.standard.string(forKey: "selectedDay") ?? "friday"
    var newTaskInteractor: NewTaskInteracting?
    
    
    @IBOutlet weak var taskTextView: UITextView!
    
    @IBAction func saveTaskPressed(_ sender: UIButton) {
        newTaskInteractor?.requestSaveTask(task: taskTextView.text ?? "Error", day: selectedDay)
        
        
    }
    
    @IBAction func returnPressed() {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var newTaskPresenter: NewTaskPresenting = NewTaskPresentor()
        newTaskInteractor = NewTaskInteractor()
        newTaskInteractor?.newTaskPresenter = newTaskPresenter
        newTaskPresenter.newTaskViewController = self
        
        taskTextView.layer.cornerRadius = 15
        taskTextView.becomeFirstResponder()
        
    }
    
}
extension NewTaskViewController: NewTaskDisplaying {
    func displayAlert(alertMessage: ToDoMissionModel.Alert, isEmpty: Bool) {
        //Display the alert message gotten from the presenter
        let dialogMessage = UIAlertController(title: alertMessage.title, message: alertMessage.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if isEmpty == false {
                self.dismiss(animated: true)
            }
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}




