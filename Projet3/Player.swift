//
//  Players.swift
//  Projet3
//
//  Created by Erwan Le Querré on 26/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Player
{
    var party = [Caracter]()
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
    
    // chooseParty makes players choose and confirm a party of 3 caracters.
    
    func chooseParty(nbPlayers: Int)
    {
        var partyOK = false
        
        emptyParty()
        
        while !partyOK
        {
            intro(nbPlayers: nbPlayers)
            auto = autoSet()
            
            switch auto
            {
            case true:
                createRandParty()
            case false:
                createParty()
            }
            
            askConfirmParty()
            partyOK = doConfirmParty()

            if partyOK
            {
                wizzardSearch()
            }
        }
    }
    
    
    private func emptyParty()
    {
        if party.count > 0
        {
            for _ in 0..<party.count
            {
                party.remove(at: 0)
            }
        }
    }
    
    private func intro(nbPlayers: Int)
    {
        if nbPlayers == 1
        {
            print("\nYou will now select 3 heroes to fight for you.\n")
            sleep(1)
            print("Do you want a random party ? Y/N")
        }
        
        else
        {
            sleep(1)
            print("""
                \n\(name), it's your turn.
                You will now select 3 heroes to fight for you.\n
                """)
            usleep(15 * 100 * 1000)
            print("Do you want a random party ? Y/N")
        }
    }
    
    private func autoSet() -> Bool
    {
        var auto = true
        
        switch Support.askYN()
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
            Support.errorLog(origin: "\(#file)", detail: "\(#line)")
        }
        
        return auto
    }
    
    private func createRandParty()
    {
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
                Support.errorLog(origin: "Players", detail: "\(#line) switch")
            }
        }
    }

    private func createParty()
    {
        for i in 1...3
        {
            print("Choose your caracter n°\(i) :")
            usleep(12 * 100 * 1000)
            print("1. A Warrior. ⚔")
            print(Caracter.caracterDescription(caste: .warrior))
            usleep(10 * 100 * 1000)
            print("2. A Wizzard. 🔮")
            print(Caracter.caracterDescription(caste: .wizzard))
            usleep(10 * 100 * 1000)
            print("3. A Giant. 👹")
            print(Caracter.caracterDescription(caste: .giant))
            usleep(10 * 100 * 1000)
            print("4. A Dwarf. 🍺")
            print(Caracter.caracterDescription(caste: .dwarf))
            
            switch Support.secureInt(lowerLimit: 1, upperLimit: 4)
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
                Support.errorLog(origin: "Players", detail: "\(#line) switch")
            }
        } // for i 1...3
    }

    
    private func askConfirmParty()
    {
        usleep(1 * 100 * 1000)
        print("Your warriors has been chosen. You will fight with ")
        usleep(10 * 100 * 1000)
        for i in 1...3
        {
            switch i
            {
            case 1:
                print("\(party[i-1].name), \(party[i-1].adressCaracter(caracter: party[i-1]))")
                usleep(9 * 100 * 1000)
            case 2:
                print("\(party[i-1].name), \(party[i-1].adressCaracter(caracter: party[i-1]))")
                usleep(9 * 100 * 1000)
            case 3:
                print("and \(party[i-1].name), \(party[i-1].adressCaracter(caracter: party[i-1])).")
                usleep(9 * 100 * 1000)
            default:
                Support.errorLog(origin: "Players", detail: "Switch 'i' would not read")
            }
        }
        print("Is that correct ?\nY/N")
    }
    
    private func doConfirmParty() -> Bool
    {
        switch Support.askYN()
        {
        case "Y":
            usleep(1 * 100 * 1000)
            print("\n\tYour party has been decided. May the odds ever be with you.\n")
            usleep(20 * 100 * 1000)
            return true
        case "y":
            print("\n\tYour party has been decided. May the odds ever be with you.\n")
            usleep(10 * 100 * 1000)
            return true
        case "N":
            print("Let us try again.")
            usleep(1 * 100 * 1000)
            for _ in 0..<party.count
            {
                party.remove(at: 0)
            }
            return false
        case "n":
            print("Let us try again.")
            usleep(1 * 100 * 1000)
            for _ in 0..<party.count
            {
                party.remove(at: 0)
            }
            return false
        default:
            Support.errorLog(origin: "Players", detail: "\(#line) switch")
            return false
        }
    }
    
    private func wizzardSearch()
    {
        for i in 0..<party.count
        {
            if party[i].caste == .wizzard
            {
                (party[i] as! Wizzard).team = party
            }
        }
    }
    
}


