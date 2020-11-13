//
//  BlogCell.swift
//  BlogPost
//
//  Created by Las Rock on 11/13/20.
//

import UIKit

class BlogCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func goPressed(_ sender: UIButton) {
       
        
    }
}
