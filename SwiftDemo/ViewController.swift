//
//  ViewController.swift
//  SwiftDemo
//
//  Created by qiong on 2019/7/9.
//  Copyright © 2019 qiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let welcome = "1123";
        print(welcome);
        
        let possibleNum = "123"
        let convertNum = Int(possibleNum)
        print(convertNum);
        let str = String(123);
        
        let max = 125
        var a=2
        repeat{
            a=a*a;
        }while a<max
        print(a);
        let names = ["Chris","Alex","Ewa","Barry","Daniella"]
        var reverse = names.sorted(by: backward)
        print(reverse);
        
        //
      
      
        let john = Person()
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
      
        let johnsHouse = Residence()
      
        
        johnsHouse.rooms.append(Room(name: "Living Room"))
        johnsHouse.rooms.append(Room(name: "Kitchen"))
        john.residence = johnsHouse
          john.residence?.address = someAddress
        
    }

    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    func  backward(s1:String,s2:String) -> Bool {
        return s1>s2;
    }
}
enum CompassPoint {
    case north
    case sourth
    case east
    case west
}

class Person {
    var residence: Residence?
}
class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}
