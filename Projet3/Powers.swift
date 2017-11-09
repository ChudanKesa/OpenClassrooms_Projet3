//
//  Powers.swift
//  Projet3
//
//  Created by Erwan Le Querré on 27/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Powers // powers to be used. Depends on weapon, since weapon alredy depends on class.
{
    var weapon = Weapons()
}

//////////////////////////
// MARK: HEALING

class Healing: Powers // contains different ways to heal, based on weapon. Last one choose which one is actually used.
{
    func healing(target: Caracters)
    {
        if target.maxLifePoints - target.lifePoints >= 10
        {
            target.lifePoints += 10
        }
        else if target.maxLifePoints - target.lifePoints < 10 && target.lifePoints < target.maxLifePoints
        {
            target.lifePoints = target.maxLifePoints
        }
        else
        {
            print("Strange choince : \(target.name) already has all his life points, and will be unnafected.")
        }
    }
    
    func superiorHealing(target: Caracters)
    {
        if target.maxLifePoints - target.lifePoints >= 18
        {
            target.lifePoints += 18
        }
        else if target.maxLifePoints - target.lifePoints < 18 && target.lifePoints < target.maxLifePoints
        {
            target.lifePoints = target.maxLifePoints
        }
        else
        {
            print("Strange choince : \(target.name) already has all his life points, and will be unnafected.")
        }
    }
    
    func weakenedHealing(target: Caracters)
    {
        if target.maxLifePoints - target.lifePoints >= 8
        {
            target.lifePoints += 8
        }
        else if target.maxLifePoints - target.lifePoints < 8 && target.lifePoints < target.maxLifePoints
        {
            target.lifePoints = target.maxLifePoints
        }
        else
        {
            print("Strange choince : \(target.name) already has all his life points, and will be unnafected.")
        }
    }
    
    func multHealing(target: [Caracters])
    {
        for i in 0..<target.count
        {
            if target[i].maxLifePoints - target[i].lifePoints >= 9
            {
                target[i].lifePoints += 9
            }
            else if target[i].maxLifePoints - target[i].lifePoints < 9 && target[i].lifePoints < target[i].maxLifePoints
            {
                target[i].lifePoints = target[i].maxLifePoints
            }
            else
            {
                print("Strange choince : \(target[i].name) already has all his life points, and will be unnafected.")
            }
        }
    }
    
// ----------------------------------------------
    // switch weapon to choose which power to actually use.
    
    func useHeal(target: Caracters) -> String
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
        case "Sacred oak":
            superiorHealing(target: target)
            healName = "superior healing"
        case "Long staff":
            multHealing(target: (target as! Wizzard).team)
            healName = "multi healing"
        default:
            Support.errorLog(origin: "Powers", detail: "weapon.name non recognized")
        }
        
        return healName
    }
        
} // class Healing




