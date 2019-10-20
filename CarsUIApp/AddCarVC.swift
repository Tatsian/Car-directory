import UIKit
import CoreData

class AddCarVC: UIViewController {

    @IBOutlet weak var manufactureTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var yearOfManufacturTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var car: CarsInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let openedCar = car else { return }
        manufactureTextField.text = openedCar.manufacture
        modelTextField.text = openedCar.model
        typeTextField.text = openedCar.type
        yearOfManufacturTextField.text = openedCar.yearOfManufacture
        colorTextField.text = openedCar.color
        navigationItem.title = openedCar.model! + openedCar.type! + " detail"
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
        
        if yearOfManufacture.isEmpty || manufacture.isEmpty || model.isEmpty || type.isEmpty {
            showAlert()
        } else {
            if let uniqueId = newCar.carId {
                print("carId: \(uniqueId)")
            }
            
            do{
                try context.save()
            } catch let error {
                print("Failed to save due to error \(error).")
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error!", message: "Missing required field(s)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
