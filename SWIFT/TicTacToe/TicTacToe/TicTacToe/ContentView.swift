import SwiftUI

enum Joueur: String {
    case x = "X" // Définition du joueur X
    case o = "O" // Définition du joueur O
    
    mutating func toggle() { // Fonction pour basculer entre les joueurs
        self = (self == .x) ? .o : .x
    }
}

struct ContentView: View {
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3) // Initialisation du tableau de jeu 3x3
    @State private var currentPlayer: Joueur = .x // Initialisation du joueur actuel
    @State private var winner: String = "" // Initialisation du gagnant
    @State private var isDraw: Bool = false // Initialisation du drapeau pour un match nul
    @State private var vsAI: Bool = false // Initialisation du drapeau pour jouer contre l'IA
    
    var body: some View {
        ZStack {
            if !winner.isEmpty {
                (winner == "X" ? Color.red : Color.blue) // Affiche la couleur du vainqueur (rouge pour X, bleu pour O)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.black // Fond noir si le jeu n'est pas terminé
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 15) {
                Toggle("Jouer contre l'ordi", isOn: $vsAI) // Bouton pour activer/désactiver le mode contre l'IA
                    .padding()
                
                Text("Morpion") // Titre du jeu
                    .font(.title)
                    .padding()
                    .foregroundColor(winner.isEmpty ? (currentPlayer == .x ? Color.red : Color.blue) : Color.black) // Couleur du titre en fonction du joueur actuel ou du vainqueur
                
                ForEach(0..<3) { row in // Boucle pour les lignes du plateau de jeu
                    HStack(spacing: 15) {
                        ForEach(0..<3) { col in // Boucle pour les colonnes du plateau de jeu
                            Button(action: {
                                if board[row][col] == "" && winner.isEmpty && !isDraw { // Vérifie si la case est vide, s'il n'y a pas de vainqueur et si le match n'est pas un match nul
                                    board[row][col] = currentPlayer.rawValue // Place le symbole du joueur actuel dans la case
                                    checkWinner() // Vérifie s'il y a un vainqueur
                                    if vsAI && winner.isEmpty && !isDraw { // Si le mode IA est activé et le jeu n'est pas terminé
                                        makeAIMove() // Laisse l'IA jouer
                                        checkWinner() // Vérifie s'il y a un vainqueur après le tour de l'IA
                                    } else {
                                        currentPlayer.toggle() // Passe au joueur suivant
                                    }
                                }
                            }) {
                                Text(board[row][col]) // Affiche le symbole (X, O ou vide) dans la case
                                    .font(.system(size: 50))
                                    .frame(width: 90, height: 90)
                                    .background(winner.isEmpty ? (board[row][col] == "X" ? Color.red : (board[row][col] == "O" ? Color.blue : Color.gray)) : Color.black) // Couleur de fond en fonction du symbole
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                        }
                    }
                }
                
                if !winner.isEmpty {
                    Text("\(winner) a gagné!") // Affiche le message de victoire avec le nom du gagnant
                        .font(.headline)
                        .padding()
                        .frame(height: 30)
                } else if isDraw {
                    Text("Égalité!") // Affiche un message de match nul
                        .font(.headline)
                        .padding()
                        .frame(height: 30)
                } else {
                    Text("") // Espace vide pour l'affichage
                        .frame(height: 30)
                }
                
                Button("Recommencer") {
                    restartGame() // Bouton pour recommencer le jeu
                }
                .padding()
                .background(winner.isEmpty ? (currentPlayer == .x ? Color.red : Color.blue) : Color.black) // Couleur de fond du bouton en fonction du joueur actuel ou du vainqueur
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
    }
    
    func restartGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3) // Réinitialisation du plateau de jeu
        winner = "" // Réinitialisation du vainqueur
        isDraw = false // Réinitialisation du drapeau pour un match nul
        currentPlayer = .x // Réinitialisation du joueur actuel
    }
    
    func makeAIMove() {
        let availableMoves = board.enumerated().flatMap { row in
            row.element.enumerated().compactMap { col in
                (row.offset, col.offset)
            }.filter { board[$0.0][$0.1] == "" }
        }
        
        if let randomMove = availableMoves.randomElement() {
            currentPlayer.toggle() // Passe au joueur actuel
            board[randomMove.0][randomMove.1] = currentPlayer.rawValue // Place le symbole du joueur actuel dans une case disponible
            currentPlayer.toggle() // Passe au joueur suivant
        }
    }
    
    func checkWinner() {
        for i in 0..<3 {
            if board[i][0] == board[i][1], board[i][1] == board[i][2], board[i][0] != "" { // Vérifie les lignes horizontales
                winner = board[i][0] // Le joueur de la première case gagne
                return
            }
            
            if board[0][i] == board[1][i], board[1][i] == board[2][i], board[0][i] != "" { // Vérifie les colonnes verticales
                winner = board[0][i] // Le joueur de la première case gagne
                return
            }
        }
        
        if board[0][0] == board[1][1], board[1][1] == board[2][2], board[0][0] != "" { // Vérifie la diagonale de gauche à droite
            winner = board[0][0] // Le joueur de la première case gagne
            return
        }
        
        if board[0][2] == board[1][1], board[1][1] == board[2][0], board[0][2] != "" { // Vérifie la diagonale de droite à gauche
            winner = board[0][2] // Le joueur de la première case gagne
            return
        }
        
        if winner.isEmpty {
            isDraw = !board.flatMap { $0 }.contains { $0 == "" } // Si le plateau est rempli sans vainqueur, c'est un match nul
        }
    }
}
