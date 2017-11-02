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
    var lastOneStanding = false
    var name: String
    
    var auto = false

    init(name: String)
    {
        self.name = name
    }
    
    //////////////////////////////////////////////////////////
    // MARK: METHODS
    //////////////////////////////////////////////////////////
    
    func chooseParty()
    {
        var partyOK = false
        
        if party.count > 0
        {
            for _ in 0..<party.count
            {
                party.remove(at: 0)
            }
        }
        
        while !partyOK
        {
            sleep(1)
            print("\n\(name), it's your turn.")
            sleep(1)
            print("You will now select 3 heroes to fight for you.\n")
            sleep(1)
            
            print("Do you want a random party ? Y/N")
            
            switch askYN()
            {
            case "y":
                auto = true
            case "Y":
                auto = true
            case "n":
                auto = false
            case "N":
                auto = false
            default:
                errorLog(origin: "\(#file)", detail: "\(#line)")
            }
            
            switch auto
            {
            case true:
                for _ in 1...3
                {
                    switch Int(arc4random_uniform(UInt32((4)))) + 1
                    {
                        case 1:
                            party.append(Warrior(auto: true))
                        case 2:
                            party.append(Wizzard(auto: true))
                        case 3:
                            party.append(Giant(auto: true))
                        case 4:
                            party.append(Dwarf(auto: true))
                        default:
                            errorLog(origin: "Players", detail: "\(#line) switch")
                    }
                }
            case false:
                for i in 1...3
                {
                    print("Choose your caracter n°\(i) :")
                    print("1. A Warrior. ⚔")
                    print(Caracters.caracterDescription(caste: .warrior))
                    print("2. A Wizzard. 🔮")
                    print(Caracters.caracterDescription(caste: .wizzard))
                    print("3. A Giant. 👹")
                    print(Caracters.caracterDescription(caste: .giant))
                    print("4. A Dwarf. 🍺")
                    print(Caracters.caracterDescription(caste: .dwarf))
                    
                    switch secureInt(lowerLimit: 1, upperLimit: 4)
                    {
                    case 1:
                        party.append(Warrior())
                    case 2:
                        party.append(Wizzard())
                    case 3:
                        party.append(Giant())
                    case 4:
                        party.append(Dwarf())
                    default:
                        errorLog(origin: "Players", detail: "\(#line) switch")
                    }
                } // for i 1...3
            }
            
            
            
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
            
            switch askYN()
            {
            case "Y":
                print("\tYour party has been decided. May the odds ever be with you.\n")
                partyOK = true
            case "y":
                print("\n\tYour party has been decided. May the odds ever be with you.\n")
                partyOK = true
            case "N":
                print("Let us try again.")
                for _ in 0..<party.count
                {
                    party.remove(at: 0)
                }
            case "n":
                print("Let us try again.")
                for _ in 0..<party.count
                {
                    party.remove(at: 0)
                }
            default:
                errorLog(origin: "Players", detail: "\(#line) switch")
            }

            
            if partyOK
            {
                for i in 0..<party.count
                {
                    if party[i].caste == .wizzard
                    {
                        (party[i] as! Wizzard).team = party
                    }
                }
            }
            
        } // while !partyOK
    } // func chooseParty
    
}

