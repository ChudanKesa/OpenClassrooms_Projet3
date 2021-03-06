//
//  Weapons.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Weapons // class that defines how many damage a caracter does. Depends on class. + list of instances
{
    let name: String
    let damage: Int
    
    init(name: String, damage: Int)
    {
        self.name = name
        self.damage = damage
    }
    
    convenience init()
    {
        self.init(name: "Bare Hands", damage: 3)
    }
    
    //////////////////////////////////////////////////////////
    // MARK: METHODS
    //////////////////////////////////////////////////////////
    
    // permit correct use of "a/an" as per weapon name.
    
    func adressWeapon(weapon: Weapons) -> String
    {
        if weapon.name[weapon.name.index(weapon.name.startIndex, offsetBy: 0)] == "A" ||
            weapon.name[weapon.name.index(weapon.name.startIndex, offsetBy: 0)] == "O" ||
            weapon.name[weapon.name.index(weapon.name.startIndex, offsetBy: 0)] == "I" ||
            weapon.name[weapon.name.index(weapon.name.startIndex, offsetBy: 0)] == "E" ||
            weapon.name[weapon.name.index(weapon.name.startIndex, offsetBy: 0)] == "U" ||
            weapon.name[weapon.name.index(weapon.name.startIndex, offsetBy: 0)] == "Y"
        {
            return "an \(weapon.name)"
        }
            
        else
        {
            return "a \(weapon.name)"
        }
    }
}

let bareHands = Weapons()

let axe = Weapons(name: "Axe", damage: 14)
let broadaxe = Weapons(name: "Broadaxe", damage: 16)
let dual_axe = Weapons(name: "Dual axe", damage: 13)
let two_handed_axe = Weapons(name: "Two handed axe", damage: 20)

let sword = Weapons(name: "Sword", damage: 10)
let longsword = Weapons(name: "Longsword", damage: 15)
let saber = Weapons(name: "Saber", damage: 13)
let rapier = Weapons(name: "Rapier", damage: 9)

let staff = Weapons(name: "Staff", damage: 5)
let sacred_oak = Weapons(name: "Sacred oak", damage: 8)
let long_staff = Weapons(name: "Long staff", damage: 6)
let wand = Weapons(name: "Wand", damage: 3)

let bow = Weapons(name: "Bow", damage: 9)
let longbow = Weapons(name: "Longbow", damage: 11)
let recurve_bow = Weapons(name: "Recurve bow", damage: 9)
let compound_bow = Weapons(name: "Compound bow", damage: 13)

let giant_bare_hands = Weapons(name: "Giant bare hands", damage: 4)
let giant_damaged_hands = Weapons(name: "Giant damaged hands", damage: 3)
let furious_giant_hands = Weapons(name: "Furous giant hands", damage: 8)
let focused_giant_hands = Weapons(name: "Focused giant hands", damage: 7)

