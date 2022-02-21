

import UIKit
import Toast_Swift
import Realm
import RealmSwift
class ViewController: UIViewController {

    @IBOutlet weak var widthText: NSLayoutConstraint!
    
    @IBOutlet weak var viewTranslated: UIView!
    @IBOutlet weak var lblTranslated: UILabel!
    @IBOutlet weak var txtTranslated: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtView: UITextView!
    var lang1:Model!
    var lang2:Model!
    
    @IBOutlet weak var btnTran1: UIButton!
    
    @IBOutlet weak var btnTran2: UIButton!
    var listLanguage = Array<Model>()
    var listTranslation = Array<Translation>()
    var listHistory = Array<HistoryRealm>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.text = "Enter Text"
        self.txtView.textColor = UIColor.darkGray
        self.viewTranslated.isHidden = true
        listHistory = DatabaseManager().getAllItem()
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Utils.shared.getLanguage { (lang1, lang2, suc) in
            if suc {
                self.lang1 = lang1
                self.lang2 = lang2
               
                self.btnTran1.setTitle(self.lang1.fullName.components(separatedBy: "(")[0], for: .normal)
                self.btnTran2.setTitle(self.lang2.fullName.components(separatedBy: "(")[0], for: .normal)
                
            }
        }
    }
   

    
    @IBAction func actionExchange(_ sender: Any) {
        Utils.shared.swapLanguage(language1: self.lang1, language2: self.lang2) { (lang1, lang2, suc) in
            if suc {
                self.lang1 = lang1
                self.lang2 = lang2
                
                self.btnTran1.setTitle(self.lang1.fullName.components(separatedBy: "(")[0], for: .normal)
                self.btnTran2.setTitle(self.lang2.fullName.components(separatedBy: "(")[0], for: .normal)
                
            }
        }
    }
    
    @IBAction func actionLang1(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LagViewController") as! LagVC
        vc.viewController = self
        vc.language = lang1
        vc.isTransFrom = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionLang2(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LagViewController") as! LagVC
        vc.viewController = self
        vc.language = lang2
        vc.isTransFrom = false
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func actionCamera(_ sender: Any) {
        Photo()
    }
    
    @IBAction func actionVoice(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VoiceViewController") as! VoiceVC
        vc.lang1 = lang1
        vc.vcP = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionShare(_ sender: Any) {
        if self.txtView.text == "" {
            return
        }
        shareText(str: self.txtView.text)
    }
    
    @IBAction func actionShare2(_ sender: Any) {
        if self.txtTranslated.text == "" {
            return
        }
        shareText(str: self.txtTranslated.text)
    }
   
    @IBAction func actionSpeakLang1(_ sender: Any) {
        self.Speak(str: self.txtView.text, language: self.lang1.voice)
    }
    @IBAction func actionCopyLang1(_ sender: Any) {
        toastCopy()
    }
    
    @IBAction func actionSpeakLang2(_ sender: Any) {
        self.Speak(str: self.txtTranslated.text, language: self.lang2.voice)
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.tableView.isHidden = false
        self.viewTranslated.isHidden = true
        self.txtView.text = "Enter Text"
        self.txtView.textColor = UIColor.darkGray
        txtView.resignFirstResponder()
    }
   
}

extension ViewController{
    func getData(q:String,target:Model){
        ResponseData.shared.getInfo(q: q, target: target.voice.components(separatedBy: "-")[0]) { (model, req) in
            if req == .success{
                self.setTranslated(str: model[0].translatedText)
               
                let his = HistoryRealm(id: q, text: q, trans: model[0].translatedText)
                _ = DatabaseManager().insert(item:his)
                self.listHistory = DatabaseManager().getAllItem()
                self.tableView.reloadData()
               
            }
            
        }
    }

}

extension ViewController{
    func setTranslated(str: String){
        self.viewTranslated.isHidden = false
        self.tableView.isHidden = true
        self.lblTranslated.text = self.lang2.fullName.components(separatedBy: "(")[0]
        self.txtTranslated.text = str
        let w = UIScreen.main.bounds.width - 32
        var h = str.height(withConstrainedWidth: w, font: UIFont.systemFont(ofSize: 14)) + 93
        print(h)
        
        print(str)
        if h <= 150 {
            h = 110.0
        }
        if h >= 350{
            h = 350.0
        }
        self.widthText.constant = h
        self.view.layoutIfNeeded()
    }
    
    func toastCopy(){
        self.view.makeToast("Copied", duration: 1.0, position: .center)
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TranslateTableViewCell
        let model = self.listHistory[indexPath.row]
        cell.lblFrom.text = model.text
        cell.lblTo.text = model.trans
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

extension ViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.txtView.textColor == UIColor.darkGray{
            self.txtView.text = ""
            self.txtView.textColor = UIColor.black
            
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.txtView.text.isEmpty{
            self.txtView.text = "Enter Text"
            self.txtView.textColor = UIColor.darkGray
            
        }
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { if(text == "\n"){
        if textView.text == "" {
            textView.resignFirstResponder()
            return false
        }
        self.getData(q: textView.text, target: self.lang2)
        textView.resignFirstResponder()
        return false
        
        }
        return true
        
    }
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func Photo(){
        let Library = UIImagePickerController()
        Library.delegate = self
        Library.allowsEditing = false
        Library.sourceType = .photoLibrary
        Library.mediaTypes = ["public.image"]
        self.present(Library, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else{
            
            return
        }
        detectText(image: image) { [self] (arr, suc) in
            if suc {
                if suc {
                 
                    if arr.count > 0 {
                        self.txtView.text  = arr[0]
                        self.getData(q: self.txtView.text, target: self.lang2)
                    }else{
                        self.view.makeToast("Sorry, We Can't Detect Text In The Photo, Please Try Again", duration: 1.0, position: .bottom)
                        
                    }
                   
                }
 
            }
        }
        
    }
}
 


