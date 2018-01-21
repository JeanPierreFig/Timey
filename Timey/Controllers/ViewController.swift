//
//  ViewController.swift
//  Timey
//
//  Created by Jean Pierre on 1/9/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit
import CoreData
import AASegmentedControl

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, CreateTimeLapseDelegate{
    
    private  let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var manageContext:NSManagedObjectContext!
    private var entityDescription: NSEntityDescription!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: AASegmentedControl!
    var timelapesInprogress = [inprogress]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manageContext = appDelegate.managedObjectContext
        entityDescription = NSEntityDescription.entity(forEntityName: "Timelapse", in: manageContext)
        segmentedControl.itemNames = ["In progress","Done"]
        segmentedControl.font = UIFont(name: "Helvetica Neue", size: 12.0)!
        segmentedControl.selectedIndex = 0
        segmentedControl.addTarget(self,
                                 action: #selector(ViewController.segmentValueChanged(_:)),
                                 for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInProgress()
        tableView.reloadData()
    }
    
    func loadInProgress(){
        timelapesInprogress.removeAll()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Timelapse")
        
//        let sectionSortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
//        let sortDescriptors = [sectionSortDescriptor]
//        fetchRequest.sortDescriptors = sortDescriptors
        
        do{
            let results = try manageContext.fetch(fetchRequest)
            
            print(results)
            for obj in results{
                let title = obj.value(forKey: "title") as! String
                let imagePath = obj.value(forKey: "imagesPath") as! [String]
                let createdAt = obj.value(forKey: "createdAt") as! Date
                timelapesInprogress.append(inprogress(title: title, createdAt: createdAt, imagesName: imagePath))
                self.tableView.reloadData()
                print(imagePath)
            }
        }
        catch{
            print("error retrieving data.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let navVC = segue.destination as? UINavigationController ,
            let dest = navVC.viewControllers.first as? ImageCollectionViewController{
            dest.inProgress = timelapesInprogress[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    //MARK: CreateTimeLapseDelegate
    
    func didCreateNewTimeLapse() {
        loadInProgress()
    }
    
    //MARK: TableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelapesInprogress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InProgressCell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.backgroundColor = UIColor(white: 1, alpha: 0)
        cell.textLabel?.text = timelapesInprogress[indexPath.row].title
        cell.imageView?.image = timelapesInprogress[indexPath.row].images[0]
        
      
        return cell
    }
    
    //MARK: TableViewDataSource Methods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //chnage between in progress and done.
    @objc func segmentValueChanged(_ sender: AASegmentedControl) {
        segmentedControl.reloadInputViews()
    
        tableView.reloadData()
    }

}

