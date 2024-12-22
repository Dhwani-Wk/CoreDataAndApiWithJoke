//
//  UpdateVC.swift
//  coredatapractice
//
//  Created by Manthan Mittal on 15/12/2024.
//

import UIKit

class UpdateVC: UIViewController {

    @IBOutlet weak var updtexttype: UITextField!
    
    @IBOutlet weak var updtextsetup: UITextField!
    
    @IBOutlet weak var updtextpunchline: UITextField!
    
    @IBOutlet weak var updtextlable: UILabel!
    
    var jokePassed: JokeModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()

        // Do any additional setup after loading the view.
    }
    
    func showData() {
        
        updtexttype.text = jokePassed.type
        
        updtextsetup.text = jokePassed.setup
        
        updtextpunchline.text = jokePassed.punchline
        
        }
    
    @IBAction func updateButton(_ sender: Any) {
        
        let updatedType = updtexttype.text!
        let updatedSetup = updtextsetup.text!
        let updatedPunchline = updtextpunchline.text!
                
//        if updatedType != "" || updatedSetup != "" || updatedPunchline != "" {
            
            //  CoreData's Update function called
            
            let updatedJoke = JokeModel(id: jokePassed.id, type: updatedType, setup: updatedSetup, punchline: updatedPunchline)
            
                DispatchQueue.main.async {
                            
                    CDManager().updateInCD(updateJoke: updatedJoke)
                    
                    self.navigationController?.popViewController(animated: true)
                            
                    print(updatedJoke)
                        }
//                }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
