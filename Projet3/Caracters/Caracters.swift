//
//  Caracters.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


class Warrior: Caracters
{
    init()
    {
        super.init(lifePoints: 100, weapon: sword, name: "")
        caste = .warrior
        print("Choose a name for your Warrior :")
        name = askForName()
        print("This Warrior shall be called \(name).")
        print("You are currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
    }    
}

class Wizzard: Caracters
{
    var power = Healing()
    var team = [Caracters]() // <- to use as target for multiHeal
    
    init()
    {
        super.init(lifePoints: 90, weapon: staff, name: "")
        caste = .wizzard
        print("Choose a name for your Wizzard :")
        name = askForName()
        print("This Wizzard shall be called \(name).")
        print("You are currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        
    }
}

class TrainingWheelzard: Caracters
{
    var power = Healing()
    var team = [Caracters]()
    
    init()
    {
        super.init(lifePoints: 90, weapon: staff, name: "Gandalf")
    }
}

class Giant: Caracters
{
    init()
    {
        super.init(lifePoints: 210, weapon: giant_bare_hands, name: "")
        caste = .giant
        print("Choose a name for your Giant :")
        name = askForName()
        print("This Giant shall be called \(name).")
        print("You are currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
    }
}

class Dwarf: Caracters
{
    init()
    {
        super.init(lifePoints: 70, weapon: axe, name: "")
        caste = .dwarf
        print("Choose a name for your Dwarf :")
        name = askForName()
        print("This Dwarf shall be called \(name).")
        print("You are currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
    }
}

class Archer: Caracters
{    
    init()
    {
        super.init(lifePoints: 90, weapon: bow, name: "")
        caste = .archer
        print("Choose a name for your Archer :")
        name = askForName()
        print("This Archer shall be called \(name).")
        print("You are currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
    }
}


