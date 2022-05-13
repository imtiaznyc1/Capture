//
//  ticketTableViewCell.swift
//  Capture
//
//  Created by Imtiaz Rahman on 5/13/22.
//

import UIKit

class ticketTableViewCell: UITableViewCell {

    @IBOutlet var fine: UILabel!
    @IBOutlet var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
