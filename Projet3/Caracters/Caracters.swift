//
//  Caracters.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

/*
 var lifePoints: Int
 var weapon : Weapons
 let name: String
 */


class Warrior: Caracters
{
    init()
    {
        super.init(lifePoints: 100, weapon: sword, name: "")
        print("Choose a name for your Warrior :")
        name = askForName()
        print("This Warrior shall be called \(name).")
    }
}

class Wizzard: Caracters
{
    init()
    {
        super.init(lifePoints: 80, weapon: staff, name: "")
        print("Choose a name for your Wizzard :")
        name = askForName()
        print("This Wizzard shall be called \(name).")
    }
}

class Dwarf: Caracters
{
    init()
    {
        super.init(lifePoints: 70, weapon: axe, name: "")
        print("Choose a name for your Dwarf :")
        name = askForName()
        print("This Dwarf shall be called \(name).")
    }
}

class Archer: Caracters
{
    init()
    {
        super.init(lifePoints: 90, weapon: bow, name: "")
        print("Choose a name for your Archer :")
        name = askForName()
        print("This Archer shall be called \(name).")
    }
}


