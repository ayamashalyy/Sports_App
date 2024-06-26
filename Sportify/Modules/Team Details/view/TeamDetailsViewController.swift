import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var legueDetailsViewModel = LeguesDetailsViewModel()
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamView: UIView!
    var team_key: Int?
    var leagueId : Int?
    var sportType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        
        if let teamKey = team_key {
            legueDetailsViewModel.fetchTeams(for: teamKey) {_ in
                   DispatchQueue.main.async { [weak self] in
                       self?.setupUI() 
                   }
               }
           } else {
               print("Team key is nil or zero")
           }
    }
    func updateView(){
        teamView.clipsToBounds = false
        teamView.layer.cornerRadius = 25
        teamView.backgroundColor = .white
        teamView.layer.shadowColor = UIColor.black.cgColor
        teamView.layer.shadowOffset = CGSize(width: 0, height: 5)
        teamView.layer.shadowRadius = 2
        teamView.layer.shadowOpacity = 0.3
        teamView.layer.shadowPath = UIBezierPath(roundedRect: teamView.bounds, cornerRadius: teamView.layer.cornerRadius).cgPath
     
    }
    
    
    
    func setupUI() {
        
        guard let firstTeam = legueDetailsViewModel.teamData.first else {
            print("No teams available")
            return
        }
        
        teamName.text = firstTeam.team_name ?? "Team Name Not Available"
        
        if let logoURL = URL(string: firstTeam.team_logo ?? "") {
            teamImage.kf.setImage(with: logoURL)
        } else {
            teamImage.image = UIImage(named: "cup.jpeg")
        }
        
        if let coach = firstTeam.coaches?.first {
            coachName.text = coach.coach_name ?? "Coach Not Available"
        } else {
            coachName.text = "Coach Not Available"
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legueDetailsViewModel.teamData.first?.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        
        if let player = legueDetailsViewModel.teamData.first?.players?[indexPath.row] {
            cell.playerName.text = player.player_name ?? "Player Name Not Available"
            cell.roalPlayer.text = player.player_type ?? "Defenders"
            cell.playerNo.text = player.player_number ?? "17"
            if let imageUrl = player.player_image, let url = URL(string: imageUrl) {
                cell.playerImage.kf.setImage(with: url)
            } else {
                cell.playerImage.image = UIImage(named: "26")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
