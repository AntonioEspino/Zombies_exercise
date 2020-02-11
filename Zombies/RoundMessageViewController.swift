//
//  RoundMessageViewController.swift
//  Zombies
//
//  Created by user164220 on 11/02/2020.
//  Copyright © 2020 Adrian Tineo. All rights reserved.
//

import UIKit

class RoundMessageViewController: UIViewController {

    @IBOutlet weak var roundMessageLabel: UILabel!
    
    var roundMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let roundMessage = roundMessage else { return }
        roundMessageLabel.text = roundMessage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
