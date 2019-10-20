import UIKit
import CoreData

private let mercedes = Car(yearOfManufacture: "2016",
                           manufacture: "Mercedes",
                           model: "E300",
                           type: "sedan",
                           color: "red")
private let audi = Car(yearOfManufacture: "2010",
                       manufacture: "Audi",
                       model: "A6",
                       type: "wagon",
                       color: "green")
private let lexus = Car(yearOfManufacture: "2014",
                        manufacture: "Lexus",
                        model: "XC10",
                        type: "coupe",
                        color: "gray")

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    func getCarsList() -> [CarsInfo] {
        let fetchRequest = CarsInfo.fetchRequest() as NSFetchRequest<CarsInfo>
        do {
          return try context.fetch(fetchRequest)
        } catch let error {
            print("error: \(error)")
            return []
        }
    }

    func save(car: Car, oldCar: CarsInfo? = nil) {
        let newCar = oldCar ?? CarsInfo(context: context)
        newCar.yearOfManufacture = car.yearOfManufacture
        newCar.manufacture = car.manufacture
        newCar.model = car.model
        newCar.type = car.type
        newCar.color = car.color
        newCar.carId = UUID().uuidString
        
        if let uniqueId = newCar.carId {
            print("carId: \(uniqueId)")
        }
        
        do{
            try context.save()
        } catch let error {
            print("Failed to save due to error \(error).")
        }
    }
    
    func addDefaultCarsIfNeeded() {
        guard !UserDefaults.standard.bool(forKey: "didAddDefaultCars") else { return }
        let cars = [audi, mercedes, lexus]
        for car in cars {
            save(car: car)
        }
        UserDefaults.standard.set(true, forKey: "didAddDefaultCars")
    }
}
