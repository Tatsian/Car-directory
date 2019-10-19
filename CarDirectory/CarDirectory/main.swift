import Foundation

print(carsArray)

print("Enter car model")
var modelEntered = readLine()
while modelEntered!.isEmpty {
    print("Enter car model")
    modelEntered = readLine()
}

print("Enter the year of manufacture of the car (in numbers)")
var yearOfManufactureEntered = readLine()
while yearOfManufactureEntered!.isEmpty || Int(yearOfManufactureEntered!) == nil {
    print("Enter the year of manufacture of the car (in numbers)")
    yearOfManufactureEntered = readLine()
}

print("Enter car manufacturer")
var manufactureEntered = readLine()
while manufactureEntered!.isEmpty {
    print("Enter car manufacturer")
    manufactureEntered = readLine()
}

print("Enter car body type")
var typeEntered = readLine()
while typeEntered!.isEmpty {
    print("Enter car body type")
    typeEntered = readLine()
}
print("Enter car color")
var colorEntered = readLine()


addNewCar(year: Int(yearOfManufactureEntered!)!, manufacture: manufactureEntered!, model: modelEntered!, type: typeEntered!, color: colorEntered)
