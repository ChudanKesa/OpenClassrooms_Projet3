//
//  Players.swift
//  Projet3
//
//  Created by Erwan Le Querré on 26/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Players
{
    var party = [Caracters]()
    var defeat = false
    var name: String
    
    init(name: String)
    {
        self.name = name
    }
    
    //////////////////////////////////////////////////////////
    // MARK: METHODS
    //////////////////////////////////////////////////////////
    
    func chooseParty()
    {
        var entryOK = false
        var partyOK = false
        
        while !partyOK
        {
            print("\n\(name), it's your turn.")
            print("You will now select 3 heroes to fight for you.\n")
            
            for i in 1...3
            {
                entryOK = false
                
                print("Choose your caracter n°\(i) :")
                print("1. A Warrior. ⚔")
                print(Caracters.caracterDescription(caste: .warrior))
                print("2. A Wizzard. ⚕")
                print(Caracters.caracterDescription(caste: .wizzard))
                print("3. A Giant. 👹")
                print(Caracters.caracterDescription(caste: .giant))
                print("4. A Dwarf. 🍺")
                print(Caracters.caracterDescription(caste: .dwarf))
                
                while !entryOK
                {
                    if let read = readLine()
                    {
                        if let choice = Int(read)
                        {
                            switch choice
                            {
                            case 1:
                                party.append(Warrior())
                                entryOK = true
                            case 2:
                                party.append(Wizzard())
                                entryOK = true
                            case 3:
                                party.append(Giant())
                                entryOK = true
                            case 4:
                                party.append(Dwarf())
                                entryOK = true
                            default:
                                print("Entry could not be read. Please try again.")
                            }
                        }
                        else
                        {
                            print("Entry could not be read. Please try again.")
                        }
                    }
                }
            } // for i 1...3
            
            print("Your warriors has been chosen. You will fight with ")
            for i in 1...3
            {
                switch i
                {
                case 1:
                    print("\(party[i-1].name), \(party[i-1].adressCaracter(caracter: party[i-1]))")
                case 2:
                    print("\(party[i-1].name), \(party[i-1].adressCaracter(caracter: party[i-1]))")
                case 3:
                    print("and \(party[i-1].name), \(party[i-1].adressCaracter(caracter: party[i-1])).")
                default:
                    errorLog(origin: "Players", detail: "Switch 'i' would not read")
                }
            }
            print("Is that correct ?")
            print("Y/N")
            
            entryOK = false
            
            while !entryOK
            {
                if let read = readLine()
                {
                    switch read
                    {
                    case "Y":
                        print("Your party has been decided. May the odds ever be with you.")
                        entryOK = true
                        partyOK = true
                    case "y":
                        print("Your party has been decided. May the odds ever be with you.")
                        entryOK = true
                        partyOK = true
                    case "N":
                        print("Let us try again.")
                        entryOK = true
                    case "n":
                        print("Let us try again.")
                        entryOK = true
                    default:
                        print("Entry could not be read. Please try again.")
                    }
                }
                else
                {
                    print("Entry could not be read. Please try again.")
                }
            }
            
        } // while !partyOK
    } // func chooseParty
    
}

