//
//  Game.swift
//  Projet3
//
//  Created by Erwan Le Querré on 26/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Game // the game itself, contains tab of players and a Bool for whether to keep playing
{
    
    var players = [Player]()
    var keepPlaying = true
    
    
    func startGame() // asks for # of players, takes their names and put them in 'players'
    {
        
        emptyTabPlayers()
        setPlayers(numberOfPlayers: getNPlayers())
        setParties()
    }
    
    private func emptyTabPlayers() // empties players so the game can start anew
    {
        for i in (0..<players.count).reversed()
        {
            players.remove(at: i)
        }
    }
    
    private func getNPlayers() -> Int // gets the number of people playing
    {
        var validated = false
        var nPlayers = 0
        
        while !validated
        {
            nPlayers = readNPlayers()
            validated = confirmNPlayers()
        }
        
        return nPlayers
    }
    
    private func confirmNPlayers() -> Bool // confirms the number of people playing
    {
        var validated = false
        
        while !validated
        {
            switch Support.askYN()
            {
            case "Y":
                validated = true
            case "y":
                validated = true
            case "N":
                print("Please try again. How many players ?")
            case "n":
                print("Please try again. How many players ?")
            default:
                print("Entry could not be read. Please try again.")
            }
        }
        
        return validated
    }
    
    private func readNPlayers() -> Int // asks for number of people playing
    {
        var numberOfPlayers = 0
        
        print("How many people are playing ?")
        
        numberOfPlayers = Support.askForInt(lowerLimit: 0, upperLimit: 100)
        
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
        
        return numberOfPlayers
    }
    
    private func setPlayers(numberOfPlayers: Int) // set game mode depending on # of players. If # >= 2, gets the players' names.
    {
        if numberOfPlayers == 0
        {
            print("Game will not be launched without players.")
            
            exit(0)
        }
        else if numberOfPlayers == 1
        {
            let robot = Robot()
            robot.battle()
        }
        else
        {
            getPlayersNames(numberOfPlayers: numberOfPlayers)
        }
    }
    
    private func getPlayersNames(numberOfPlayers: Int) // gets the players' names.
    {
        var name = ""
        print("Please enter the names of the players.")
        
        for i in 1...numberOfPlayers
        {
            print("Enter name of Player\(i) :")
            name = Support.askForString()
            players.append(Player(name: name))
        }
    }
    
    private func setParties() // lets players choose their fighters
    {
        for i in 0..<players.count
        {
            players[i].chooseParty(nbPlayers: players.count)
        }
    }
    
    /////////////////////////////////////////////////////////////////////
    // MARK: startGame() ended
    
    func playGame(players: [Player]) // one fighting turn for each player registered in *players*
    {
        var powerPresent = false
        var numberOfPowers = 0
        var powerPosition = [Int]()
        
        var totalEnnemiesLeft = Int()
        var totalAlliesLeft = Int()
        
        
        for i in 0..<players.count
        {
            totalEnnemiesLeft = getTotalEnnemiesLeft(i: i)
            totalAlliesLeft = getTotalAlliesLeft(i: i)
            
            
            if totalEnnemiesLeft >= 1 && totalAlliesLeft > 0
            {
                powerCount(powerPresent: &powerPresent, powerPosition: &powerPosition, numberOfPowers: &numberOfPowers, i: i)
                callPlayer(i: i)
                
                if powerPresent == true
                {
                    chooseHealOrAttack(i: i, powerPosition: powerPosition, totalEnnemiesLeft: totalEnnemiesLeft, numberOfPowers: numberOfPowers)
                }
                else
                {
                    autoAttack(i: i, totalEnnemiesLeft: totalEnnemiesLeft)
                }
                
                lastOneStanding()
                removeTheDead()
                
            }
            
        }
    }
    
    private func chooseHealOrAttack(i: Int, powerPosition: [Int], totalEnnemiesLeft: Int, numberOfPowers: Int) // if a healer is present, choose whether to heal or attack
    {
        var select = 0
        var target: Caracter
        
        switch actionChoice()
        {
        case 1:
            select = chooseAttacker(i: i)
            
            if totalEnnemiesLeft == 1
            {
                target = autoTarget(i: i)
            }
            else
            {
                target = chooseTarget(i: i)
            }
            
            attack(i: i, target: target, select: select)
            
            
        case 2:
            if numberOfPowers == 1
            {
                oneWayHeal(i: i, powerPosition: powerPosition, position: 0)
            }
            else
            {
                select = chooseWhoHeals(i: i, powerPosition: powerPosition)
                magicHappens(i: i, powerPosition: powerPosition, position: select)
            }
        default:
            Support.errorLog(origin: "Game", detail: "\(#line) : 'select' error")
        }
    }
    
    private func autoAttack(i: Int, totalEnnemiesLeft: Int) // auto attack mode if no healer is present
    {
        var select = 0
        var target: Caracter
        
        select = chooseAttacker(i: i)
        
        if totalEnnemiesLeft == 1
        {
            target = autoTarget(i: i)
        }
            
        else
        {
            target = chooseTarget(i: i)
        }
        
        attack(i: i, target: target, select: select)
    }
    
    private func getTotalEnnemiesLeft(i: Int) -> Int // gets # of ennemies remaining
    {
        var totalEnnemiesLeft = 0
        
        for t in 0..<players.count
        {
            if t != i
            {
                totalEnnemiesLeft += players[t].party.count
            }
        }
        
        return totalEnnemiesLeft
    }
    
    private func getTotalAlliesLeft(i: Int) -> Int // gets # of allies remaining
    {
        var totalAlliesLeft = 0
        
        for t in 0..<players.count
        {
            if t == i
            {
                totalAlliesLeft += players[t].party.count
            }
        }
        
        return totalAlliesLeft
    }
    
    private func powerCount(powerPresent: inout Bool, powerPosition: inout [Int], numberOfPowers: inout Int, i: Int) // gets # and positions of healers
    {
        numberOfPowers = 0
        powerPresent = false
        
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
    }
    
    private func actionChoice() -> Int // asks what to do
    {
        print("""
            What will you do ?
            1. Attack
            2. Use power
            """)
        
        return Support.secureInt(lowerLimit: 1, upperLimit: 2)
    }
    
    private func callPlayer(i: Int) // calls players whose turn it is
    {
        print("\(players[i].name), it's your turn.")
        usleep(1 * 100 * 1000)
    }
    
    private func chooseAttacker(i: Int) -> Int // choose Caracter whom attack
    {
        var select = 0
        
        if players[i].party.count > 1
        {
            print("Choose who is going to attack :")
            
            for j in 0..<players[i].party.count
            {
                print("\(j+1).", terminator: " "); players[i].party[j].symbol(caste: players[i].party[j]); print(" \(players[i].party[j].name)")
            }
            
            select = Support.secureInt(lowerLimit: 1, upperLimit: players[i].party.count)
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
        
        return select
    }
    
    private func autoTarget(i: Int) -> Caracter // when only one opponent remains, automaticly attacks him
    {
        var target = players[0].party[0]
        
        switch i
        {
        case 0:
            target = players[1].party[0]
        case 1:
            target = players[0].party[0]
        default:
            Support.errorLog(origin: "\(#file)", detail: "\(#line)")
            exit(1)
        }
        
        return target
    }
    
    private func chooseTarget(i: Int) -> Caracter // choose whom to attack
    {
        var targetsRepository = [Caracter]()
        var select = 0
        
        print("Choose your target :")
        usleep(1 * 100 * 1000)
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
                        usleep(1 * 100 * 1000)
                    }
                    else
                    {
                        targetsRepository.append(players[j].party[y])
                        print("\(targetsRepository.count). \(players[j].party[y].name)", terminator: " "); players[j].party[y].symbol(caste: players[j].party[y]); print(players[j].party[y].percent(life: players[j].party[y]))
                        usleep(1 * 100 * 1000)
                    }
                }
            }
        }
        
        select = Support.secureInt(lowerLimit: 1, upperLimit: targetsRepository.count)
        
        
        return targetsRepository[select-1]
    }
    
    private func attack(i: Int, target: Caracter, select: Int)
    {
        switch Int(arc4random_uniform(UInt32((2))))
        {
        case 0:
            players[i].party[select-1].newWeapon(caracter: players[i].party[select-1])
        case 1:
            break
        default:
            Support.errorLog(origin: "\(#file)", detail: "\(#line)")
        }
        
        players[i].party[select-1].attack(weapon: players[i].party[select-1].weapon, target: target)
    }
    
    private func oneWayHeal(i: Int, powerPosition: [Int], position: Int) // if there's only one wizzard, only the target of the heal has to be choosen
    {
        if players[i].party[powerPosition[0]] is Wizzard
        {
            if players[i].party[powerPosition[0]].weapon.name == "Long staff"
            {
                multiHeal(i: i, powerPosition: powerPosition, position: position)
            }
            else
            {
                chooseWhoToHeal(i: i, powerPosition: powerPosition, position: position)
            }
        } // if caracter is Wizzard -> useless for now but will be used when powers are added
    }
    
    private func multiHeal(i: Int, powerPosition: [Int], position: Int) // all the text and decorations needed to call power.multiheal
    {
        print("Thanks to his Long staff, \(players[i].party[powerPosition[position]].name) will heal the entire party !")
        usleep(5 * 100 * 1000)
        (players[i].party[powerPosition[position]] as! Wizzard).power.multHealing(target: players[i].party)
        print("\tThe party got healed !")
        usleep(1 * 100 * 1000)
        for y in 0..<players[i].party.count
        {
            print("\(players[i].party[y].name) has \(players[i].party[y].lifePoints) life points.")
            players[i].party[y].symbol(caste: players[i].party[y]); print("")
        }
    }
    
    private func chooseWhoToHeal(i: Int, powerPosition: [Int], position: Int) // choose who gets the heal
    {
        var select = Int()
        var target =  game.players[0].party[0]

        print("Who do you want to heal ?")
        for y in 0..<players[i].party.count
        {
            usleep(1 * 100 * 1000)
            print("\(y+1). \(players[i].party[y].name)", terminator: " "); players[i].party[y].symbol(caste: players[i].party[y]); print(players[i].party[y].percent(life: players[i].party[y]))
        }
        select = Support.secureInt(lowerLimit: 1, upperLimit: players[i].party.count)
        target = players[i].party[select-1]
        print("\(players[i].party[powerPosition[position]].name) uses \((players[i].party[powerPosition[position]] as! Wizzard).power.useHeal(target: target)) on \(target.name) !")
        usleep(1 * 100 * 1000)
        print("\(target.name) has \(target.lifePoints) life points.")
        target.lifeBar(caracter: target)
        usleep(1 * 1000 * 1000)
    }
    
    private func chooseWhoHeals(i: Int, powerPosition: [Int]) -> Int // if there are several healers, choose which one acts
    {
        var select = 0
        
        print("Choose who is going to use a power :")
        for y in 0..<powerPosition.count
        {
            usleep(1 * 100 * 1000)
            print("\(y+1).", terminator:" "); players[i].party[powerPosition[y]].symbol(caste: players[i].party[powerPosition[y]]); print(" \(players[i].party[powerPosition[y]].name)")
        }
        select = Support.secureInt(lowerLimit: 1, upperLimit: powerPosition.count)
        
        return powerPosition[select-1]
    }
    
    private func magicHappens(i: Int, powerPosition: [Int], position: Int) // use of healing functions when there are several healers -> follows chooseWhoHeals.
    {
        
        
        switch players[i].party[powerPosition[position]]
        {
        case is Wizzard:
            if players[i].party[powerPosition[position]].weapon.name == "Long staff"
            {
                multiHeal(i: i, powerPosition: powerPosition, position: position)
            }
            else
            {
                chooseWhoToHeal(i: i, powerPosition: powerPosition, position: position)
            }
        default:
            Support.errorLog(origin: "Game", detail: "l.\(#line) : power choice")
        }
    }
    
    private func lastOneStanding() // checks if there is only one dying caracter left in a party (so he can still get a turn before dying)
    {
        for l in 0..<game.players.count
        {
            if game.players[l].party.count == 1 && game.players[l].party[0].lifePoints == 0
            {
                switch game.players[l].lastOneStanding
                {
                case true:
                    game.players[l].lastOneStanding = false
                case false:
                    game.players[l].lastOneStanding = true
                }
            }
        }
    }
    
    private func removeTheDead() // remove dead caracters of party
    {
        var deceased = [(Int, Int)]()
        
        for e in 0..<players.count
        {
            for j in 0..<players[e].party.count
            {
                if players[e].party[j].lifePoints == 0
                {
                    if !players[e].lastOneStanding
                    {
                        announceDeceased(e: e, j: j, deceased: &deceased)
                    }
                    else
                    {
                        lastOneStandingCall(e: e)
                    }
                }
            }
        }
        if deceased.count >= 1
        {
            voidDeceased(deceased: deceased)
        }
    }
    
    private func lastOneStandingCall(e: Int) // text to call when lastonestanding == true
    {
        sleep(1)
        print("\nOh no ! \(players[e].party[0].name) is dying !")
        usleep(1 * 100 * 1000)
        print("He muster the strenght for one last strike !")
        usleep(15 * 100 * 1000)
    }

    private func voidDeceased(deceased: [(Int, Int)]) // remove dead caracters from party
    {
        for t in (0..<deceased.count).reversed()
        {
            players[deceased[t].0].party.remove(at: deceased[t].1)
        }
    }
    
    private func announceDeceased(e: Int, j: Int, deceased: inout [(Int, Int)]) // calls out names of fallen warriors
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
    
    
    ///////////////////////////////////////
    // MARK: ATTACK PATTERN OK
    // -> Every player in players has an action once
    
    // ↓ makes players keep playing until one of them looses all of their party, then asks if they want to play again.
    
    func finishGame() -> Bool
    {
        var victory = false
        
        victory = false
            
        while !victory
        {
            game.playGame(players: game.players)
            removeDeadPlayers()
            victory = clearVictory()
        }

        
        return game.keepPlaying
    }
    
    private func removeDeadPlayers() // remove players that lost from [players]
    {
        var removal = [Int]()
        
        for i in 0..<game.players.count
        {
            if game.players[i].party.count == 0
            {
                print("\n\t")
                Support.slowWriting(sentence: "\(game.players[i].name)'s party was defeated...")
                sleep(1)
                print("\t", terminator: "")
                Support.slowWriting(sentence: "\(game.players[i].name) lost.")
                removal.append(i)
            }
        }
        
        
        
        for i in (0..<removal.count).reversed()
        {
            game.players.remove(at: removal[i])
        }
    }
    
    private func clearVictory() -> Bool // gets victory status to keep or get out of the loop.
    {
        if game.players.count <= 1
        {
            announceVictory()
            switch Support.askYN()
            {
            case "y":
                prepare()
            case "Y":
                prepare()
            case "n":
                endGame()
            case "N":
                endGame()
            default:
                Support.errorLog(origin: "\(#file)", detail: "\(#line)")
            }
            return true
        }
            
        else
        {
            return false
        }
    }
    
    private func announceVictory() // victory text, in case of victory.
    {
        if game.players.count == 1
        {
            print("\n")
            sleep(1)
            print("\n")
            sleep(1)
            print(" **\\o/**\\o/**\\o/**\\o/**")
            print("\t", terminator: "")
            Support.slowWriting(sentence: "Congratulations, \(game.players[0].name) ! You vanquished your opponents. This game is yours !")
            print("\n")
            sleep(1)
            print("\n")
        }
        sleep(1)
        print("Do you want to play again ?\nY/N")
    }
    
    
    private func prepare() // text + init if a new game starts
    {
        game.keepPlaying = true
        print("Prepare !")
        sleep(1)
        print("")
        sleep(1)
        print("")
        players.remove(at: 0)
    }

    private func endGame() // text + init if no new game start
    {
        game.keepPlaying = false
        print("\t************\n\t", terminator: "")
        print("Thanks for playing !")
        print("\n")
        sleep(1)
        print("")
        sleep(1)
        print("")
    }
    
    
    
    
    // ↓ loop all of the above
    
    func allGame()
    {
        var keepPlaying = true
        
        while keepPlaying
        {
            game.startGame()
            game.playGame(players: game.players)
            keepPlaying = game.finishGame()
        }
    }
    
    
} // class


