//
//  ViewController.swift
//  CoinCrypt
//
//  Created by Jaden Hong on 2022-01-16.
//

import UIKit

class ViewController: UIViewController, CoinManagerDelegate {
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coinManager.delegate = self
        
        setTitle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setTitle() {
        let navController = navigationController!
        let image = UIImage(imageLiteralResourceName: "AppLogo")
        
        let width = navController.navigationBar.frame.size.width
        let height = navController.navigationBar.frame.size.height
        let x = width/2 - (image.size.width)/2
        let y = height/2 - (image.size.height)/2
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let coin = fromTextField.text!.uppercased()
        let cash = toTextField.text!.uppercased()
        
        if cash == "" || coin == "" {
            print("Please select both Coin and Cash currency.")
        } else {
            coinManager.fetchRequest(coin: coin, cash: cash)
        }
    }
    
    
    
    func didUpdateData(_ coinModel: CoinModel) {
        let rate = formatRate(coinModel.coinRate)
        let time = coinModel.currentTime
        
        
        
        DispatchQueue.main.async {
            if let curr = self.toTextField.text?.uppercased() {
                self.rateLabel.text = "\(curr) \(rate)"
                self.timeLabel.text = "As of: \(time)"
            }


        }
        
    }
    
    
     
    
    func formatRate(_ rate: Double) -> String {
        let stringRate = String(format: "%.2f", rate)
        return stringRate
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
