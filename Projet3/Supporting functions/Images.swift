//
//  LifePoints.swift
//  Projet3
//
//  Created by Erwan Le Querré on 29/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

extension Caracters
{
    func lifeBar(caracter: Caracters)
    {
        var total = 0
        var sign = "⚔"
        
        switch caracter.caste
        {
        case .warrior:
            total = 100
            sign = "⚔"
        case .wizzard:
            total = 90
            sign = "🔮"
        case .giant:
            total = 210
            sign = "👹"
        case .dwarf:
            total = 70
            sign = "🍺"
        default:
            Support.errorLog(origin: "Images", detail: "switch caracter.caste")
        }
        
        let actualLife = (((caracter.lifePoints)*100)/total)/2
        
        switch actualLife
        {
        case 1:
            print("   __________________________________________________")
            print("\(sign) |")
            print("   --------------------------------------------------")
        
        case 0:
            print("   __________________________________________________")
            print(sign)
            print("   --------------------------------------------------")
            
        default:
            print("   __________________________________________________")
            print(sign, terminator: " ")
            for _ in 1...actualLife
            {
                print("|", terminator: "")
            }
            print("")
            print("   --------------------------------------------------")
        }
        
        print("\n", terminator: "")
        
    } // func
    
//------------------------------------
    
    func symbol(caste: Caracters)
    {
        switch caste.caste
        {
        case .warrior:
            print("⚔", terminator: "")
        case .wizzard:
            print("🔮", terminator: "")
        case .giant:
            print("👹", terminator: "")
        case .dwarf:
            print("🍺", terminator: "")
        default:
            Support.errorLog(origin: "Images", detail: "func symbol -> switch")
        }
    }
    
//------------------------------------
    
    func percent(life: Caracters) -> String
    {
        let percent = life.lifePoints * 100 / life.maxLifePoints
        return "\(percent)%"
    }
    
    
    
} // extension Caracters


