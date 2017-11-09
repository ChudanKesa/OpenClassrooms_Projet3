//
//  RandomNames.swift
//  Projet3
//
//  Created by Erwan Le Querré on 02/11/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

extension Support
{
    // returns a random name so askForName can get it.
    
    static func randomNames() -> String
    {
        var name = ""
        var names = ["Gerald",
                     "Geronimo",
                     "Aindrea",
                     "Gedeon",
                     "Baghadur",
                     "Blair",
                     "Cadell",
                     "Caderyn",
                     "Caedmon",
                     "Càel",
                     "Cay",
                     "Cedric",
                     "Conlanoch",
                     "Deandre",
                     "Donogh",
                     "Duncan",
                     "Éibehar",
                     "Gabriel",
                     "Hania",
                     "Ingvar",
                     "Kaden",
                     "Rayner",
                     "Straton",
                     "Takeshi",
                     "Verner",
                     "Volker",
                     "Volundr",
                     "Walter",
                     "Wyatt",
                     "Xerces"]
        
        name = names[Int(arc4random_uniform(UInt32(names.count)))]
        
        
        return name
    }
}



