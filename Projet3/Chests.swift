//
//  Chests.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


func openChest(caste: Caracters.Class) -> Weapons
{
    var weapon = Weapons()
    
    let swords = [sword, saber, longsword, rapier]
    let axes = [axe, broadaxe, dual_axe, two_handed_axe]
    let bows = [bow, longbow, compound_bow, recurve_bow]
    let staffs = [staff, sacred_oak, wand, long_staff]
    let hands = [giant_bare_hands, giant_damaged_hands, furious_giant_hands, focused_giant_hands]
    
    
    let weaponSelect = Int(arc4random_uniform(UInt32(4)))
    
    switch caste
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
    default:
        errorLog(origin: "Chests", detail: "litterarly one thing can go wrong here")
    }
    
    print("A magical treasure chest appeared before you !")
    print("You open it and take its contents")
    print("You've obtained a new weapon : \(weapon.adressWeapon(weapon: weapon)).")
    print("It causes \(weapon.damage) damage per hit.\n")
    
    return weapon
    
}

