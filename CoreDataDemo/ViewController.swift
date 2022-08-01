//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Chanti on 01/08/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var listTV: UITableView!
    var sno = 0
    
    var records : [Records] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTV.delegate = self
        listTV.dataSource = self
        listTV.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSave(_ sender: UIButton) {
        guard let name = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let age = ageTF.text else { return }
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)
        let newdata = NSManagedObject(entity: entity!, insertInto: context)
       
        newdata.setValue(sno+1, forKey: "sNo")
        newdata.setValue(name, forKey: "name")
        newdata.setValue(Int(age), forKey: "age")
        
        do{
            try context.save()
            nameTF.text = ""
            ageTF.text = ""
            sno = sno+1
            fetchData()
        }catch{
            debugPrint("Can't Save")
        }
        
       
        
    }
    
    func fetchData() {
        records.removeAll()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let user = Records(
                    sno: data.value(forKey: "sNo") as! Int,
                    name: data.value(forKey: "name") as! String,
                    age: data.value(forKey: "age") as! Int
                )
                
                records.append(user)
                listTV.reloadData()
            }
        }catch{
            
        }
    }
    
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.setupView(data: records[indexPath.row])
        return cell
    }
    
    
}

struct Records {
    var sno: Int
    var name: String
    var age: Int
}

