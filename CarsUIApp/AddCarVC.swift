import UIKit
import CoreData

class AddCarVC: UIViewController {

    @IBOutlet weak var manufactureTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yearOfManufacturTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        let yearOfManufacture = yearOfManufacturTextField.text ?? ""
        let manufacture = manufactureTextField.text ?? ""
        let model = modelTextField.text ?? ""
        let type = typeTextField.text ?? ""
        let color = colorTextField.text ?? ""
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newCar = CarsInfo(context: context)
        newCar.yearOfManufacture = yearOfManufacture
        newCar.manufacture = manufacture
        newCar.model = model
        newCar.type = type
        newCar.color = color
        newCar.carId = UUID().uuidString
        
        if let uniqueId = newCar.carId {
            print("carId: \(uniqueId)")
        }
        
        do{
            try context.save()
        } catch let error {
            print("Не удалось сохранить из-за ошибки \(error).")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
