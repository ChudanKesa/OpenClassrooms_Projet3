//
//  Powers.swift
//  Projet3
//
//  Created by Erwan Le Querré on 27/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation



class Healing
{
    func healing(target: Caracters)
    {
        target.lifePoints += 10
    }
    
    func superiorHealing(target: Caracters)
    {
        target.lifePoints += 18
    }
    
    func multHealing(target: [Caracters])
    {
        for i in 0..<target.count
        {
            target[i].lifePoints += 8
        }
    }
    
    func weakenedHealing(target: Caracters)
    {
        target.lifePoints += 8
    }
    
    func useHealing(weapon: Weapons, target: Caracters, multiTarget: [Caracters]) -> String
    {
        var healName = ""
        switch weapon.name
        {
        case "Staff":
            healing(target: target)
            healName = "healing"
        case "Wand":
            weakenedHealing(target: target)
            healName = "weakened healing"
        case "Long staff":
            multHealing(target: multiTarget)
            healName = "multi healing"
        case "Sacred oak":
            superiorHealing(target: target)
            healName = "superior healing"
        default:
            errorLog(origin: "Powers", detail: "weapon.name non recognized")
            
        }
        
        return healName
    }
}




