import Foundation

enum Player {
    case X
    case O
}

enum GameState: Equatable {
    case inProgress
    case finished(winner: Player?)
    case draw
}

struct TicTacToe {
    private var board: [Player?]
    var currentPlayer: Player = .X // Changed to internal access
    var state: GameState = .inProgress
    
    init() {
        board = Array(repeating: nil, count: 9)
    }
    
    mutating func makeMove(at position: Int) -> Bool {
        guard position >= 0 && position < board.count && board[position] == nil && state == .inProgress else {
            return false
        }
        
        board[position] = currentPlayer
        currentPlayer = (currentPlayer == .X) ? .O : .X
        
        if checkForWin() {
            state = .finished(winner: currentPlayer)
        } else if board.allSatisfy({ $0 != nil }) {
            state = .draw
        }
        
        return true
    }
    
    private func checkForWin() -> Bool {
        let winningCombinations: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6] // Diagonals
        ]
        
        for combination in winningCombinations {
            let a = combination[0], b = combination[1], c = combination[2]
            if board[a] == board[b] && board[b] == board[c] && board[a] != nil {
                return true
            }
        }
        
        return false
    }
    
    func printBoard() {
        for (index, player) in board.enumerated() {
            if let player = player {
                print(player == .X ? "X" : "O", terminator: "")
            } else {
                print("-", terminator: "")
            }
            
            if (index + 1) % 3 == 0 {
                print()
            } else {
                print(" | ", terminator: "")
            }
        }
    }
}
