import UIKit

class OneCarVC: UIViewController {

    var car: CarsInfo!
    
    @IBOutlet weak var manufactureOfOneCarTextField: UITextField!
    @IBOutlet weak var modelOfOneCarTextField: UITextField!
    @IBOutlet weak var typeOfOneCarTextField: UITextField!
    @IBOutlet weak var yearOfManufacturOfOneCarTextField: UITextField!
    @IBOutlet weak var colorOfOneCarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let openedCar = car else { return }
        manufactureOfOneCarTextField.text = openedCar.manufacture
        modelOfOneCarTextField.text = openedCar.model
        typeOfOneCarTextField.text = openedCar.type
        yearOfManufacturOfOneCarTextField.text = openedCar.yearOfManufacture
        colorOfOneCarTextField.text = openedCar.color
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
