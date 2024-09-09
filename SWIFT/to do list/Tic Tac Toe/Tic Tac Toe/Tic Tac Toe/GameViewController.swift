import UIKit

class GameViewController: UIViewController {
    var ticTacToeGame = TicTacToe()
    var buttons = [UIButton]()
    var currentPlayerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // Create a label to display the current player's turn.
        currentPlayerLabel = UILabel()
        currentPlayerLabel.textAlignment = .center
        currentPlayerLabel.font = UIFont.systemFont(ofSize: 20)
        currentPlayerLabel.text = "Current Player: X"
        view.addSubview(currentPlayerLabel)
        
        // Create the Tic Tac Toe grid buttons.
        for row in 0..<3 {
            for col in 0..<3 {
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
                button.tag = row * 3 + col
                button.addTarget(self, action: #selector(gridButtonTapped(_:)), for: .touchUpInside)
                buttons.append(button)
                view.addSubview(button)
            }
        }
        
        // Position the UI elements.
        currentPlayerLabel.frame = CGRect(x: 10, y: 50, width: view.frame.size.width - 20, height: 30)
        
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 100
        let spacing: CGFloat = 10
        let xOffset = (view.frame.size.width - (buttonWidth * 3 + spacing * 2)) / 2
        let yOffset = currentPlayerLabel.frame.maxY + 20
        
        for (index, button) in buttons.enumerated() {
            let row = CGFloat(index / 3)
            let col = CGFloat(index % 3)
            button.frame = CGRect(x: xOffset + col * (buttonWidth + spacing),
                                  y: yOffset + row * (buttonHeight + spacing),
                                  width: buttonWidth,
                                  height: buttonHeight)
        }
    }
    
    @objc func gridButtonTapped(_ sender: UIButton) {
        let position = sender.tag
        
        if ticTacToeGame.makeMove(at: position) {
            updateUI(for: ticTacToeGame.state)
            sender.setTitle(currentPlayerString(), for: .normal)
            sender.isUserInteractionEnabled = false
        }
    }
    
    func updateUI(for gameState: GameState) {
        switch gameState {
        case .inProgress:
            currentPlayerLabel.text = "Current Player: " + currentPlayerString()
        case .finished(let winner):
            if let winner = winner {
                currentPlayerLabel.text = "Player \(winner) wins!"
            } else {
                currentPlayerLabel.text = "It's a draw!"
            }
            disableAllButtons()
        case .draw:
            currentPlayerLabel.text = "It's a draw!"
            disableAllButtons()
        }
    }
    
    func currentPlayerString() -> String {
        return ticTacToeGame.currentPlayer == .X ? "X" : "O"
    }
    
    func disableAllButtons() {
        for button in buttons {
            button.isUserInteractionEnabled = false
        }
    }
}
