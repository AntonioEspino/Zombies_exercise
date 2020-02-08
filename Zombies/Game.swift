//
//  Game.swift
//  Zombies
//
//  Created by Adrian Tineo on 05.02.20.
//  Copyright © 2020 Adrian Tineo. All rights reserved.
//

import Foundation

enum Direction {
    case up
    case down
    case left
    case right
}

struct Game {
    private var grid: [[String]]
    
    // available chars are:
    // ⬜️ = ground
    // ⬛️ = darkness
    // 🚶‍♂️ = player
    // 🧟 = zombie
    // 🆘 = exit
    // 🚧 = obstacle (optional)
    // 🔦 = flashlight (optional)
    
    // MARK : initializer
    init() {
        grid = [["🆘", "⬜️", "⬜️", "⬜️", "⬜️"],
                ["⬜️", "⬜️", "⬜️", "⬜️", "⬜️"],
                ["⬜️", "⬜️", "⬜️", "⬜️", "⬜️"],
                ["⬜️", "⬜️", "⬜️", "⬜️", "⬜️"],
                ["⬜️", "⬜️", "⬜️", "⬜️", "🚶‍♂️"]]
        
        placeZombies()
    }
    
    // MARK: private methods
    private mutating func placeZombies() {
        // TODO: place zombies according to given rules
        
        var numberOfZombies = 0
        
        while numberOfZombies < 2 {
            let x = Int.random(in: 0...4)
            let y = Int.random(in: 0...4)
            if !((x == 0 || x == 1) && (y == 0 || y == 1)) && !((x == 3 || x == 4) && (y == 3 || y == 4)) {
                if grid[x][y] != "🧟" {
                    updateSquare(x, y, "🧟")
                    numberOfZombies += 1
                }
            }
            
        }
        
    }
    
    private var playerPosition: (Int, Int) {
        for (x, row) in grid.enumerated() {
            for (y, square) in row.enumerated() {
                if square == "🚶‍♂️" {
                    return (x, y)
                }
            }
        }
        fatalError("We lost the player!")
    }
    
    private mutating func updateSquare(_ x: Int, _ y: Int, _ content: String) {
        // FIXME: this can crash - fixed
        guard x >= 0 && x <= 4 && y >= 0 && y <= 4 else { return }
        grid[x][y] = content
    }
    
    // MARK: public API
    mutating func movePlayer(_ direction: Direction) {
        precondition(canPlayerMove(direction))
        
        // move player
        let (x, y) = playerPosition
        updateSquare(x, y, "⬜️")
        switch direction {
        case .up:
            updateSquare(x-1, y, "🚶‍♂️")
        case .down:
            updateSquare(x+1, y, "🚶‍♂️")
        case .left:
            updateSquare(x, y-1, "🚶‍♂️")
        case .right:
            updateSquare(x, y+1, "🚶‍♂️")
        }
    }
    
    func canPlayerMove(_ direction: Direction) -> Bool {
        // FIXME: this is buggy-fixed
        let (x, y) = playerPosition
        switch direction {
        case .up: return x != 0
        case .left: return y != 0
        case .right: return y != 4
        case .down: return x != 4
        }
    }
    
    var visibleGrid: [[String]] {
        // TODO: give a grid where only visible squares are copied, the rest
        // should be seen as ⬛️
        // Creo el array que va a ser visible en la pantalla del ipad
        var visibleGrid = grid
        
        // Calculo las posiciones contiguas al jugador
        let upPosition = (playerPosition.0 + 1, playerPosition.1)
        let downPosition = (playerPosition.0 - 1, playerPosition.1)
        let rightPosition = (playerPosition.0, playerPosition.1 + 1)
        let leftPosition = (playerPosition.0, playerPosition.1 - 1)
        
        // Recorro con un bucle el array grid para generar un array de la misma longitud, que es el que va a mostrarse en la pantalla del ipad
        for (x, row) in grid.enumerated() {
            for (y, _) in row.enumerated() {
                // En la primera poscion del array que genero coloco el simbolo de la salida
                if  (x, y) == (0, 0) {
                    visibleGrid[x][y] = "🆘"
                } else if (x, y) == playerPosition {
                    visibleGrid[x][y] = "🚶‍♂️"
                } else if (x, y) == upPosition ||
                    (x, y) == downPosition ||
                    (x, y) == rightPosition ||
                    (x, y) == leftPosition {
                    if grid[x][y] == "🧟" {
                      visibleGrid[x][y] = "🧟"
                    } else {
                       visibleGrid[x][y] = "⬜️"
                    }
                }
                else {
                    visibleGrid[x][y] = "⬛️"
                }
            }
        }

        return visibleGrid
    }
    
    var hasWon: Bool {
        // FIXME: player cannot win, why?-fixed
        return grid[0][1] == "🚶‍♂️" || grid[1][0] == "🚶‍♂️"
    }
    
    var hasLost: Bool {
        // TODO: calculate when player has lost (when revealing a zombie)
        var isLost = false
        
        for (_, row) in visibleGrid.enumerated() {
            for (_, square) in row.enumerated() {
                if square == "🧟" {
                    isLost = true
                }
            }
        }
        return isLost
    }
    
}
