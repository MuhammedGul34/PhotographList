//
//  TableViewCell.swift
//  FotografListesi
//
//  Created by Muhammed Gül on 16.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgFoto: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
