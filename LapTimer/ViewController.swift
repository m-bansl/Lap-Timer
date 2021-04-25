//
//  ViewController.swift
//  LapTimer
//
//  Created by Mehak Bansal on 08/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:Timer = Timer()
    var count:Int = 0
    var istimerOn:Bool = false
    var labelString = ""
    
    var lap:[String] = []
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startsStopButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var lapTable: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lapTable.delegate = self
        lapTable.dataSource = self
    }

  //MARK:- Button tapped
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        
        if istimerOn {
            istimerOn = false
            timer.invalidate()
            startsStopButton.setTitle("START", for: .normal)
            startsStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        else{
            istimerOn = true
            startsStopButton.setTitle("STOP", for: .normal)
            startsStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
            
            
        }
        
    }
    
    @IBAction func resetTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Reset Timer?", message: "This will delete all the existing data", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { (_) in
            //do nothing
            
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.count = 0
            self.istimerOn = false
            self.timer.invalidate()
            self.timerLabel.text = self.makeAString(hours: 0, minutes: 0, seconds: 0)
            self.lap.removeAll(keepingCapacity: false)
            self.lapTable.reloadData()
            
        }))
        
        
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func lapButtonPressed(_ sender: Any) {
        
        lap.insert(labelString, at: 0)
        lapTable.reloadData()
       
       
    }
    
    //MARK:- Helping Methods
   @objc func setTimer(){
    count = count + 1
    let time =  hoursToMinutesToSeconds(second: count)
    labelString =  makeAString(hours: time.0, minutes: time.1, seconds: time.2)
    timerLabel.text = labelString
       
    }
    
    func hoursToMinutesToSeconds(second:Int) -> (Int, Int, Int) {
        return ((second/3600),((second%3600)/60),((second%3600)%60))
    }
    
    func makeAString(hours:Int , minutes:Int , seconds:Int)->String{
        
        var makingString = ""
        makingString += String(format: "%02d", hours)
        makingString += ":"
        makingString += String(format: "%02d", minutes)
        makingString += ":"
        makingString += String(format: "%02d", seconds)
        
        return makingString
        
    }
    
}

//MARK:- TABLE VIEW

extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
      
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  lap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "lapCell")
    
      
        cell.backgroundColor = self.view.backgroundColor
        
        cell.textLabel?.text = "LAP \(lap.count-indexPath.row)"
        cell.detailTextLabel?.text = lap[indexPath.row]
        
       
        
        return cell
    }
    
    
}

