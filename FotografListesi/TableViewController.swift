//
//  TableViewController.swift
//  FotografListesi
//
//  Created by Muhammed Gül on 16.11.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var frc : NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // bu fonksiyon veri tabanından verileri getirecek
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        
        let sorter = NSSortDescriptor(key: "titleText", ascending: true)
        fetchRequest.sortDescriptors = [sorter]
        
        return fetchRequest
    }
    
    
    func getFRC() -> NSFetchedResultsController<NSFetchRequestResult> {
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: pc, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frc = getFRC()
        frc.delegate = self
        do {
            
            try frc.performFetch()
        } catch {
            print(error)
            return
        }
        self.tableView.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = frc.sections?[section].numberOfObjects
        
        return numberOfRows!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let dataRow = frc.object(at: indexPath) as! Entity
        
        cell.lblTitle.text = dataRow.titleText
        cell.lblDescription.text = dataRow.descriptionText
        cell.imgFoto.image = UIImage(data: (dataRow.image)! as Data)
        return cell
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "edit" {
            let selectedCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedCell)
            
            let addPhotoVC : addPhotoViewController = segue.destination as! addPhotoViewController
            
            let selectedItem : Entity = frc.object(at: indexPath!) as! Entity
            addPhotoVC.selectedItem = selectedItem
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let managedObject : NSManagedObject = frc.object(at: indexPath) as! NSManagedObject
        pc.delete(managedObject)
        
        do {
            try pc.save()
        }catch {
            print(error)
        }
        return
    }
}


