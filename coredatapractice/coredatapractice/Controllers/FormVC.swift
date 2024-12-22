//
//  FormVC.swift
//  coredatapractice
//
//  Created by Manthan Mittal on 15/12/2024.
//

import UIKit

class FormVC: UIViewController {
    
    @IBOutlet weak var textlable: UILabel!
    
    @IBOutlet weak var texttype: UITextField!
    
    @IBOutlet weak var textsetup: UITextField!
    
    @IBOutlet weak var textpunchline: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     @IBAction func saveButtonPressed(_ sender: Any) {
         
         let id = Int.random(in: 0...1000)
         let type = texttype.text!
         let setup = textsetup.text!
         let punchline = textpunchline.text!
                 
//         if type != "" && setup != "" && punchline != "" {
             let joke = JokeModel(id: Int(id), type: type, setup: setup, punchline: punchline)
                         DispatchQueue.main.async {
                             CDManager().AddToCd(jokeToAdd: joke)
                             self.navigationController?.popViewController(animated: true)
                         }
                         
//                 }
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
