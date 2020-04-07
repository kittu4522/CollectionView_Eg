//
//  ViewController.swift
//  BusSeatsCollectionView
//
//  Created by RAM on 06/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
    var seatNos:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40]
    var lSeatNos:[Int] = [1,5,9,13,17,21,25,29,33,37,2,6,10,14,18,22,26,30,34,38]
    var rSeatNos:[Int] = [3,7,11,15,19,23,27,31,35,39,4,8,12,16,20,24,28,32,36,40]
    
    var selectedSeats:[Int] = []
    var bookedSeats:[Int] = []
    
    var alert:UIAlertController!
    
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var collViewBgView: UIView!
    
    var layout:UICollectionViewFlowLayout!
    var busCV: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        if (UserDefaults.standard.object(forKey: "bookedSeats") != nil)
        {
            bookedSeats = UserDefaults.standard.object(forKey: "bookedSeats")as! [Int]
        }
        else
        {
            UserDefaults.standard.set(bookedSeats, forKey: "bookedSeats")
        }
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 70)
        layout.scrollDirection = .horizontal
        
        
        
        busCV = UICollectionView(frame: CGRect(x: 50, y: 25, width: 314, height: 650), collectionViewLayout: layout)
        busCV.backgroundColor = .systemBackground
        collViewBgView.addSubview(busCV)
        
        //Inset for spacing cells in collection view top bottom left and right like constrains
        busCV.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        busCV.showsVerticalScrollIndicator = false
        busCV.showsHorizontalScrollIndicator = false
        busCV.allowsMultipleSelection = true
        
        
        busCV.register(UINib(nibName: "Seats", bundle: nil), forCellWithReuseIdentifier: "SeatCell")
        
        busCV.delegate = self
        busCV.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    //numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 2
    }
    
    //numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if section == 0
        {
            return lSeatNos.count
        }
        else if section == 1
        {
            return rSeatNos.count
        }
        return 0
    }
    
    
    
    
    //cellForItemAt indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCell", for: indexPath)as! Seats
        
        if indexPath.section == 0
        {
            if bookedSeats.count != 0 && bookedSeats.contains(lSeatNos[indexPath.row])
            {
                cell.seatView.backgroundColor = .brown
                
            }
            else
            {
                cell.seatView.backgroundColor = .green
            }
             cell.seatNo.text = "\(lSeatNos[indexPath.row])"
        }
        else if indexPath.section == 1
        {
            if bookedSeats.count != 0 && bookedSeats.contains(rSeatNos[indexPath.row])
            {
                cell.seatView.backgroundColor = .brown
                
            }
            else
            {
                cell.seatView.backgroundColor = .green
            }
             cell.seatNo.text = "\(rSeatNos[indexPath.row])"
        }
        return cell
    }
     
    //shouldSelectItemAt it returns true / false
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        if indexPath.section == 0
        {
            if bookedSeats.count != 0 && bookedSeats.contains(lSeatNos[indexPath.row])
            {
                alert = UIAlertController(title: "Error", message: "This Seat is Already Booked", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            else
            {
                return true
            }
        }
        else if indexPath.section == 1
        {
            if bookedSeats.count != 0 && bookedSeats.contains(rSeatNos[indexPath.row])
            {
                alert = UIAlertController(title: "Error", message: "This Seat is Already Booked", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
            else
            {
                return true
            }
        }
        return false
    }
    
    //didSelectItemAt indexPath
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            if bookedSeats.count != 0 && bookedSeats.contains(lSeatNos[indexPath.row])
            {
                let cell = collectionView.cellForItem(at: indexPath)as! Seats

                cell.seatView.backgroundColor = .brown
            }
            else
            {
                let cell = collectionView.cellForItem(at: indexPath)as! Seats

                cell.seatView.backgroundColor = .red
                selectedSeats.append(lSeatNos[indexPath.row])
            }
        }
        else if indexPath.section == 1
        {
            if bookedSeats.count != 0 && bookedSeats.contains(rSeatNos[indexPath.row])
            {
                let cell = collectionView.cellForItem(at: indexPath)as! Seats

                cell.seatView.backgroundColor = .brown
            }
            else
            {
                let cell = collectionView.cellForItem(at: indexPath)as! Seats

                cell.seatView.backgroundColor = .red
                selectedSeats.append(rSeatNos[indexPath.row])
            }
        }
        selectedSeats = Array(Set(selectedSeats))
        
        priceLBL.text = "Rs: \(selectedSeats.count*499) /-"
    }
    
    //didDeselectItemAt indexPath
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath)as! Seats

        if indexPath.section == 0
        {
            cell.seatView.backgroundColor = .green
            selectedSeats = selectedSeats.filter{$0 != lSeatNos[indexPath.row]}
            priceLBL.text = "Rs: \(selectedSeats.count*499) /-"
        }
        else if indexPath.section == 1
        {
            cell.seatView.backgroundColor = .green
            selectedSeats = selectedSeats.filter{$0 != rSeatNos[indexPath.row]}
            priceLBL.text = "Rs: \(selectedSeats.count*499) /-"
        }
    }
    
    //Buy ticket button
    @IBAction func sendBtnClicked(_ sender: Any)
    {
        if selectedSeats.count != 0
        {
            alert = UIAlertController(title: "Check Fare", message: "Rs: \(selectedSeats.count*499) /-", preferredStyle: UIAlertController.Style.alert)
            let buy = UIAlertAction(title: "Buy Tickets", style: UIAlertAction.Style.default)
            { buy in
                self.bookedSeats = Array(Set(self.bookedSeats))
                self.bookedSeats = self.selectedSeats + self.bookedSeats
                UserDefaults.standard.set(self.bookedSeats, forKey: "bookedSeats")
                self.priceLBL.text = "Rs: 0.0 /-"
                self.selectedSeats = []
                self.viewDidLoad()
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil)
            alert.addAction(buy)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            alert = UIAlertController(title: "Check Fare", message: "Your'e Not Choosen Any Seat Please Select Atleast One Seat to Proceed", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}

