//
//  segmentVC.swift
//  coredatapractice
//
//  Created by Manthan Mittal on 15/12/2024.
//

import UIKit

class segmentVC: UIViewController {
    
    @IBOutlet weak var apitbl: UITableView!
    
    @IBOutlet weak var coredatatbl: UITableView!
    
    @IBOutlet weak var segmenttbl: UISegmentedControl!
    
    var selectedJoke: JokeModel!
    
    var apiArr: [JokeModel] = []
    
    var coredataArr: [JokeModel] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.coredataArr = CDManager().readFromCd()
        
        ApiCall()
        reloadUI()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmenttbl.selectedSegmentIndex = 0
        self.coredataArr = CDManager().readFromCd()
        setupTable()
        reloadUI()
        // Do any additional setup after loading the view.
    }
 
    
    // Update Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToUpdate" {
            
            if let updateVC = segue.destination as? UpdateVC {
                
                updateVC.jokePassed = selectedJoke
            }
        }
    }
    
    // API call func
    func ApiCall(){
        ApiManager().fetchJokes{ result in
            switch result {
            case.success(let data):
                self.apiArr.append(contentsOf: data)
                print(self.apiArr)
                self.reloadTbl1()
                
            case.failure(let error):
                print("err: \(error)")
            }
        }
    }
    
    //Api and Coredata
    
    func reloadUI() {
        
//        DispatchQueue.main.async {
            
            if self.segmenttbl.selectedSegmentIndex == 0 {
                self.ApiCall()
                self.reloadTbl1()
                self.apitbl.isHidden = false
                self.coredatatbl.isHidden = true

                
            } else if self.segmenttbl.selectedSegmentIndex == 1 {
                
                self.coredataArr = CDManager().readFromCd()
                
                self.reloadTbl2()
                
                self.apitbl.isHidden = true
                
                self.coredatatbl.isHidden = false
                
            }
//        }
    }
    
    //delete Func
    
    func deleteFromArr(position: Int) {
        
        coredataArr.remove(at: position)
        
        DispatchQueue.main.async {
            
            self.coredatatbl.reloadData()
        }
    }
    
        
    
    @IBAction func segmentChanged(_ sender: Any) {
        
        print("current selected segment: \(segmenttbl.selectedSegmentIndex)")
        
        reloadUI()
    }
    
    // reload func of table1
    func reloadTbl1()  {
        
        DispatchQueue.main.async {
            
            self.apitbl.reloadData()
        }
    }
    
    // reload func of table2
    func reloadTbl2()  {
        
        DispatchQueue.main.async {
            
            self.coredatatbl.reloadData()
        }
    }
    
}

extension segmentVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupTable() {
        apitbl.dataSource = self
        coredatatbl.dataSource = self
        
        apitbl.delegate = self
        coredatatbl.delegate = self
        
        apitbl.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
        coredatatbl.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: "JokeCell")
        
        apitbl.isHidden = false
        coredatatbl.isHidden = true
        
        reloadUI()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return segmenttbl.selectedSegmentIndex == 0 ? apiArr.count : coredataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as? JokeCell else {
            
                        return UITableViewCell()
                }
        
        let currSeg = segmenttbl.selectedSegmentIndex
                
        switch currSeg {
            
        case 0:
            guard indexPath.row < apiArr.count else {
                
                print("Index out of bounds for apiArr")
                
                return cell
            }
            
            let joke = apiArr[indexPath.row]
            configureCell(cell, with: joke)
                    
        case 1:
            guard indexPath.row < coredataArr.count else {
                
                print("Index out of bounds for coredataArr")
                
                return cell
            }
                    
            let joke = coredataArr[indexPath.row]
            configureCell(cell, with: joke)
                    
        default:
            break
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    private func configureCell(_ cell: JokeCell, with joke: JokeModel) {
        
        cell.lid.text = "\(joke.id)"
        
        cell.ltype.text = joke.type
        
        cell.lsetup.text = joke.setup
        
        cell.lpunchline.text = joke.punchline

        }
    
    //selected joke stor in coredata table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        if tableView == apitbl {
                
            let jokeSelected = apiArr[indexPath.row]
            CDManager().AddToCd(jokeToAdd: jokeSelected)
            apitbl.deselectRow(at: indexPath, animated: true)
            print(jokeSelected)
        } else if tableView == coredatatbl {
            coredatatbl.deselectRow(at: indexPath, animated: true)

            }
        }
    
    //swipe Update Func
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == coredatatbl {
                
                let updateAction = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
                
                    self.selectedJoke = self.coredataArr[indexPath.row]
                    self.performSegue(withIdentifier: "GoToUpdate", sender: self)
                    
                    completionHandler(true)
                }
                updateAction.backgroundColor = .systemOrange
                updateAction.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
                let updateConfig = UISwipeActionsConfiguration(actions: [updateAction])
                
                return updateConfig
            
        } else {
            let updateConfig = UISwipeActionsConfiguration(actions: [])
            return updateConfig
        }
    }
    
    
    
    
    
    
    
    
    //swipe Delete func
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == coredatatbl {
            
                let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self] action, source, completion in
                        //  CoreData's Delete function called
                    
                let jokeToDelete = coredataArr[indexPath.row]
                    
                    CDManager().deleteFromCD(jokes: jokeToDelete)
                    
                    coredataArr.remove(at: indexPath.row)
                    
                    reloadTbl2()
                    
//                    deleteFromArr(position: indexPath.row)
//                    
//                    completion(true)
                    
//                    print(jokeToDelete)
                    
                }; /*print(deleteAction)*/
                //UI for Delete
            deleteAction.backgroundColor = .systemRed
            deleteAction.image = UIImage(systemName: "minus.circle.fill")
            
            let deleteConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            
            deleteConfig.performsFirstActionWithFullSwipe=false
            
                return deleteConfig
            } else {
                let deleteConfig = UISwipeActionsConfiguration(actions: [])
                
                deleteConfig.performsFirstActionWithFullSwipe = false
                
                return deleteConfig
            }
        
    }
    
}
