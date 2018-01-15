//
//  SavingsCalculator.swift
//  Frelocate
//
//  Created by Rob Prior on 25/11/2017.
//  Copyright © 2017 Rob Prior. All rights reserved.
//

import Foundation

class SavingsCalculator: UIViewController {
    
    @IBOutlet var propertyValueLbl: UILabel!
    @IBOutlet var propertySlider: UISlider!
    
    @IBOutlet var averageCommissionLbl: UILabel!
    @IBOutlet var commissionSlider: UISlider!
    @IBOutlet var savingLbl: UILabel!
    
    @IBAction func propertyValueSlider(_ sender: Any) {
        sliderChanged()
    }
    
    @IBAction func averageCommissionSlider(_ sender: Any) {
        sliderChanged()
    }
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        sliderChanged()
    }
    
    func sliderChanged () {
        
        let roundedStepValue = round(propertySlider.value / 5000) * 5000
        propertySlider.value = roundedStepValue
        
        let value = Int(roundedStepValue)
        
        propertyValueLbl.text = "£\(value)"
        
        let Commission = Double(commissionSlider.value)
        let roundedCommission = (Commission * 10).rounded(.toNearestOrEven) / 10
        
        averageCommissionLbl.text = "\(roundedCommission)%"
        
        let savingValue = Double(propertySlider.value) * (Double(roundedCommission) / 100)
        let roundedSavingValue = (savingValue * 10).rounded(.toNearestOrEven) / 10
        
        let savingInt = Int(roundedSavingValue)
        
        let lessCosts = savingInt - 100
        savingLbl.text = "£\(lessCosts)"
        
    }

    
}
