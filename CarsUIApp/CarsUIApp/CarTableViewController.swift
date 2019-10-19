import UIKit
import CoreData

class CarTableViewController: UITableViewController {

    
    var carArray = [CarsInfo]()

//    var mercedes = CarsInfo(yearOfManufacture: "2016", manufacture: "Mercedes", model: "E300", type: "sedan", color: "red")
//    var audi = CarsInfo(yearOfManufacture: 2010, manufacture: "Audi", model: "A6", type: "wagon", color: "green")
//    var lexus = CarsInfo(yearOfManufacture: 2014, manufacture: "Lexus", model: "XC10", type: "coupe", color: "gray")

        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = CarsInfo.fetchRequest() as NSFetchRequest<CarsInfo>
        do {
            carArray = try context.fetch(fetchRequest)
        } catch let error {
            print("error: \(error)")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOneCar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToOneCar" else { return}
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        (segue.destination as? OneCarVC)?.car = carArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
