//
//  Game.swift
//  Projet3
//
//  Created by Erwan Le Querré on 26/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Game
{
    
    var players = [Players]()
    var keepPlaying = true
    
    func startGame() // asks for # of players, takes their names and put them in 'players'
    {
        var tryInputAgain = true
        var trySecondInputAgain = true // -> so the Y/N confirmation can be looped without asking for numberOfPlayers again
        var numberOfPlayers = 0
        
        print("How many people are playing ?")
        
        while tryInputAgain
        {
            if let input = readLine()
            {
                if let num = Int(input)
                {
                    numberOfPlayers = num
                    
                    if numberOfPlayers == 1
                    {
                        print("You want to start a game with \(numberOfPlayers) player. Is that correct ?")
                    }
                    else if numberOfPlayers == 0
                    {
                        print("You want to start a game with no player. Is that correct ?")
                    }
                    else
                    {
                        print("You want to start a game with \(numberOfPlayers) players. Is that correct ?")
                    }
                    print("Y/N")
                    
                    trySecondInputAgain = true
                    
                    while tryInputAgain && trySecondInputAgain
                    {
                        if let input = readLine()
                        {
                            print("\n")
                            switch input
                            {
                            case "Y":
                                tryInputAgain = false
                                trySecondInputAgain = false
                            case "y":
                                tryInputAgain = false
                                trySecondInputAgain = false
                            case "N":
                                print("Please try again. How many players ?")
                                trySecondInputAgain = false
                            case "n":
                                print("Please try again. How many players ?")
                                trySecondInputAgain = false
                            default:
                                print("Entry could not be read. Please try again.")
                            }
                        }
                        else
                        {
                            print("Entry could not be read. Please try again.")
                        }
                    } // while trySecondInputAgain (-> Y/N confirmation)
                    
                } // if let num = Int(input)
                else
                {
                    print("Entry could not be read. Please try again.\nHow many players ?")
                }
                
            } // if let input = readLine (-> numberOfPlayers)
            else
            {
                print("Entry could not be read. Please try again.")
                print("How many people are playing ?")
            }
        } // while tryInputAgain
        
        if numberOfPlayers == 0
        {
            print("Game will not be launched without players.")
        }
        else if numberOfPlayers == 1
        {
            print("What is your name ?")
            if let name = readLine()
            {
                print("\n")
                players.append(Players(name: name))
            }
            print("There are no opponents to fight. \(players[0].name) wins by default !")
            print("Yay, i guess ! 🎈")
            
            exit(0)
        }
        else
        {
            print("Please enter the names of the players.")
            
            for i in 1...numberOfPlayers
            {
                tryInputAgain = true
                
                print("Enter name of Player\(i) :")
                
                while tryInputAgain
                {
                    if let name = readLine()
                    {
                        print("\n")
                        players.append(Players(name: name))
                        tryInputAgain = false
                    }
                    else
                    {
                        print("\n")
                        print("Problème avec l'entrée du nom. Merci de réessayer.")
                    }
                }
            }
        }
        
///////////////////////////////////////
        // MARK: PLAYERS OK
        // At this point, players have been registrated in players[]
        
        for i in 0..<players.count
        {
            players[i].chooseParty()
        }
        
        
    } // stargame()
}

