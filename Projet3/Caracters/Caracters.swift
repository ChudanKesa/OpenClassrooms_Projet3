//
//  Caracters.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


/*
 let warrior = Caracters()
 let wizzard = Caracters()
 let dwarf = Caracters()
 let archer = Caracters()
 */

class Warrior: Caracters
{
    init()
    {
        super.init(lifePoints: 100, weapon: sword)
    }
}

class Wizzard: Caracters
{
    init()
    {
        super.init(lifePoints: 80, weapon: staff)
    }
}

class Dwarf: Caracters
{
    init()
    {
        super.init(lifePoints: 70, weapon: axe)
    }
}

class Archer: Caracters
{
    init()
    {
        super.init(lifePoints: 90, weapon: bow)
    }
}


