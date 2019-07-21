//
//  GameRoomTableView.swift
//  Code Burger
//
//  Created by Qiarra on 15/07/19.
//  Copyright © 2019 Finley Khouwira. All rights reserved.
//

import UIKit

class GameRoomTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    weak var stageProtocols: StageProtocols?
    var userDef = UserDefaults.standard
    
    var items: [String] = ["Stage 1", "Stage 2", "Stage 3"]
    var imageStage: [UIImage] = [UIImage(named: "1stage")!, UIImage(named: "2stage")!, UIImage(named: "3stage")!, UIImage(named: "4stage")!, UIImage(named: "5stage")!, UIImage(named: "6stage")!, UIImage(named: "7stage")!, UIImage(named: "8stage")!, UIImage(named: "9stage")!, UIImage(named: "10stage")!, UIImage(named: "11stage")!]
    var imageLock: [UIImage] = [UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!,UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!, UIImage(named: "lock")!]
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        
        rowHeight = 275
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageStage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stageCell", for: indexPath) as! StageTableCell
//        cell.lblStage?.text = self.items[indexPath.row]
        cell.imgStage?.image = self.imageStage[indexPath.row]
//        if userDef.integer(forKey: "stageIndex") < indexPath.row {
//            cell.imgStage.isHidden = true
//            cell.imgLock?.image = self.imageLock[indexPath.row]
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.stageProtocols?.moveScene(indexPath)
    }

}
