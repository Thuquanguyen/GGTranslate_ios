//
//  LagVC.swift
//  GGTranslate
//
//  Created by Apple on 16/01/2022.
//

import Foundation
import UIKit

class LagVC: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titsle: UINavigationItem!
    
    var listLanguage = Array<Model>()
    var isTransFrom = true
    var language: Model!
    var viewController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    @IBAction func closeAction(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LagVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LanguageTableViewCell
        let model = self.listLanguage[indexPath.row]
        if(self.language.voice == model.voice){
                    cell.imageTick.isHidden = false
                }else{
                    cell.imageTick.isHidden = true
                }
        cell.lang.text = model.fullName.components(separatedBy: "(")[0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.listLanguage[indexPath.row]
        setModel(model: model)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
}

extension LagVC{
    func initData(){
        listLanguage = Utils.shared.getArrayItem()
        
        if(isTransFrom){
            self.titsle.title = "Translate From"
        }else{
            self.titsle.title = "Translate To"
        }
    }
    
    func setModel(model: Model){
        if(isTransFrom){
            Utils.shared.saveData1(lang1: model)
        }else{
            Utils.shared.saveData2(lang2: model)
        }
        
        viewController.viewWillAppear(false)
    }
}
