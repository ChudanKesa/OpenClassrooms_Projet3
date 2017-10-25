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
    var name: String
    
    init(lifePoints: Int, weapon: Weapons, name: String)
    {
        self.lifePoints = lifePoints
        self.weapon = weapon
        self.name = name
    }
    
    convenience init()
    {
        self.init(lifePoints: 100, weapon: bareHands, name: "Unnamed warrior")
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
    // MARK: MÉTHODES
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func attack(weapon: Weapons, target: Caracters)
    {
        target.lifePoints -= weapon.damage
        print("The attack was effective.")
    }
    
    // ↓ pourrait être fait avec une seule fonction, mais je trouve ça plus clair
    
    func newWeapon(caracter: Caracters)
    {
        caracter.weapon = openChest(warrior: caracter)
    }
    
    func askForName() -> String
    {
        var name = ""
        let read = readLine()
        
        if read != nil
        {
            name = read!
        }
        
        return name
    }
    
}




