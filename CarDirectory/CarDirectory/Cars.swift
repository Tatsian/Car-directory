struct CarsInfo {
    var yearOfManufacture: Int
    var manufacture: String
    var model: String
    var type: String
    var color: String?
}

import Foundation

var mercedes = CarsInfo(yearOfManufacture: 2016, manufacture: "Mercedes", model: "E300", type: "sedan", color: "red")
var audi = CarsInfo(yearOfManufacture: 2010, manufacture: "Audi", model: "A6", type: "wagon", color: "green")
var lexus = CarsInfo(yearOfManufacture: 2014, manufacture: "Lexus", model: "XC10", type: "coupe", color: "gray")

var carsArray = [mercedes, audi, lexus]

func addNewCar(year: Int, manufacture: String, model: String, type: String, color: String?) {
    let newCar = CarsInfo(yearOfManufacture: year, manufacture: manufacture, model: model, type: type, color: color!)
    carsArray.append(newCar)
    print(carsArray)
    print(carsArray.count)
    
}
