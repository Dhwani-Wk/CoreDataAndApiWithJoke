//
//  JokeCell.swift
//  coredatapractice
//
//  Created by Manthan Mittal on 15/12/2024.
//

import UIKit

class JokeCell: UITableViewCell {

    @IBOutlet weak var lid: UILabel!
    
    @IBOutlet weak var lsetup: UILabel!
    
    @IBOutlet weak var ltype: UILabel!
    
    @IBOutlet weak var lpunchline: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
