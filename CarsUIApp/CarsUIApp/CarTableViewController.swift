import UIKit
import CoreData

class CarTableViewController: UITableViewController {

    var carArray = [CarsInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.shared.addDefaultCarsIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carArray = CoreDataManager.shared.getCarsList()
        self.tableView.reloadData()
    }
    
    static func storyboardInstance() -> AddCarVC? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddCarVC") as? AddCarVC
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let car = carArray[indexPath.row]
        let manufacture = car.manufacture ?? ""
        let model = car.model ?? ""
        cell.textLabel?.text = manufacture + model
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let testVC = CarTableViewController.storyboardInstance() else { return }
        testVC.car = carArray[indexPath.row]
        let navigationController = UINavigationController(rootViewController: testVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }

    // MARK: - Navigation
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if carArray.count > indexPath.row {
            let car = carArray[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(car)
            carArray.remove(at: indexPath.row)
            
            do {
                try context.save()
            } catch let error {
                print("error: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
}
