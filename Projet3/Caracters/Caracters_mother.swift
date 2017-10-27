//
//  Caracters_mother.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Caracters
{
    enum Class: String
    {
        case none
        
        case warrior
        case wizzard
        case giant
        case dwarf
        case archer
    }
    
    var lifePoints: Int
    var weapon : Weapons
    var name: String
    var caste: Class
    
    init(lifePoints: Int, weapon: Weapons, name: String)
    {
        self.lifePoints = lifePoints
        self.weapon = weapon
        self.name = name
        self.caste = .none
    }
    
    convenience init()
    {
        self.init(lifePoints: 100, weapon: bareHands, name: "Unnamed warrior")
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: METHODS
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func attack(weapon: Weapons, target: Caracters)
    {
        target.lifePoints -= weapon.damage
        print("The attack was effective. \(target.name) has taken \(weapon.damage) points of damage.")
        print("He has \(target.lifePoints) life points left.\n")
    }
    
// ----------------------------
    // ↓ pourrait être fait avec une seule fonction, mais je trouve ça plus clair
    
    func newWeapon(caracter: Caracters)
    {
        caracter.weapon = openChest(warrior: caracter)
    }
    
// -----------------------------
    
    func askForName() -> String
    {
        var name = ""
        var read: String?
        var error = true
        
        while error
        {
            read = readLine()
            
            if read != nil
            {
                name = read!
                error = false
            }
            else
            {
                print("Problem with entry. Please try again.")
                error = true
            }
        }
        
        return name
    }
    
// --------------------------------
    
    static func caracterDescription(caste: Class) -> String
    {
        
    // The fonction is useless for now, but i'd like to use it by accessing the properties of the class themselves
    // As in : description = "He has \(Warrior.lifePoints) life points"
        
        var description = ""
        
        switch caste
        {
        case .warrior:
            description = "Wielder of swords, he's a perfectly balanced fighter. He starts with 100 life points and a 10-damage sword."
        case .wizzard:
            description = "Not so much of a fighter, but he can heal his comrades. His staff does 5 damage, and he has 90 life points."
        case .giant:
            description = "He doesn't hit hard, but he lasts long. No weapon is fit for him, but his bare hands do 4 damage. He has 150 life points."
        case .dwarf:
            description = "A proud warrior from the mountains. His 70 life points will keep your wizzards busy, but his 12-damage axe will burden the opponent."
        case .archer:
            description = "A long-ranged, supportive fighter."
        default:
            errorLog(origin: "Caracters_mother", detail: "caste would not be read")
        }
        
        return description
    }
    
// --------------------------------

    func adressCaracter(caracter: Caracters) -> String
    {
        if caracter.caste.rawValue[caracter.caste.rawValue.index(caracter.caste.rawValue.startIndex, offsetBy: 0)] == "A" ||
            caracter.caste.rawValue[caracter.caste.rawValue.index(caracter.caste.rawValue.startIndex, offsetBy: 0)] == "O" ||
            caracter.caste.rawValue[caracter.caste.rawValue.index(caracter.caste.rawValue.startIndex, offsetBy: 0)] == "I" ||
            caracter.caste.rawValue[caracter.caste.rawValue.index(caracter.caste.rawValue.startIndex, offsetBy: 0)] == "E" ||
            caracter.caste.rawValue[caracter.caste.rawValue.index(caracter.caste.rawValue.startIndex, offsetBy: 0)] == "U" ||
            caracter.caste.rawValue[caracter.caste.rawValue.index(caracter.caste.rawValue.startIndex, offsetBy: 0)] == "Y"
        {
            switch caracter.caste
            {
            case .warrior:
                return "an \(caracter.caste.rawValue) ⚔"
            case .wizzard:
                return "an \(caracter.caste.rawValue)⚕"
            case .giant:
                return "an \(caracter.caste.rawValue) 👹"
            case .dwarf:
                return "an \(caracter.caste.rawValue) 🍺"
            default:
                errorLog(origin: "Caracters_mother", detail: "caste switch error")
                return "ERROR LOGGED"
            }
        }
            
        else
        {
            switch caracter.caste
            {
            case .warrior:
                return "a \(caracter.caste.rawValue) ⚔"
            case .wizzard:
                return "a \(caracter.caste.rawValue)⚕"
            case .giant:
                return "a \(caracter.caste.rawValue) 👹"
            case .dwarf:
                return "a \(caracter.caste.rawValue) 🍺"
            default:
                errorLog(origin: "Caracters_mother", detail: "caste switch error")
                return "ERROR LOGGED"
            }
        }
    }
    
} // class Caracters





