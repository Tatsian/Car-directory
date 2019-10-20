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
    
    var car: CarsInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let openedCar = car else { return }
        manufactureTextField.text = openedCar.manufacture
        modelTextField.text = openedCar.model
        typeTextField.text = openedCar.type
        yearOfManufacturTextField.text = openedCar.yearOfManufacture
        colorTextField.text = openedCar.color
        guard let model = openedCar.model, let type = openedCar.type else { return }
        navigationItem.title = model + " " + type + " detail"
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        let yearOfManufacture = yearOfManufacturTextField.text ?? ""
        let manufacture = manufactureTextField.text ?? ""
        let model = modelTextField.text ?? ""
        let type = typeTextField.text ?? ""
        let color = colorTextField.text ?? ""
    
        if yearOfManufacture.isEmpty || manufacture.isEmpty || model.isEmpty || type.isEmpty {
            showAlert()
        
        } else {
            let newCar = Car(yearOfManufacture: yearOfManufacture,
                             manufacture: manufacture,
                             model: model,
                             type: type,
                             color: color)
            CoreDataManager.shared.save(car: newCar, oldCar: car)
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
