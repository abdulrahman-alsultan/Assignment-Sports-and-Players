//
//  ViewController.swift
//  Sport
//
//  Created by admin on 29/12/2021.
//

import UIKit

class SportTableViewController: UITableViewController, ImagePickerDelegate {
    
    var selectedCell: IndexPath?
    var sports: [Sport] = []
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func save(){
        do{
            try managedObjectContext.save()
            
        }catch{
            print(error)
        }
        fetchData()
    }
    
    func fetchData(){
        do{
            sports = try managedObjectContext.fetch(Sport.fetchRequest())
            tableView.reloadData()
        }catch{
            print(error)
        }
    }
    
    func addSport(){
        let alert = UIAlertController(title: "Add New Sport", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let add = UIAlertAction(title: "Add", style: .default){
            _ in
            let sportName = alert.textFields![0]
            if sportName.text != ""{
                let newSport = Sport(context: self.managedObjectContext)
                newSport.name = sportName.text
                self.save()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(add)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func addSportBtn(_ sender: Any) {
        addSport()
    }
    
    func updateSportName(indexPath: IndexPath){
        let sport = sports[indexPath.row]
        let alert = UIAlertController(title: "Edit Sport Name", message: nil, preferredStyle: .alert)
        alert.addTextField(){ (textField : UITextField) -> Void in
            textField.text = sport.name
        }
        
        let save = UIAlertAction(title: "Save", style: .default){
            _ in
            let txt = alert.textFields![0]
            if txt.text != ""{
                sport.name = txt.text
                self.save()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportCell", for: indexPath) as! SportTableViewCell
        
        cell.sportName.text = sports[indexPath.row].name ?? ""
        if let img = sports[indexPath.row].image{
            print(";;;;;;")
            cell.addBtn.isHidden = true
            cell.img.isHidden = false
            cell.img.image = UIImage(data: img)
        }
        else{
            cell.img.isHidden = true
        }
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(sports[indexPath.row])
        fetchData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        updateSportName(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MoveToPlayerController", sender: sports[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! PlayerTableViewController
        destination.sport = sender as? Sport
    }
    
    func pickImage(indexPath: IndexPath) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        selectedCell = indexPath
        present(vc, animated: true )
    }
    
}


extension SportTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cell:SportTableViewCell = tableView.cellForRow(at: IndexPath(row: selectedCell!.row, section: 0)) as! SportTableViewCell
            cell.img.image = image
            cell.addBtn.isHidden = true
            cell.img.isHidden = false
            let sport = self.sports[selectedCell!.row]
            sport.image = image.pngData()
            self.save()
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
