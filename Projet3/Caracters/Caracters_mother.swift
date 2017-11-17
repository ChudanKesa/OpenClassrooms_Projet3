//
//  Caracters_mother.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Caracter // basis for the caracters used in the game.
                // They all need a name, a type (-> Class), life points, and a weapon.
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
    var maxLifePoints: Int
    var weapon : Weapon
    var name: String
    var caste: Class
    
    var auto = false
    
    init(lifePoints: Int, weapon: Weapon, name: String)
    {
        self.lifePoints = lifePoints
        maxLifePoints = lifePoints
        self.weapon = weapon
        self.name = name
        self.caste = .none
    }
    
    convenience init()
    {
        self.init(lifePoints: 100, weapon: Weapon(name: "Bare hands", damage: 3), name: "Unnamed warrior")
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: METHODS
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // function for attacking
    
    func attack(weapon: Weapon, target: Caracter)
    {
        target.lifePoints -= weapon.damage
        print("The attack was effective. \(target.name) has taken \(weapon.damage) points of damage.")
        if target.lifePoints < 0
        {
            target.lifePoints = 0
        }
        
        print("He has \(target.lifePoints) life points left.")
        target.lifeBar(caracter: target)
    }
    
// ----------------------------
    // to be used in the game to change the weapon of caracters. Could be done with openChest directly, but this feels more clear.
    
    func newWeapon(caracter: Caracter)
    {
        caracter.weapon = Chest.openChest(caste: caracter.caste)
        if caracter is Wizzard
        {
            (caracter as! Wizzard).power.weapon = caracter.weapon
        }
    }
    
// -----------------------------
    
    // asks for a string. To be used for naming caracters. Also permit "" entry for random name.
    
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
                if name == ""
                {
                    name = autoName(read: name)
                }
                error = nameTaken(name: name)
                if error == true
                {
                    print("This name has alredy been taken. Please choose a new one.\n")
                }
            }
            else
            {
                print("Problem with entry. Please try again.")
                error = true
            }
        }
        return name
    }
    
    //////////
    // checks if name is already taken
    
    private func nameTaken(name entry: String) -> Bool
    {
        var nameTaken = false

        for i in 0..<game.players.count
        {
            for j in 0..<game.players[i].party.count
            {
                if entry == game.players[i].party[j].name
                {
                    nameTaken = true
                }
            }
        }
        
        return nameTaken
    }
    
    //////////
    // gives name and checks if it's already attributed
    // cannot be private due to use in Caracter -> auto init
    
    func autoName(read: String) -> String
    {
        var name = ""
        var error = true
        
        while error
        {
            name = Support.randomNames()
            error = nameTaken(name: name)
        }
        
        return name
    }
    
    
// --------------------------------
    
    // a simple description based on caracter class. Useless, but lights the main code a little.
    
    static func caracterDescription(caste: Class) -> String
    {
        var description = ""
        
        switch caste
        {
        case .warrior:
            description = "Wielder of swords, he's a perfectly balanced fighter. He starts with 100 life points and a 10-damage sword."
        case .wizzard:
            description = "Not so much of a fighter, but he can heal his comrades. His staff does 5 damage, and he has 90 life points."
        case .giant:
            description = "He doesn't hit hard, but he lasts long. No weapon is fit for him, but his bare hands do 4 damage. He has 210 life points."
        case .dwarf:
            description = "A proud warrior from the mountains. His 70 life points will keep your wizzards busy, but his 14-damage axe will burden the opponent."
        case .archer:
            description = "A long-ranged, supportive fighter."
        default:
            Support.errorLog(origin: "Caracters_mother", detail: "caste would not be read")
        }
        
        return description
    }
    
// --------------------------------
    
    // set up here wich classes must be adressed with "a" or "an". Also add the class symbol after call.

    func adressCaracter(caracter: Caracter) -> String
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
                return "an \(caracter.caste.rawValue) 🔮"
            case .giant:
                return "an \(caracter.caste.rawValue) 👹"
            case .dwarf:
                return "an \(caracter.caste.rawValue) 🍺"
            default:
                Support.errorLog(origin: "Caracters_mother", detail: "caste switch error")
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
                return "a \(caracter.caste.rawValue) 🔮"
            case .giant:
                return "a \(caracter.caste.rawValue) 👹"
            case .dwarf:
                return "a \(caracter.caste.rawValue) 🍺"
            default:
                Support.errorLog(origin: "Caracters_mother", detail: "caste switch error")
                return "ERROR LOGGED"
            }
        }
    }
    
} // class Caracters





