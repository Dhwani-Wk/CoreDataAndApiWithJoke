//
//  CDManager.swift
//  coredatapractice
//
//  Created by Manthan Mittal on 15/12/2024.
//

import UIKit
import CoreData

class CDManager {
    
    //read func for CD
    
    func readFromCd() -> [JokeModel] {
        
        var coredataArr: [JokeModel] = []
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = delegate!.persistentContainer.viewContext
                
                let fetchRes = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
                
        do {
            
            let dataArr = try managedContext.fetch(fetchRes)
            
            for data in dataArr as! [NSManagedObject] {
                
                let jID = data.value(forKey: "id") as! Int
                
                let jType = data.value(forKey: "type") as! String
                
                let jSetup = data.value(forKey: "setup") as! String
                
                let jPunchline = data.value(forKey: "punchline") as! String
                
                coredataArr.append(JokeModel(id: jID, type: jType, setup: jSetup, punchline: jPunchline))
                
                print("type: \(jType)")

            }
            
        } catch let err as NSError {
            print(err)
        }
        return coredataArr
    }
    
    //add func for CD
    
    func AddToCd(jokeToAdd: JokeModel) {
        
        guard let delegate = UIApplication.shared.delegate as?AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let jokeEnt = NSEntityDescription.entity(forEntityName: "Jokes", in: managedContext) else { return }
        
        let joke = NSManagedObject(entity: jokeEnt, insertInto: managedContext)
        
        joke.setValue(jokeToAdd.id, forKey: "id")
        
        joke.setValue(jokeToAdd.type, forKey: "type")
        
        joke.setValue(jokeToAdd.setup, forKey: "setup")
        
        joke.setValue(jokeToAdd.punchline, forKey: "punchline")
        
        do {
            
            try managedContext.save()
            print("Joke is saved successfully!")
            
        }catch let err as NSError {
            print(err)
        }
    }
    
    //delete func for CD
    
    func deleteFromCD(jokes: JokeModel) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
                
        let managedContext = delegate.persistentContainer.viewContext
                
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
                
        fetchRequest.predicate = NSPredicate(format: "id = %d", jokes.id)
//            
//        fetchRequest.predicate = NSPredicate(format: "type = %data", joke.type)
//            
//        fetchRequest.predicate = NSPredicate(format: "setup = %data", joke.setup)
//            
//        fetchRequest.predicate = NSPredicate(format: "punchline = %data", joke.punchline)
        
            do {
                
                let fetchRes = try managedContext.fetch(fetchRequest)
                
                let objToDelete = fetchRes[0] as! NSManagedObject
                managedContext.delete(objToDelete)
                
                try managedContext.save()
                print("Joke deleted successfully")
                
            } catch let err as NSError {
                
                print("Somthing went wrong while deleting \(err)")
                
            }
        }
    
    //update func for CD
    
    func updateInCD(updateJoke: JokeModel) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        fetchRequest.predicate = NSPredicate(format: "id = %data", updateJoke.id)
        
        do {
            
            let rawData = try managedContext.fetch(fetchRequest)
            
            let objUpdate = rawData[0] as! NSManagedObject
            
            objUpdate.setValue(updateJoke.type, forKey: "type")
            
            objUpdate.setValue(updateJoke.setup, forKey: "setup")
            
            objUpdate.setValue(updateJoke.punchline, forKey: "punchline")
            
            try managedContext.save()
            
            print("Data updated Successfully")
            
        }catch let err as NSError {
            
            print("Somthing went wrong while deleting \(err)")
            
        }
        
        
    }
    
}

