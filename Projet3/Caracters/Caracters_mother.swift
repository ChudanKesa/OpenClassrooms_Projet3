//
//  Caracters_mother.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Caracters
{
    var lifePoints: Int
    var weapon : Weapons
    
    init(lifePoints: Int, weapon: Weapons)
    {
        self.lifePoints = lifePoints
        self.weapon = weapon
    }
    
    convenience init()
    {
        self.init(lifePoints: 100, weapon: bareHands)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: MÉTHODES
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func attack(weapon: Weapons, target: Caracters)
    {
        target.lifePoints -= weapon.damage
    }
    
    func newWeapon(caracter: Caracters)
    {
        caracter.weapon = openChest(warrior: caracter)
    }
    
}




