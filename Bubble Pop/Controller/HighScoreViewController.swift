import UIKit

//A view that displays a table of the currently stored highscores in the game
class HighScoreViewController: UIViewController {

    @IBOutlet weak var highscoreTableView: UITableView!
    
    var highscores: [[String]] = [[]]
        
    //On load we need to delegate the table and give it a data source. We register a nib to the table view as well.
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        highscoreTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        highscoreTableView.delegate = self
        highscoreTableView.dataSource = self
        if let highscores =  UserDefaults.standard.value(forKey: "highscores") as? [[String]] {
            self.highscores = sortScores(highscores: highscores)
        }
    }
    
    //A function that takes in an array of strings and returns the array of strings sorted by the score
    // https://stackoverflow.com/a/39756583
    func sortScores(highscores: [[String]]) -> [[String]] {
        if(highscores.count > 1) {
            return highscores.sorted(by: { Float($0[1])! > Float($1[1])! })
        }
        return highscores
    }
    
    //A function that allows the button to segue to the main menu
    @IBAction func mainMenuButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

//We use protocols and extenstions to make the code more readable

extension HighScoreViewController: UITableViewDelegate {
    
    //A function that returns the amount of highscores stored in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
}

extension HighScoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set([[]], forKey: "highscores")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = highscoreTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        customCell.nameLabel.text = highscores[indexPath.row][0]
        customCell.scoreLabel.text = ("Score: \(highscores[indexPath.row][1])")
        let username = UserDefaults.standard.value(forKey: "username") as! String
        //Highlights your usernames highscores
        if(String(highscores[indexPath.row][0]) == username) {
            customCell.backgroundColor = .systemRed
        } else {
            customCell.backgroundColor = .blue
        }
        
        return customCell
    }
}
