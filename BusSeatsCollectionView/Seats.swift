//
//  Seats.swift
//  BusSeatsCollectionView
//
//  Created by RAM on 06/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class Seats: UICollectionViewCell
{

    @IBOutlet weak var seatView: UIView!
    @IBOutlet weak var seatNo: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        seatView.clipsToBounds = true
        seatView.layer.shadowRadius = 5
        seatView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        seatView.layer.cornerRadius = 5
        
        // Initialization code
    }

}
