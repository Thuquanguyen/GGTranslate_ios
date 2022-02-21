//
//  d.swift
//  SafePlay Browser
//
//  Created by Dat VO on 9/20/21.
//

import UIKit

import UIKit
import Realm
import RealmSwift
class HistoryRealm: Object {
    @objc dynamic  var id:String!
    @objc dynamic var text:String!
    @objc dynamic var trans:String!
    
    convenience init(id:String,text:String,trans:String) {
        self.init()
        self.id = id
        self.trans = trans
        self.text = text
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
