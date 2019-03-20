//
//  Hangman.swift
//  Hangman_works
//
//  Created by Mathieu ETCHEPARE on 20/03/2019.
//  Copyright © 2019 Efreeeeey. All rights reserved.
//

import Foundation

class Hangman {
    var dictionary = ["EFREI", "ESIGETEL", "EPITA", "RANDOM", "PARIS", "KILIAN", "BENJAMIN", "ROMAIN", "BIGDATA", "SOFTWARE", "BITE", "DIPLOME"]
    var chosenWord: String
    
    init() {
        chosenWord = dictionary[Int.random(in:0..<dictionary.count)]
    }
}
