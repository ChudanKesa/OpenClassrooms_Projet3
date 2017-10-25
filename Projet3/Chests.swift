//
//  Chests.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

enum Class
{
    case warrior
    case dwarf
    case archer
    case wizzard
}



func openChest(warrior: Caracters) -> Weapons
{
    var weapon = Weapons()
    var typeOfWeapon = Class.warrior
    
    let swords =   [sword, saber, longsword, rapier]
    let axes = [axe, broadaxe, dual_axe, two_handed_axe]
    let bows = [bow, longbow, compound_bow, recurve_bow]
    let staffs = [staff, sacred_oak, wand, long_staff]
    
    // 1. determine type of caracter
    
    switch warrior
    {
    case is Warrior:
        typeOfWeapon = .warrior
    case is Dwarf:
        typeOfWeapon = .dwarf
    case is Archer:
        typeOfWeapon = .archer
    case is Wizzard:
        typeOfWeapon = .wizzard
    default:
        errorLog(origin: "Chests", detail: "type of caracter could not be determined")
    }
    
    // 2. obtain weapon
    
    let weaponSelect = Int(arc4random_uniform(UInt32(5)))
    
    switch typeOfWeapon
    {
    case .warrior:
        weapon = swords[weaponSelect]
    case .dwarf:
        weapon = axes[weaponSelect]
    case .archer:
        weapon = bows[weaponSelect]
    case .wizzard:
        weapon = staffs[weaponSelect]
    }
    
    if weapon.name == "Axe"
    {
        print("You've obtained a new weapon : an \(weapon.name).")
    }
    
    else
    {
        print("You've obtained a new weapon : a \(weapon.name).")
    }
    
    print("It causes \(weapon.damage) damage per hit.")
    
    return weapon
    
}

