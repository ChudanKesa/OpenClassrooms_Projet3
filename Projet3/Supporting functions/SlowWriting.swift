//
//  SlowWriting.swift
//  Projet3
//
//  Created by Erwan Le Querré on 03/11/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

extension Support
{
    // sleep() between two prints works fine if you don't want to smother the user in text, but this displays the text one letter at a time, with a random delay between each and a a fixed delay between other signs, so it will look like the text is beeing typed.
    
    static func slowWriting(sentence: String)
    {
        var index = sentence.index(sentence.startIndex, offsetBy: 4)
        var lettre = sentence[index]
        var time: useconds_t = 5 * 100 * 100 // 0.0Xs
        var min = Int()
        
        for t in 0..<sentence.count
        {
            index = sentence.index(sentence.startIndex, offsetBy: t)
            lettre = sentence[index]
            
            if lettre != " " && lettre != "!" && lettre != "." && lettre != "," && lettre != ":"
            {
                min = Int(arc4random_uniform(UInt32(20)))
                if min < 5
                {
                    min = 5
                }
                time = useconds_t(min * 100 * 100)
                usleep(time)
                print(lettre, terminator: "")
            }
            else
            {
                usleep(100000)
                print(lettre, terminator: "")
            }
        }
        print("")
        
    }
}

