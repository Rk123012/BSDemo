//
//  BSDemoCell.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import UIKit

class BSDemoCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func setInformation(name : String){
        self.lblTitle.text = name
    }
    
}
