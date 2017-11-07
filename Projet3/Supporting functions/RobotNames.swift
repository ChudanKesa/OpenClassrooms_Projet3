//
//  RobotNames.swift
//  Projet3
//
//  Created by Erwan Le Querré on 06/11/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

extension Support
{
    static func robotNames() -> String
    {
        var name = ""
        var names = ["Tachikomas",
                     "GERTY",
                     "Talos",
                     "Hadaly",
                     "Chip",
                     "SHROUD",
                     "SHOCK",
                     "Elio",
                     "Life Emulation Android",
                     "Copper",
                     "Wired",
                     "Systematic Destriction Watchamacallit",
                     "Tactical Eliminator",
                     "Wall-G",
                     "Automatic Slicing Self-Moving Device",
                     "QTP",
                     "Tim",
                     "Neohuman",
                     "Plastic Replacement"]
        
        name = names[Int(arc4random_uniform(UInt32(names.count)))]
        
        
        return name
    }
}

