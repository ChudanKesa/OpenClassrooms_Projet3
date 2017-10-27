//
//  main.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

var fighterone = Caracters()
fighterone.weapon = sword
fighterone.caste = .warrior
fighterone.name = "Fighter"
fighterone.lifePoints = 100

var fightertwo = TrainingWheelzard()
fightertwo.weapon = staff
fightertwo.caste = .wizzard
fightertwo.name = "Gandalfus"
fightertwo.lifePoints = 70
var tab = [fightertwo]



while fightertwo.lifePoints > 0 && fighterone.lifePoints > 0
{
    fighterone.attack(weapon: fighterone.weapon, target: fightertwo)
    if fightertwo.lifePoints < 40
    {
        print("\(fightertwo.name) uses \(fightertwo.power.useHealing(weapon: fightertwo.weapon, target: fightertwo, multiTarget: tab)) !")
        print("He now has \(fightertwo.lifePoints) life points.")
    }

    else
    {
        fightertwo.attack(weapon: fightertwo.weapon, target: fighterone)
    }
    
    if fightertwo.lifePoints > 0 && fighterone.lifePoints > 0
    {
        fighterone.newWeapon(caracter: fighterone)
        fightertwo.newWeapon(caracter: fightertwo)
    }
    
    if fightertwo.lifePoints <= 0 && fighterone.lifePoints <= 0
    {
        print("KKKKKKOMMENT MAIS PATRICK MAIS C'EST AMAZING \(fighterone.name) et \(fightertwo.name) sont morts tous les deux")
        print("IT'S A TIE")
    }
    
    else if fightertwo.lifePoints <= 0
    {
        print("\(fightertwo.name) est mort ! \(fighterone.name) wins, avec \(fighterone.lifePoints) life points left !")
    }
    
    else if fighterone.lifePoints <= 0
    {
        print("\(fighterone.name) est mort ! \(fightertwo.name) wins avec \(fightertwo.lifePoints) life points left !")
    }
}



