//
//  ErrorsLog.swift
//  Projet3
//
//  Created by Erwan Le Querré on 25/10/2017.
//  Copyright © 2017 Erwan Le Querré. All rights reserved.
//

import Foundation

class Support
{
    static func errorLog(origin: String, detail: String)
    {
        print("**************************************")
        print("\tError in file \(origin) : '\(detail)'.")
        print("**************************************")
    }
}



