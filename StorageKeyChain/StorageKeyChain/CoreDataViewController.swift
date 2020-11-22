//
//  CoreDataViewController.swift
//  StorageKeyChain
//
//  Created by Thirawuth on 22/11/2563 BE.
//

import UIKit
import Security
import CoreData

//SecItemAdd
//SecItemCopyMatching
//SecItemUpdate
//SecItemDelete

class CoreDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        saveCoreData()
        readCoreData()
        
    }

    func saveCoreData() {
//        prepare context
//        prepare entity - User
//        set value to keys in entity
//        save
        guard let appDalegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDalegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        let newUser = NSManagedObject(entity: userEntity, insertInto: context)
        newUser.setValue("1", forKey: "age")
        newUser.setValue("hello", forKey: "password")
        newUser.setValue("champy", forKey: "username")
        do {
            try context.save()
            print("save success")
        } catch {
            print("save fail :: \(error.localizedDescription)")
        }
    }
    
    func readCoreData() {
//        prepare request
//        Fetch result
//        Iterate array
        guard let appDalegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDalegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let username = data.value(forKey: "username") as! String
                print("username :: \(username)")
            }
        }catch {
            print("fetch fail :: \(error.localizedDescription)")
        }
    }
}
