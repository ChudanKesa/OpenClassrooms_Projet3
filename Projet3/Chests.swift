//
//  Chests.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


let weaponsToBeFound: [Weapons] = [axe, sword, bow, staff]

func openChest(warrior: Caracters) -> Weapons
{
    let found = Int(arc4random_uniform(UInt32(5)))
    
    return weaponsToBeFound[found]
}

