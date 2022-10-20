//
//  ViewController.swift
//  Dunnit-Storyboard
//
//  Created by Argun Cankat Ergun on 11.10.2022.
//

import UIKit
// Ilk çalıştırırken Line 93-107 arasındaki fonksiyon ile line 62'yi uncommentleyip bir kere çalıştırınız.
// Daha sonra tekrardan commentleyip çalıştırmak gerekir.

protocol ViewControllerDisplaying {
    func displayDays(viewModel: ToDoMissionModel.Day.ViewModel)
    func displayTasks(viewModel: ToDoMissionModel.Task.ViewModel)
}

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
     
    var dayOfTheWeek: String = ""
    var collectionViewDataSource = [String]()
    var tableViewDataSource = [String]()
    var interactor: MainInteracting?
    var selectedDay: String = "monday"
    @IBOutlet weak var toDoTableView: UITableView!
    
    @IBAction func NewTaskButtonPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "newTaskViewController") as! NewTaskViewController
        vc.modalPresentationStyle = .fullScreen 
        present(vc, animated: true)
         
    }
    
    @IBOutlet weak var colDays: UICollectionView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDoTableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.tableViewCellLabel.text = tableViewDataSource[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            interactor?.requestDelete(request: .init(day: selectedDay, indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
//            interactor?.requestTasks(request: .init(day: selectedDay))
            tableView.endUpdates()
//         toDoTableView.reloadData()
        }
    }
        ///MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        cell.dayOfTheWeekLabel.text = collectionViewDataSource[indexPath.row]
        cell.layer.cornerRadius = 20
        if collectionViewDataSource[indexPath.row] == selectedDay {
            cell.backgroundColor = #colorLiteral(red: 0.6651846766, green: 1, blue: 0, alpha: 1)
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.6037771106, green: 0.8178697228, blue: 0.8323388696, alpha: 1)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.requestTasks(request: .init(day: collectionViewDataSource[indexPath.row]))
        
        
    }
  
    
//    func reloadData() {
//        var daysOfTheWeek: [String] = [
//            "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"
//        ]
//        var tasks: [String: [String]] = [
//            "monday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."],
//            "tuesday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."],
//            "wednesday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."],
//            "thursday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."],
//            "friday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."],
//            "saturday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."],
//            "sunday": ["Çöpü çıkar.", "Doktordan randevu al", "Çöp poşeti al."]
//        ]
//        UserDefaults.standard.set(tasks, forKey: "TaskDict")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.dataSource = self
        toDoTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        var presenter: MainPresenting = MainPresentor()
        interactor = MainInteractor()
        interactor?.presentor = presenter
        presenter.viewController = self
        interactor?.requestDays(request: .init())
        
        toDoTableView.layer.cornerRadius = 20
        toDoTableView.backgroundColor = #colorLiteral(red: 0.1033450738, green: 0.2621834874, blue: 0.2836567461, alpha: 1)
        
        colDays.backgroundColor = #colorLiteral(red: 0.6037771106, green: 0.8178697228, blue: 0.8323388696, alpha: 1)
        colDays.layer.cornerRadius = 10
            
        //reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toDoTableView.reloadData()
        interactor?.requestTasks(request: .init(day: selectedDay))
    }
}
extension MainViewController: ViewControllerDisplaying {
    func displayDays(viewModel: ToDoMissionModel.Day.ViewModel) {
        collectionViewDataSource = viewModel.days
        colDays.reloadData()
        interactor?.requestTasks(request: .init(day: "wednesday")) //uygulama açıldığında wednesday seçilsin.
    }
    func displayTasks(viewModel: ToDoMissionModel.Task.ViewModel) {
        tableViewDataSource = viewModel.tasks
        toDoTableView.reloadData()
        self.selectedDay = viewModel.selectedDay
        colDays.reloadData()
        
    }
    
    
}


