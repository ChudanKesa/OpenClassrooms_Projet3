//
//  SafeReadLine().swift
//  Projet3
//
//  Created by Erwan Le Querré on 29/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


extension Support
{
    static func askForInt(lowerLimit: Int, upperLimit: Int) -> Int
    {
        var error = true
        
        var retour = 0
        
        while error
        {
            if let read = readLine()
            {
                if let number = Int(read)
                {
                    retour = number
                        
                    if retour < lowerLimit || retour > upperLimit
                    {
                        print("Entry did not fit proposed choices. Please try again.")
                    }
                    else
                    {
                        error = false
                    }
                }
                    
                else
                {
                    print("Problem with entry. Please try again.")
                }
            }
                
            else
            {
                print("Problem with entry. Please try again.")
            }
        }
        
        return retour
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    static func askForString() -> String
    {
        var error = true
        
        var retour = ""
        
        while error
        {
            if let read = readLine()
            {
                retour = read
                error = false
            }
                
            else
            {
                print("Problem with entry. Please try again.")
            }
        }
        
        return retour
    }
    
    ///////////////////////////////////////////////////////////////////////////////////// automatic control for Y/N situations
    
    static func askYN() -> String
    {
        var error = true
        var retour = ""
        
        while error
        {
            if let read = readLine()
            {
                
                if read == ""
                {
                    retour = "y"
                }
                else
                {
                    retour = read
                }
                
                if retour == "123456"
                {
                    cheat()
                    print("We were trying to confirm something. Let's do that again.")
                }
                    
                else if retour == "n" || retour == "N" || retour == "y" || retour == "Y"
                {
                    error = false
                }
                else
                {
                    print("Wrong imput. Please try again.")
                }
            }
            else
            {
                print("Problem with entry. Please try again.")
            }
        }
        
        return retour
    }
    
    ///////////////////////////////////////////////////////////////////////////////////// the one to use when asking for Int
    
    static func secureInt(lowerLimit: Int, upperLimit: Int) -> Int
    {
        var secondEntry = true
        var select = Int()
        
        while secondEntry
        {
            select = askForInt(lowerLimit: lowerLimit, upperLimit: upperLimit)
            print("Are you sure ? Y/N")
            switch askYN()
            {
            case "Y":
                secondEntry = false
            case "y":
                secondEntry = false
            case "N":
                print("Please try again.")
            case "n":
                print("Please try again.")
            default:
                errorLog(origin: "Game", detail: "\(#line) : switch")
            }
        }
        
        return select
    }
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    static func cheat() // now that the game works and i just have to change a few minor things, testing is WAY TOO LONG
    {
        print("*************************")
        print("\tWELCOME to the cheat area.\n")
        
        
        var tab = [Caracters]()
        var select = Int()
        var alsoselect = Int()
        var number = 1
        
        if game.players.count == 1
        {
            print("\n\tNothing to be done.\n")
        }
        
        else
        {
            print("Wich caracter's life shall we modify ?")
            for i in 0..<game.players.count
            {
                for j in 0..<game.players[i].party.count
                {
                    print("\(number). \(game.players[i].name)'s \(game.players[i].party[j].caste.rawValue) : \(game.players[i].party[j].name)", terminator: " "); game.players[i].party[j].symbol(caste: game.players[i].party[j]); print("")
                    tab.append(game.players[i].party[j])
                    number += 1
                }
            }
            
            select = askForInt(lowerLimit: 1, upperLimit: tab.count)
            print("How many LP do you want ?")
            alsoselect = askForInt(lowerLimit: 0, upperLimit: 1000)
            
            tab[select - 1].lifePoints = alsoselect
            
            print("\n\tDone.\n")
        }
    }


    /////////////////////////////////////////////////////////////////////////////////////
    // adapting the cheat to 1P mode turned out harder than expected. A new function seemed like the right way to go.
    
    
    static func cheat1P(robotFighters: [Caracters]) -> Int
    {
        var select = Int()
        
        if let read = readLine()
        {
            if var number = Int(read)
            {
                if number == 123456
                {
                    while number == 123456
                    {
                        print("Wich caracter's life shall we modify ?")
                        for i in 0..<robotFighters.count
                        {
                            print("\(i+1). \(robotFighters[i].name)", terminator: ""); robotFighters[i].symbol(caste: robotFighters[i]); print("\n", terminator: "")
                        }
                        
                        number = Support.secureInt(lowerLimit: 1, upperLimit: robotFighters.count)
                        
                        print("How many life points ?")
                        
                        robotFighters[number-1].lifePoints = Support.secureInt(lowerLimit: 0, upperLimit: 10000)
                        
                        print("\n\tDone.\n1. Attack\n2. Use power")
                        
                        number = Support.secureInt(lowerLimit: 1, upperLimit: 3)
                        if number == 3
                        {
                            number = 123456
                        }
                        else
                        {
                            select = number
                        }
                    }
                }
                    
                else
                {
                    select = number
                }
            }
        }
            
        else
        {
            print("Problem with entry. Please try again.")
            select = Support.secureInt(lowerLimit: 1, upperLimit: 2)
        }
        
        return select
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    static func cheat1P(robotFighters: [Caracters], lowerLimit: Int, upperLimit: Int) -> Int
    {
        var select = Int()
        
        if let read = readLine()
        {
            if var number = Int(read)
            {
                if number == 123456
                {
                    while number == 123456
                    {
                        print("Wich caracter's life shall we modify ?")
                        for i in 0..<robotFighters.count
                        {
                            print("\(i+1). \(robotFighters[i].name)", terminator: ""); robotFighters[i].symbol(caste: robotFighters[i]); print("\n", terminator: "")
                        }
                        
                        number = Support.secureInt(lowerLimit: 1, upperLimit: robotFighters.count)
                        
                        print("How many life points ?")
                        
                        robotFighters[number-1].lifePoints = Support.secureInt(lowerLimit: 0, upperLimit: 10000)
                        
                        print("\n\tDone.\nWho is going to attack ?\n")
                        
                        number = Support.secureInt(lowerLimit: lowerLimit, upperLimit: upperLimit + 1)
                        if number == upperLimit + 1
                        {
                            number = 123456
                        }
                        else
                        {
                            select = number
                        }
                    }
                }
                    
                else
                {
                    select = number
                }
            }
        }
            
        else
        {
            print("Problem with entry. Please try again.")
            select = Support.secureInt(lowerLimit: lowerLimit, upperLimit: upperLimit)
        }
        
        return select
    }

} // Support
