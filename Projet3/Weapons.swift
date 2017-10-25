//
//  Weapons.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Weapons
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
}

let bareHands = Weapons()

let axe = Weapons(name: "Axe", damage: 12)
let broadaxe = Weapons(name: "Broadaxe", damage: 14)
let dual_axe = Weapons(name: "Dual axe", damage: 11)
let two_handed_axe = Weapons(name: "Two handed axe", damage: 18)

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



