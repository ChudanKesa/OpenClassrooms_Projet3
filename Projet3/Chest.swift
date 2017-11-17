//
//  Chests.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


class Chest
{
    // pick a new weapon and return it to be equiped.
    
    static func openChest(caste: Caracter.Class) -> Weapon
    {
        var weapon = Weapon()
        
        let swords = [Weapon(name: "Sword", damage: 10),
                      Weapon(name: "Longsword", damage: 15),
                      Weapon(name: "Saber", damage: 13),
                      Weapon(name: "Rapier", damage: 9)]
        
        let axes = [Weapon(name: "Axe", damage: 14),
                    Weapon(name: "Broadaxe", damage: 16),
                    Weapon(name: "Dual axe", damage: 13),
                    Weapon(name: "Two handed axe", damage: 20)]
        
        let bows = [Weapon(name: "Bow", damage: 9),
                    Weapon(name: "Longbow", damage: 11),
                    Weapon(name: "Recurve bow", damage: 9),
                    Weapon(name: "Compound bow", damage: 13)]
        
        let staffs = [Weapon(name: "Staff", damage: 5),
                      Weapon(name: "Sacred oak", damage: 8),
                      Weapon(name: "Long staff", damage: 6),
                      Weapon(name: "Wand", damage: 3)]
        
        let hands = [Weapon(name: "Giant bare hands", damage: 4),
                     Weapon(name: "Giant damaged hands", damage: 3),
                     Weapon(name: "Furous giant hands", damage: 8),
                     Weapon(name: "Focused giant hands", damage: 7)]
        
        
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
            Support.errorLog(origin: "Chests", detail: "litterarly one thing can go wrong here")
        }
        
        print("A magical treasure chest appeared before you !")
        usleep(15 * 100 * 1000)
        print("""
            You open it and take its contents.\n
            You've obtained a new weapon : \(weapon.adressWeapon(weapon: weapon)).\n
            It causes \(weapon.damage) damage per hit.\n
            """)
        sleep(1)
        
        return weapon
        
    }
}

