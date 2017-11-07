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
        print("Choose a name for your Warrior (press entry for random name) :")
        name = askForName()
        print("This Warrior shall be called \(name).")
        usleep(8 * 100 * 1000)
        print("He is currently equiped with \(weapon.adressWeapon(weapon: weapon)), which causes \(weapon.damage) damage per turn.\n")
        usleep(20 * 100 * 1000)
    }
    
    init(auto: Bool)
    {
        super.init(lifePoints: 100, weapon: sword, name: "")
        caste = .warrior
        name = Support.randomNames()
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 100, weapon: sword, name: "")
        caste = .warrior
        name = robot
    }

}


class Wizzard: Caracters
{
    var power = Healing()
    var team = [Caracters]() // <- to use as target for multiHeal
        
    init()
    {
        super.init(lifePoints: 90, weapon: staff, name: "")
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
        super.init(lifePoints: 90, weapon: staff, name: "")
        caste = .wizzard
        name = Support.randomNames()
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 90, weapon: staff, name: "")
        caste = .wizzard
        name = robot
    }
}



class Giant: Caracters
{
    init()
    {
        super.init(lifePoints: 210, weapon: giant_bare_hands, name: "")
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
        super.init(lifePoints: 210, weapon: giant_bare_hands, name: "")
        caste = .giant
        name = Support.randomNames()
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 210, weapon: giant_bare_hands, name: "")
        caste = .giant
        name = robot
    }
}

class Dwarf: Caracters
{
    init()
    {
        super.init(lifePoints: 70, weapon: axe, name: "")
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
        super.init(lifePoints: 70, weapon: axe, name: "")
        caste = .dwarf
        name = Support.randomNames()
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 70, weapon: axe, name: "")
        caste = .dwarf
        name = robot
    }
}

class Archer: Caracters
{    
    init()
    {
        super.init(lifePoints: 90, weapon: bow, name: "")
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
        super.init(lifePoints: 90, weapon: bow, name: "")
        caste = .archer
        name = Support.randomNames()
    }
    
    init(robot: String)
    {
        super.init(lifePoints: 90, weapon: bow, name: "")
        caste = .archer
        name = robot
    }
}


