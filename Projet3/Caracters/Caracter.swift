//
//  Caracters.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


class Warrior: Caracter
{
    init()
    {
        super.init(lifePoints: 100, weapon: Weapon(name: "Sword", damage: 10), name: "")
        caste = .warrior
        print("Choose a name for your Warrior (press entry for random name) :")
        name = askForName()
        print("This Warrior shall be called \(name).")
        usleep(8 * 100 * 1000)
        print("He is currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        usleep(20 * 100 * 1000)
    }
    
    init(auto: Bool)
    {
        super.init(lifePoints: 100, weapon: Weapon(name: "Sword", damage: 10), name: "")
        caste = .warrior
        name = autoName(read: "")
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 100, weapon: Weapon(name: "Sword", damage: 10), name: "")
        caste = .warrior
        name = robot
    }

}


class Wizzard: Caracter
{
    var power = Healing()
    var team = [Caracter]() // <- to use as target for multiHeal
        
    init()
    {
        super.init(lifePoints: 90, weapon: Weapon(name: "Staff", damage: 5), name: "")
        power.weapon = self.weapon
        caste = .wizzard
        print("Choose a name for your Wizzard (press entry for random name) :")
        name = askForName()
        print("This Wizzard shall be called \(name).")
        usleep(8 * 100 * 1000)
        print("He is currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        usleep(20 * 100 * 1000)
    }
    
    init(auto: Bool)
    {
        super.init(lifePoints: 90, weapon: Weapon(name: "Staff", damage: 5), name: "")
        power.weapon = self.weapon
        caste = .wizzard
        name = autoName(read: "")
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 90, weapon: Weapon(name: "Staff", damage: 5), name: "")
        power.weapon = self.weapon
        caste = .wizzard
        name = robot
    }
}



class Giant: Caracter
{
    init()
    {
        super.init(lifePoints: 210, weapon: Weapon(name: "Giant bare hands", damage: 4), name: "")
        caste = .giant
        print("Choose a name for your Giant (press entry for random name) :")
        name = askForName()
        print("This Giant shall be called \(name).")
        usleep(8 * 100 * 1000)
        print("He is currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        usleep(20 * 100 * 1000)
    }
    
    init(auto: Bool)
    {
        super.init(lifePoints: 210, weapon: Weapon(name: "Giant bare hands", damage: 4), name: "")
        caste = .giant
        name = autoName(read: "")
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 210, weapon: Weapon(name: "Giant bare hands", damage: 4), name: "")
        caste = .giant
        name = robot
    }
}

class Dwarf: Caracter
{
    init()
    {
        super.init(lifePoints: 70, weapon: Weapon(name: "Axe", damage: 14), name: "")
        caste = .dwarf
        print("Choose a name for your Dwarf (press entry for random name) :")
        name = askForName()
        print("This Dwarf shall be called \(name).")
        usleep(8 * 100 * 1000)
        print("He is currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        usleep(20 * 100 * 1000)
    }
    
    init(auto: Bool)
    {
        super.init(lifePoints: 70, weapon: Weapon(name: "Axe", damage: 14), name: "")
        caste = .dwarf
        name = autoName(read: "")
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 70, weapon: Weapon(name: "Axe", damage: 14), name: "")
        caste = .dwarf
        name = robot
    }
}

class Archer: Caracter
{    
    init()
    {
        super.init(lifePoints: 90, weapon: Weapon(name: "Bow", damage: 9), name: "")
        caste = .archer
        print("Choose a name for your Archer (press entry for random name) :")
        name = askForName()
        print("This Archer shall be called \(name).")
        usleep(8 * 100 * 1000)
        print("He is currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        usleep(20 * 100 * 1000)
    }
    
    init(auto: Bool)
    {
        super.init(lifePoints: 90, weapon: Weapon(name: "Bow", damage: 9), name: "")
        caste = .archer
        name = autoName(read: "")
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 90, weapon: Weapon(name: "Bow", damage: 9), name: "")
        caste = .archer
        name = robot
    }
}


