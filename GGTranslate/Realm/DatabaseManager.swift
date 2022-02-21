//
//  DatabaseManager.swift
//  BrowserPrivate
//
//  Created by Intel on 3/30/17.
//  Copyright © 2017 Intel. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
class DatabaseManager {
    let realm = try! Realm()
//    func insert(item:HistoryRealm ){
//        try! realm.write {
//            realm.add(item)
//        }
//    }
    
    func getAllItem() -> [HistoryRealm]{
        
        let a = realm.objects(HistoryRealm.self)
        var array = Array<HistoryRealm>()
        for i in a{
            
            array.append(i)
        }
        return array.reversed()
    }
    func deleteAll()  {
        try! realm.write {
            realm.delete(self.getAllItem())
        }
    }
    
    func insert(item:HistoryRealm ) -> Int{
         let index = self.checkIdVideoIsExist(item: item)
        try! realm.write {
            //self.checkanDeleteIdVideo(item: item)
            if index > -1{
                deleteVideoHistory(item: item)
                realm.add(item)
                
            }else{
                checkLastIDVide()
                realm.add(item)
            }
            
        }
        return index
    }
    func checkIdVideoIsExist(item:HistoryRealm) -> Int{
        
        
        var isCheck = false
        let arr = self.getAllItemHistory()
        var count = 0
        for i in arr{
            if i.id == item.id{
                return count
            }
            count = count + 1
        }
        return -1
        
        
    }
    func checkLastIDVide(){
        let arr = realm.objects(HistoryRealm.self)
        print(arr.last?.id)
        if arr.count == 300 {
            deleteVideoHistory(item: arr.last!)
        }
    }
    func getAllItemHistory()-> [HistoryRealm]{
        let a = realm.objects(HistoryRealm.self)
        var array = Array<HistoryRealm>()
        for i in a{
            array.append(i)
        }
        return array.reversed()
    }
    func deleteVideoHistory(item:HistoryRealm){
        // realm.beginWrite()
        realm.delete(getItemHistoryWithId(id: item.id))
        //try! realm.commitWrite()
    }
    func getItemHistoryWithId(id:String) -> Results<HistoryRealm> {
        
        let object =  realm.objects(HistoryRealm.self).filter(NSPredicate(format: "id = %@", id))
        return object
        
        
    }
}
