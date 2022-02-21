//
//  LanguageTableViewCell.swift
//  GGTranslate
//
//  Created by Apple on 16/01/2022.
//

import Foundation
import UIKit

class LanguageTableViewCell: UITableViewCell{
    @IBOutlet weak var imageTick: UIImageView!
    @IBOutlet weak var lang: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
