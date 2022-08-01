//
//  ListTableViewCell.swift
//  CoreDataDemo
//
//  Created by Chanti on 01/08/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var snoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(data : Records) {
        snoLabel.text = String(data.sno)
        nameLabel.text = data.name
        ageLabel.text = String(data.age)
    }
    
}
