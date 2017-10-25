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
    var weapon : Weapon
    
    func attack(weapon: Weapon, target: Caracters)
    {
        target.lifePoints -= weapon
    }
    
    func newWeapon(caracter: Caracters)
    {
        caracter.weapon = openChest(caracter)
    }
    
}



