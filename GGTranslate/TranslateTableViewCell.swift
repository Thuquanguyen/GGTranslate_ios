//
//  TranslateTableViewCell.swift
//  GGTranslate
//
//  Created by Apple on 16/01/2022.
//

import Foundation
import UIKit

class TranslateTableViewCell:  UITableViewCell{
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
