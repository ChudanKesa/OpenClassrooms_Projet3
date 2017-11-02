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
            
            exit(0)
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
    
    func playGame(players: [Players])
    {
        var powerPresent = false
        var numberOfPowers = 0
        var powerPosition = [Int]()
        
        var target: Caracters
        var targetsRepository = [Caracters]()
        
        var totalEnnemiesLeft = Int()
        var totalAlliesLeft = Int()
        
        var deceased = [(Int, Int)]()
        
        var select = 0 // value will be used for whatever needs and Int as an answer
        var alsoselect = 0 // turns out i need two
        
        
        for i in 0..<players.count
        {
            totalEnnemiesLeft = 0
            
            for t in 0..<players.count
            {
                if t != i
                {
                    totalEnnemiesLeft += players[t].party.count
                }
                if t == i
                {
                    totalAlliesLeft = players[t].party.count
                }
            }
            
            
            if totalEnnemiesLeft >= 1 && totalAlliesLeft > 0
            {
                powerPresent = false
                numberOfPowers = 0
                for _ in 0..<powerPosition.count
                {
                    powerPosition.remove(at: 0)
                }
                
                for j in 0..<players[i].party.count
                {
                    if players[i].party[j] is Wizzard
                    {
                        powerPresent = true
                        numberOfPowers += 1
                        powerPosition.append(j)
                    }
                }
                print("\(players[i].name), it's your turn.")
                if powerPresent == true
                {
                    print("What will you do ?")
                    print("1. Attack")
                    print("2. Use power")
                    
                    select = secureInt(lowerLimit: 1, upperLimit: 2)
                    
                    switch select
                    {
                    case 1:
                        if players[i].party.count > 1
                        {
                            print("Choose who is going to attack :")
                            
                            
                            for j in 0..<players[i].party.count
                            {
                                print("\(j+1).", terminator: " "); players[i].party[j].symbol(caste: players[i].party[j]); print(" \(players[i].party[j].name)")
                            }
                            
                            select = secureInt(lowerLimit: 1, upperLimit: players[i].party.count)
                        }
                            
                        else
                        {
                            select = 1
                            switch players[i].lastOneStanding
                            {
                            case true:
                                print("\(players[i].party[0].name) gives everything he has left !")
                            case false:
                                print("\(players[i].party[0].name) attacks !")
                            }
                        }
                        
                        if totalEnnemiesLeft == 1
                        {
                            switch i
                            {
                            case 0:
                                target = players[1].party[0]
                            case 1:
                                target = players[0].party[0]
                            default:
                                errorLog(origin: "\(#file)", detail: "\(#line)")
                                exit(1)
                            }
                        }
                            
                        else
                        {
                            print("Choose your target :")
                            for j in 0..<players.count
                            {
                                for y in 0..<players[j].party.count
                                {
                                    if j != i
                                    {
                                        if players.count > 2
                                        {
                                            targetsRepository.append(players[j].party[y])
                                            print("\(targetsRepository.count). \(players[j].name)'s \(players[j].party[y].name)", terminator: " "); players[j].party[y].symbol(caste: players[j].party[y]); print(players[j].party[y].percent(life: players[j].party[y]))
                                        }
                                        else
                                        {
                                            targetsRepository.append(players[j].party[y])
                                            print("\(targetsRepository.count). \(players[j].party[y].name)", terminator: " "); players[j].party[y].symbol(caste: players[j].party[y]); print(players[j].party[y].percent(life: players[j].party[y]))
                                        }
                                    }
                                }
                            }
                            
                            alsoselect = secureInt(lowerLimit: 1, upperLimit: targetsRepository.count)
                            target = targetsRepository[alsoselect-1]
                        }
                        
                        players[i].party[select-1].attack(weapon: players[i].party[select-1].weapon, target: target)
                        
                        for _ in 0..<targetsRepository.count
                        {
                            targetsRepository.remove(at: 0)
                        }
                        
                    case 2:
                        if numberOfPowers == 1
                        {
                            if players[i].party[powerPosition[0]] is Wizzard
                            {
                                if players[i].party[powerPosition[0]].weapon.name == "Long staff"
                                {
                                    print("Thanks to his Long staff, \(players[i].party[powerPosition[0]].name) will heal the entire party !")
                                    (players[i].party[powerPosition[0]] as! Wizzard).power.multHealing(target: players[i].party)
                                    print("\tThe party got healed !")
                                    for y in 0..<players[i].party.count
                                    {
                                        print("\(players[i].party[y].name) has \(players[i].party[y].lifePoints) life points.")
                                        players[i].party[y].symbol(caste: players[i].party[y]); print("")
                                    }
                                }
                                else
                                {
                                    print("Who do you want to heal ?")
                                    for y in 0..<players[i].party.count
                                    {
                                        print("\(y+1). \(players[i].party[y].name)", terminator: " "); players[i].party[y].symbol(caste: players[i].party[y]); print(players[i].party[y].percent(life: players[i].party[y]))
                                    }
                                    select = secureInt(lowerLimit: 1, upperLimit: players[i].party.count)
                                    target = players[i].party[select-1]
                                    print("\(players[i].party[powerPosition[0]].name) uses \((players[i].party[powerPosition[0]] as! Wizzard).power.useHeal(target: target)) on \(target.name) !")
                                    print("\(target.name) has \(target.lifePoints) life points.")
                                    target.lifeBar(caracter: target)
                                }
                            } // if caracter is Wizzard -> useless for now but will be used when powers are added
                            
                        } // if numberOfPower == 1
                        else
                        {
                            print("Choose who is going to use a power :")
                            for y in 0..<powerPosition.count
                            {
                                print("\(y+1).", terminator:" "); players[i].party[powerPosition[y]].symbol(caste: players[i].party[powerPosition[y]]); print(" \(players[i].party[powerPosition[y]].name)")
                            }
                            select = secureInt(lowerLimit: 1, upperLimit: powerPosition.count)
                            select = powerPosition[select-1]
                            
                            switch players[i].party[select]
                            {
                            case is Wizzard:
                                if players[i].party[select].weapon.name == "Long staff"
                                {
                                    print("Thanks to his Long staff, \(players[i].party[select].name) will heal the entire party !")
                                    (players[i].party[select] as! Wizzard).power.multHealing(target: players[i].party)
                                    print("\tThe party got healed !")
                                    for y in 0..<players[i].party.count
                                    {
                                        print("\(players[i].party[y].name) has \(players[i].party[y].lifePoints) life points.")
                                        players[i].party[y].symbol(caste: players[i].party[y]); print("")
                                    }
                                }
                                else
                                {
                                    print("Who do you want to heal ?")
                                    for y in 0..<players[i].party.count
                                    {
                                        print("\(y+1). \(players[i].party[y].name)", terminator: " "); players[i].party[y].symbol(caste: players[i].party[y]); print(players[i].party[y].percent(life: players[i].party[y]))
                                    }
                                    alsoselect = secureInt(lowerLimit: 1, upperLimit: players[i].party.count)
                                    target = players[i].party[alsoselect-1]
                                    print("\(players[i].party[select].name) uses \((players[i].party[select] as! Wizzard).power.useHeal(target: target)) on \(target.name) !")
                                    print("\(target.name) has \(target.lifePoints) life points.")
                                    target.lifeBar(caracter: target)
                                }
                            default:
                                errorLog(origin: "Game", detail: "l.\(#line) : power choice")
                            }
                            
                        }
                    default:
                        errorLog(origin: "Game", detail: "l.178 : 'select' error")
                    }
                    
                } // if powerPresent
                else
                {
                    if players[i].party.count > 1
                    {
                        print("Choose who is going to attack :")
                        
                        for t in 0..<players.count
                        {
                            if t != i
                            {
                                totalEnnemiesLeft += players[t].party.count
                            }
                        }
                        
                        for j in 0..<players[i].party.count
                        {
                            print("\(j+1).", terminator: " "); players[i].party[j].symbol(caste: players[i].party[j]); print(" \(players[i].party[j].name)")
                        }
                        
                        select = secureInt(lowerLimit: 1, upperLimit: players[i].party.count)
                    }
                        
                    else
                    {
                        select = 1
                        switch players[i].lastOneStanding
                        {
                        case true:
                            print("\(players[i].party[0].name) gives everything he has left !")
                        case false:
                            print("\(players[i].party[0].name) attacks !")
                        }
                    }
                    
                    if totalEnnemiesLeft == 1
                    {
                        switch i
                        {
                        case 0:
                            target = players[1].party[0]
                        case 1:
                            target = players[0].party[0]
                        default:
                            errorLog(origin: "\(#file)", detail: "\(#line)")
                            exit(1)
                        }
                    }
                        
                    else
                    {
                        print("Choose your target :")
                        for j in 0..<players.count
                        {
                            for y in 0..<players[j].party.count
                            {
                                if j != i
                                {
                                    if players.count > 2
                                    {
                                        targetsRepository.append(players[j].party[y])
                                        print("\(targetsRepository.count). \(players[j].name)'s \(players[j].party[y].name)", terminator: " "); players[j].party[y].symbol(caste: players[j].party[y]); print(players[j].party[y].percent(life: players[j].party[y]))
                                    }
                                    else
                                    {
                                        targetsRepository.append(players[j].party[y])
                                        print("\(targetsRepository.count). \(players[j].party[y].name)", terminator: " "); players[j].party[y].symbol(caste: players[j].party[y]); print(players[j].party[y].percent(life: players[j].party[y]))
                                    }
                                }
                            }
                        }
                        
                        alsoselect = secureInt(lowerLimit: 1, upperLimit: targetsRepository.count)
                        target = targetsRepository[alsoselect-1]
                    }
                    
                    players[i].party[select-1].attack(weapon: players[i].party[select-1].weapon, target: target)
                    
                    
                    for _ in 0..<targetsRepository.count
                    {
                        targetsRepository.remove(at: 0)
                    }
                } // if !powerPresent
                
                for l in 0..<players.count
                {
                    if players[l].party.count == 1 && players[l].party[0].lifePoints == 0
                    {
                        switch players[l].lastOneStanding
                        {
                        case true:
                            players[l].lastOneStanding = false
                        case false:
                            players[l].lastOneStanding = true
                        }
                    }
                }
                
                for e in 0..<players.count
                {
                    for j in 0..<players[e].party.count
                    {
                        if players[e].party[j].lifePoints == 0
                        {
                            if !players[e].lastOneStanding
                            {
                                switch Int(arc4random_uniform(UInt32(6)))
                                {
                                case 0:
                                    print("Tough luck for \(players[e].name) ! \(players[e].party[j].name) just died !\n")
                                case 1:
                                    print("Sorry, \(players[e].name) ! \(players[e].party[j].name) did his best.\n")
                                case 2:
                                    print("One warrior down : \(players[e].party[j].name) left the game.\n")
                                case 3:
                                    print("\(players[e].name) will have to do with one less player !\n")
                                case 4:
                                    print("\(players[e].party[j].name) down ! How will \(players[e].name) react ?\n")
                                default:
                                    print("\(players[e].party[j].name) left this world...\n")
                                }
                                deceased.append((e, j))
                            }
                            else
                            {
                                print("Oh no ! \(players[e].party[0].name) is dying !")
                                print("He muster the strenght for one last strike !")
                            }
                        }
                    }
                }
                if deceased.count >= 1
                {
                    for t in (0..<deceased.count).reversed()
                    {
                        players[deceased[t].0].party.remove(at: deceased[t].1)
                    }
                }
            } // if totalEnnemies >= 1
            
        } // for i in 0_players.count
    }
    
    
    ///////////////////////////////////////
    // MARK: ATTACK PATTERN OK
    // -> Every player in players has an action once
    
    func finishGame(tab: [Players])
    {
        var players = tab
        var victory = false
        
        
        while !victory
        {
            playGame(players: players)
            
            for i in 0..<players.count
            {
                if players[i].party.count == 0
                {
                    print("\(players[i].name)'s party was defeated...")
                    print("\(players[i].name) lost.")
                    players.remove(at: i)
                }
            }
            
            if players.count == 1
            {
                print(" **\\o/**\\o/**\\o/**\\o/**")
                print("\tCongratulations, \(players[0].name) ! You vanquished your opponents. This game is yours !")
                victory = true
            }
        }
    }
    
    
} // class


