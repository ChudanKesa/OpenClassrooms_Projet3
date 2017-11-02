//
//  SafeReadLine().swift
//  Projet3
//
//  Created by Erwan Le Querré on 29/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation


func askForInt(lowerLimit: Int, upperLimit: Int) -> Int
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
    
    func askForString() -> String
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

    func askYN() -> String
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

    func secureInt(lowerLimit: Int, upperLimit: Int) -> Int
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

func cheat() // now that the game works and i just have to change a few minor things, testing is WAY TOO LONG
{
    print("*************************")
    print("\tWELCOME to the cheat area.\n")

    
    var tab = [Caracters]()
    var select = Int()
    var alsoselect = Int()
    var number = 1

        print("Wich caracter shall we modify ?")
        for i in 0..<game.players.count
        {
            for j in 0..<game.players[i].party.count
            {
                print("\(number). \(game.players[i].name)'s \(game.players[i].party[j].adressCaracter(caracter: game.players[i].party[j]))")
                tab.append(game.players[i].party[j])
                number += 1
            }
        }
        
        print("tab.count = \(tab.count)")
        select = askForInt(lowerLimit: 1, upperLimit: tab.count)
        print("How many LP do you want ?")
        alsoselect = askForInt(lowerLimit: 0, upperLimit: 1000)
        
        tab[select - 1].lifePoints = alsoselect
        
        print("\n\tDone.\n")
}


