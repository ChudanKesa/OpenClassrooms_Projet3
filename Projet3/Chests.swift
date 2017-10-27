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
    case giant
}



func openChest(warrior: Caracters) -> Weapons
{
    var weapon = Weapons()
    var typeOfWeapon = Class.warrior
    
    let swords = [sword, saber, longsword, rapier]
    let axes = [axe, broadaxe, dual_axe, two_handed_axe]
    let bows = [bow, longbow, compound_bow, recurve_bow]
    let staffs = [staff, sacred_oak, wand, long_staff]
    let hands = [giant_bare_hands, giant_damaged_hands, furious_giant_hands, focused_giant_hands]
    
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
    case is Giant:
        typeOfWeapon = .giant
    default:
        errorLog(origin: "Chests", detail: "type of caracter could not be determined")
    }
    
    // 2. obtain weapon
    
    let weaponSelect = Int(arc4random_uniform(UInt32(4)))
    
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
    case .giant:
        weapon = hands[weaponSelect]
    }
    
    print("You've obtained a new weapon : \(Weapons.adressWeapon(weapon)).")
    print("It causes \(weapon.damage) damage per hit.")
    
    return weapon
    
}

