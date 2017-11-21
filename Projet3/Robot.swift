//
//  File.swift
//  Projet3
//
//  Created by Erwan Le Querré on 06/11/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Robot // IA fighting. Nothing more than a player that gets everything choosen automatically.
{
    var name: String // <- this to compare with players[0].name and make sure they're the same
    var robotFighters = [Caracter]()
    
    init()
    {
        print("You will fight against an IA. What is your name ?")
        name = Support.askForString()
        game.players.append(Player(name: name))
            if name != game.players[0].name
            {
                Support.errorLog(origin: "\(#file)", detail: "\(#line) : error registering player")
                print("Name should be : \(name)")
                print("Name is : \(game.players[0].name)")
                print("\n")
                exit(1)
            }
        game.players[0].chooseParty(nbPlayers: 1)
        
        robotFighters.append(Wizzard(robot: Support.robotNames()))
        
        
        switch Int(arc4random_uniform(UInt32(4)))
        {
        case 0:
            robotFighters.append(Warrior(robot: Support.robotNames()))
        case 1:
            robotFighters.append(Wizzard(robot: Support.robotNames()))
            robotFighters.append(Dwarf(robot: Support.robotNames()))
        case 2:
            robotFighters.append(Giant(robot: Support.robotNames()))
        case 3:
            robotFighters.append(Dwarf(robot: Support.robotNames()))
        default:
            Support.errorLog(origin: "\(#file)", detail: "\(#line)")
        }
        
        if robotFighters.count < 3
        {
            switch Int(arc4random_uniform(UInt32(3)))
            {
            case 0:
                robotFighters.append(Warrior(robot: Support.robotNames()))
            case 1:
                robotFighters.append(Dwarf(robot: Support.robotNames()))
            case 2:
                robotFighters.append(Giant(robot: Support.robotNames()))
            default:
                Support.errorLog(origin: "\(#file)", detail: "\(#line)")
            }
        }
        
        print("Your opponent is ready. You will fight")
        for i in 0..<robotFighters.count
        {
            print("\(i+1). \(robotFighters[i].name), \(robotFighters[i].adressCaracter(caracter: robotFighters[i]))")
            usleep(15 * 100 * 1000)
        }
        print("\n")
        
    }
        // ↓ alternating between player and IA turns until one looses
    
    func battle()
    {
        while game.players[0].party.count > 0 && robotFighters.count > 0
        {
            playerTurn()
            if robotFighters.count > 0
            {
                robotTurn()
            }
        }
        
        if game.players[0].party.count - robotFighters.count > 1
        {
            Support.slowWriting(sentence: "Congratulations, \(game.players[0].name) !")
            print("You just defeated the robot army !")
            sleep(1)
            game.players.remove(at: 0)
        }
        else if game.players[0].party.count - robotFighters.count < 1
        {
            Support.slowWriting(sentence: "...\n\(game.players[0].name) has been defeated...\nRobot army wins...\n")
            game.players.remove(at: 0)
            for _ in 0..<robotFighters.count
            {
                robotFighters.remove(at: 0)
            }
        }
        else
        {
            Support.slowWriting(sentence: "In a mighty fight that will echo through the ages, both army crushed each other.")
        }
    }
    
    // ↓ player chooses whether to attack, use power, and who to attack. Function also checks whoever is dead.
    
    func playerTurn()
    {
        var powerPresent = false
        var numberOfPowers = 0
        var powerPosition = [Int]()
        
        var target: Caracter
        var targetsRepository = [Caracter]()
        
        var totalEnnemiesLeft = Int()
        var totalAlliesLeft = Int()
        
        var deceased = [(Int, Int)]()
        var removal = [Int]()
        
        var select = 0 // value will be used for whatever needs and Int as an answer
        var alsoselect = 0 // turns out i need two
        
        totalEnnemiesLeft = robotFighters.count
        totalAlliesLeft = game.players[0].party.count
        
        
        if totalEnnemiesLeft >= 1 && totalAlliesLeft > 0
        {
            powerPresent = false
            numberOfPowers = 0
            for _ in 0..<powerPosition.count
            {
                powerPosition.remove(at: 0)
            }
            
            for j in 0..<game.players[0].party.count
            {
                if game.players[0].party[j] is Wizzard
                {
                    powerPresent = true
                    numberOfPowers += 1
                    powerPosition.append(j)
                }
            }
            print("\(game.players[0].name), it's your turn.")
            usleep(1 * 100 * 1000)
            if powerPresent == true
            {
                print("""
                What will you do ?
                1. Attack
                2. Use power
                """)
                
                select = Support.cheat1P(robotFighters: robotFighters)
                
                switch select
                {
                case 1:
                    if game.players[0].party.count > 1
                    {
                        print("Choose who is going to attack :")
                        
                        
                        for j in 0..<game.players[0].party.count
                        {
                            print("\(j+1).", terminator: " "); game.players[0].party[j].symbol(caste: game.players[0].party[j]); print(" \(game.players[0].party[j].name)")
                        }
                        
                        select = Support.secureInt(lowerLimit: 1, upperLimit: game.players[0].party.count)
                    }
                        
                    else
                    {
                        select = 1
                        switch game.players[0].lastOneStanding
                        {
                        case true:
                            print("\(game.players[0].party[0].name) gives everything he has left !")
                        case false:
                            print("\(game.players[0].party[0].name) attacks !")
                        }
                    }
                    
                    if totalEnnemiesLeft == 1
                    {
                        target = robotFighters[0]
                    }
                        
                    else
                    {
                        print("Choose your target :")
                        usleep(1 * 100 * 1000)
                        for y in 0..<robotFighters.count
                        {
                            targetsRepository.append(robotFighters[y])
                            print("\(targetsRepository.count). \(robotFighters[y].name)", terminator: " "); robotFighters[y].symbol(caste: robotFighters[y]); print(robotFighters[y].percent(life: robotFighters[y]))
                            usleep(1 * 100 * 1000)
                        }
                        
                        alsoselect = Support.secureInt(lowerLimit: 1, upperLimit: targetsRepository.count)
                        target = targetsRepository[alsoselect-1]
                    }
                    
                    switch Int(arc4random_uniform(UInt32((2))))
                    {
                    case 0:
                        game.players[0].party[select-1].newWeapon(caracter: game.players[0].party[select-1])
                    case 1:
                        break
                    default:
                        Support.errorLog(origin: "\(#file)", detail: "\(#line)")
                    }
                    
                    game.players[0].party[select-1].attack(weapon: game.players[0].party[select-1].weapon, target: target)
                    
                    for _ in 0..<targetsRepository.count
                    {
                        targetsRepository.remove(at: 0)
                    }
                    
                case 2:
                    if numberOfPowers == 1
                    {
                        if game.players[0].party[powerPosition[0]] is Wizzard
                        {
                            if game.players[0].party[powerPosition[0]].weapon.name == "Long staff"
                            {
                                print("Thanks to his Long staff, \(game.players[0].party[powerPosition[0]].name) will heal the entire party !")
                                usleep(5 * 100 * 1000)
                                (game.players[0].party[powerPosition[0]] as! Wizzard).power.multHealing(target: game.players[0].party)
                                print("\tThe party got healed !")
                                usleep(1 * 100 * 1000)
                                for y in 0..<game.players[0].party.count
                                {
                                    print("\(game.players[0].party[y].name) has \(game.players[0].party[y].lifePoints) life points.")
                                    game.players[0].party[y].symbol(caste: game.players[0].party[y]); print("")
                                }
                            }
                            else
                            {
                                print("Who do you want to heal ?")
                                for y in 0..<game.players[0].party.count
                                {
                                    usleep(1 * 100 * 1000)
                                    print("\(y+1). \(game.players[0].party[y].name)", terminator: " "); game.players[0].party[y].symbol(caste: game.players[0].party[y]); print(game.players[0].party[y].percent(life: game.players[0].party[y]))
                                }
                                select = Support.secureInt(lowerLimit: 1, upperLimit: game.players[0].party.count)
                                target = game.players[0].party[select-1]
                                print("\(game.players[0].party[powerPosition[0]].name) uses \((game.players[0].party[powerPosition[0]] as! Wizzard).power.useHeal(target: target)) on \(target.name) !")
                                usleep(1 * 100 * 1000)
                                print("\(target.name) has \(target.lifePoints) life points.")
                                target.lifeBar(caracter: target)
                                usleep(1 * 1000 * 1000)
                            }
                        } // if caracter is Wizzard -> useless for now but will be used when powers are added
                        
                    } // if numberOfPower == 1
                    else
                    {
                        print("Choose who is going to use a power :")
                        for y in 0..<powerPosition.count
                        {
                            usleep(1 * 100 * 1000)
                            print("\(y+1).", terminator:" "); game.players[0].party[powerPosition[y]].symbol(caste: game.players[0].party[powerPosition[y]]); print(" \(game.players[0].party[powerPosition[y]].name)")
                        }
                        select = Support.secureInt(lowerLimit: 1, upperLimit: powerPosition.count)
                        select = powerPosition[select-1]
                        
                        switch game.players[0].party[select]
                        {
                        case is Wizzard:
                            if game.players[0].party[select].weapon.name == "Long staff"
                            {
                                print("Thanks to his Long staff, \(game.players[0].party[select].name) will heal the entire party !")
                                usleep(5 * 100 * 1000)
                                (game.players[0].party[select] as! Wizzard).power.multHealing(target: game.players[0].party)
                                print("\tThe party got healed !")
                                usleep(1 * 100 * 1000)
                                for y in 0..<game.players[0].party.count
                                {
                                    print("\(game.players[0].party[y].name) has \(game.players[0].party[y].lifePoints) life points.")
                                    game.players[0].party[y].symbol(caste: game.players[0].party[y]); print("")
                                }
                            }
                            else
                            {
                                print("Who do you want to heal ?")
                                for y in 0..<game.players[0].party.count
                                {
                                    usleep(1 * 100 * 1000)
                                    print("\(y+1). \(game.players[0].party[y].name)", terminator: " "); game.players[0].party[y].symbol(caste: game.players[0].party[y]); print(game.players[0].party[y].percent(life: game.players[0].party[y]))
                                }
                                alsoselect = Support.secureInt(lowerLimit: 1, upperLimit: game.players[0].party.count)
                                target = game.players[0].party[alsoselect-1]
                                print("\(game.players[0].party[select].name) uses \((game.players[0].party[select] as! Wizzard).power.useHeal(target: target)) on \(target.name) !")
                                usleep(1 * 100 * 1000)
                                print("\(target.name) has \(target.lifePoints) life points.")
                                target.lifeBar(caracter: target)
                                usleep(1 * 1000 * 1000)
                            }
                        default:
                            Support.errorLog(origin: "\(#file)", detail: "l.\(#line) : power choice")
                        }
                        
                    }
                default:
                    Support.errorLog(origin: "\(#file)", detail: "l\(#line) : 'select' error")
                }
                
            } // MARK: if powerPresent
            else
            {
                if game.players[0].party.count > 1
                {
                    print("Choose who is going to attack :")
                    
                    
                    totalEnnemiesLeft = robotFighters.count
                    
                    
                    for j in 0..<game.players[0].party.count
                    {
                        usleep(1 * 100 * 1000)
                        print("\(j+1).", terminator: " "); game.players[0].party[j].symbol(caste: game.players[0].party[j]); print(" \(game.players[0].party[j].name)")
                    }
                    
                    select = Support.cheat1P(robotFighters: robotFighters, lowerLimit: 1, upperLimit: game.players[0].party.count)
                }
                    
                else
                {
                    select = 1
                    switch game.players[0].lastOneStanding
                    {
                    case true:
                        print("\(game.players[0].party[0].name) gives everything he has left !")
                    case false:
                        print("\(game.players[0].party[0].name) attacks !")
                    }
                }
                
                if totalEnnemiesLeft == 1
                {
                    target = robotFighters[0]
                }
                    
                else
                {
                    print("Choose your target :")
                    for y in 0..<robotFighters.count
                    {
                        targetsRepository.append(robotFighters[y])
                        print("\(targetsRepository.count). \(robotFighters[y].name)", terminator: " "); robotFighters[y].symbol(caste: robotFighters[y]); print(robotFighters[y].percent(life: robotFighters[y]))
                        usleep(1 * 100 * 1000)
                    }
                    
                    alsoselect = Support.secureInt(lowerLimit: 1, upperLimit: targetsRepository.count)
                    target = targetsRepository[alsoselect-1]
                }
                
                switch Int(arc4random_uniform(UInt32((2))))
                {
                case 0:
                    game.players[0].party[select-1].newWeapon(caracter: game.players[0].party[select-1])
                case 1:
                    break
                default:
                    Support.errorLog(origin: "\(#file)", detail: "\(#line)")
                }
                game.players[0].party[select-1].attack(weapon: game.players[0].party[select-1].weapon, target: target)
                
                
                for _ in 0..<targetsRepository.count
                {
                    targetsRepository.remove(at: 0)
                }
            } // if !powerPresent
            
            
            if game.players[0].party.count == 1 && game.players[0].party[0].lifePoints == 0
            {
                switch game.players[0].lastOneStanding
                {
                case true:
                    game.players[0].lastOneStanding = false
                case false:
                    game.players[0].lastOneStanding = true
                }
            }
            
            for e in 0..<game.players.count
            {
                for j in 0..<game.players[e].party.count
                {
                    if game.players[e].party[j].lifePoints == 0
                    {
                        if !game.players[e].lastOneStanding
                        {
                            print("\n\t", terminator: "")
                            switch Int(arc4random_uniform(UInt32(6)))
                            {
                            case 0:
                                print("Tough luck for \(game.players[e].name) ! \(game.players[e].party[j].name) just died !\n")
                                usleep(15 * 100 * 1000)
                            case 1:
                                print("Sorry, \(game.players[e].name) ! \(game.players[e].party[j].name) did his best.\n")
                                usleep(15 * 100 * 1000)
                            case 2:
                                print("One warrior down : \(game.players[e].party[j].name) left the game.\n")
                                usleep(15 * 100 * 1000)
                            case 3:
                                print("\(game.players[e].name) will have to do with one less player !\n")
                                usleep(15 * 100 * 1000)
                            case 4:
                                print("\(game.players[e].party[j].name) down ! How will \(game.players[e].name) react ?\n")
                                usleep(15 * 100 * 1000)
                            default:
                                print("\(game.players[e].party[j].name) left this world...\n")
                                usleep(15 * 100 * 1000)
                            }
                            deceased.append((e, j))
                        }
                        else
                        {
                            sleep(1)
                            print("\nOh no ! \(game.players[e].party[0].name) is dying !")
                            usleep(1 * 100 * 1000)
                            print("He muster the strenght for one last strike !")
                            sleep(1)
                        }
                    }
                }
            }
            if deceased.count >= 1
            {
                for t in (0..<deceased.count).reversed()
                {
                    game.players[deceased[t].0].party.remove(at: deceased[t].1)
                }
            }
        }
        
        for i in 0..<robotFighters.count
        {
            if robotFighters.count == 1
            {
                if robotFighters[0].lifePoints == 0
                {
                    print("\(robotFighters[0].name) is breaking !")
                    usleep(12 * 100 * 1000)
                    print("But it won't go down without one last strike !")
                }
            }
            else
            {
                if robotFighters[i].lifePoints == 0
                {
                    switch Int(arc4random_uniform(UInt32(5)))
                    {
                    case 0:
                        print("ERROR ERROR ->\(robotFighters[i].name)<- ERROR ERROR ERROR")
                    case 1:
                        print("\(robotFighters[i].name) WILL NOW STOP TO FUNCTION DUE TO UNFORSEEN CIRCUMSTANCES")
                    case 2:
                        print("\(robotFighters[i].name) does not respond anymore.")
                    case 3:
                        print("\(robotFighters[i].name) has stopped moving. Rust starts to appear on it.")
                    default:
                        print("Fatal error : \(robotFighters[i].name) no longer in condition for continuous use.")
                    }
                    removal.append(i)
                    print("\n")
                    sleep(2)
                }
            }
        }
        
        for i in (0..<removal.count).reversed()
        {
            robotFighters.remove(at: removal[i])
        }
        
        for _ in 0..<removal.count
        {
            removal.remove(at: 0)
        }
        
    } // func player turn
    
    // ↓ makes the registered army of robot fight, attacking healers and whoever got the fewer life points first.
    
    func robotTurn()
    {
        enum Action
        {
            case attack
            case heal
        }
        
        var powerPresent = false
        var numberOfPowers = 0
        var powerPosition = [Int]()
        
        var needHealing = [Int]()
        var attacker = Int()
        
        var turnAction = Action.attack
        var healTarget: Caracter?
        {
            didSet
            {
                if healTarget != nil && oldValue != nil
                {
                    if healTarget!.caste == .wizzard && oldValue!.caste == .wizzard
                    {
                        if oldValue!.lifePoints < healTarget!.lifePoints
                        {
                            healTarget = oldValue
                        }
                    }
                    
                    else if healTarget!.caste != .wizzard && oldValue!.caste != .wizzard
                    {
                        if oldValue!.lifePoints < healTarget!.lifePoints
                        {
                            healTarget = oldValue
                        }
                    }
                }
            }
        }
        var target: Caracter?
        {
            didSet
            {
                if target != nil && oldValue != nil
                {
                    if target!.caste == .wizzard && oldValue!.caste == .wizzard
                    {
                        if target!.lifePoints < oldValue!.lifePoints
                        {
                            target = oldValue
                        }
                    }
                    
                    if target!.caste != .wizzard && oldValue!.caste == .wizzard
                    {
                        target = oldValue
                    }
                    
                    if target!.caste != .wizzard && oldValue!.caste != .wizzard
                    {
                        if target!.lifePoints < oldValue!.lifePoints
                        {
                            target = oldValue
                        }
                    }
                }
            }
        }
        
        usleep(20 * 100 * 1000)
        print("The robots are moving.\n")
        usleep(15 * 100 * 1000)
        
        target = nil
        healTarget = nil
        
        powerPresent = false
        numberOfPowers = 0
        for _ in 0..<powerPosition.count
        {
            powerPosition.remove(at: 0)
        }
        
        for _ in 0..<needHealing.count
        {
            needHealing.remove(at: 0)
        }
        
        turnAction = .attack
        
        for j in 0..<robotFighters.count
        {
            if robotFighters[j] is Wizzard
            {
                powerPresent = true
                numberOfPowers += 1
                powerPosition.append(j)
            }
        }
        for i in 0..<robotFighters.count
        {
            if robotFighters[i].lifePoints < robotFighters[i].maxLifePoints * 70 / 100 && powerPresent == true
            {
                needHealing.append(i)
            }
        }
        
        for i in 0..<needHealing.count
        {
            if robotFighters[needHealing[i]].caste == .wizzard
            {
                turnAction = .heal
                healTarget = robotFighters[needHealing[i]]
            }
            else
            {
                if turnAction == .attack
                {
                    turnAction = .heal
                    healTarget = robotFighters[needHealing[i]]
                }
            }
        }
        
        if robotFighters.count == 1 && robotFighters[0].lifePoints == 0
        {
            turnAction = .attack
        }
        
        switch turnAction
        {
        case .heal:
            print("\(robotFighters[powerPosition[0]].name) uses \((robotFighters[powerPosition[0]] as! Wizzard).power.useHeal(target: healTarget!)) on \(healTarget!.name) !")
            print("\(healTarget!.name) has \(healTarget!.lifePoints) life points.")
            healTarget!.lifeBar(caracter: healTarget!)
            sleep(1)
        case .attack:
            attacker = 0
            if robotFighters.count > 1
            {
                for i in 0..<robotFighters.count - 1
                {
                    if robotFighters[i].weapon.damage < robotFighters[i+1].weapon.damage
                    {
                        attacker = i+1
                    }
                }
            }
            
            for i in 0..<game.players[0].party.count
            {
                target = game.players[0].party[i]
            }
            
            if robotFighters.count == 1 && robotFighters[0].lifePoints == 0
            {
                print("\(robotFighters[0].name) tries its best !")
            }
            
            else
            {
                print("\(robotFighters[attacker].name) attacks \(target!.name) !\n")
                usleep(5 * 100 * 1000)
            }
            
            switch Int(arc4random_uniform(UInt32((2))))
            {
            case 0:
                robotFighters[attacker].newWeapon(caracter: robotFighters[attacker])
            case 1:
                break
            default:
                Support.errorLog(origin: "\(#file)", detail: "\(#line)")
            }
            
            robotFighters[attacker].attack(weapon: robotFighters[attacker].weapon, target: target!)
            sleep(2)
            
            if robotFighters.count == 1 && robotFighters[0].lifePoints == 0
            {
                robotFighters.remove(at: 0)
            }
        }
    }
} // class Robot

