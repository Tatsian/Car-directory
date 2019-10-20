import UIKit
import CoreData

class CarTableViewController: UITableViewController {

    var carArray = [CarsInfo]()
    
    let mercedes = Car(yearOfManufacture: "2016", manufacture: "Mercedes", model: "E300", type: "sedan", color: "red")
    let audi = Car(yearOfManufacture: "2010", manufacture: "Audi", model: "A6", type: "wagon", color: "green")
    let lexus = Car(yearOfManufacture: "2014", manufacture: "Lexus", model: "XC10", type: "coupe", color: "gray")


    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        createNewCar(new: audi)
        
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
    
    func createNewCar(new: Car) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCar = CarsInfo(context: context)
        newCar.yearOfManufacture = new.yearOfManufacture
        newCar.manufacture = new.manufacture
        newCar.model = new.model
        newCar.type = new.type
        newCar.color = new.color
        newCar.carId = UUID().uuidString
        
        addToArray(car: newCar)
    }
    
    func addToArray(car: CarsInfo) {
        carArray.append(car)
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
        let testVC = CarTableViewController.storyboardInstance()
        testVC?.car = carArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(testVC!, animated: true, completion: nil)

 //       performSegue(withIdentifier: "goToOneCar", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "goToOneCar" else { return}
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        (segue.destination as? AddCarVC)?.car = carArray[indexPath.row]
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

    
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
