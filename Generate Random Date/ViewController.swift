//
//  ViewController.swift
//  Generate Random Date


import UIKit

class ViewController: UIViewController {
    
    let reuseIdentifier = "WeekDayCell"
    var randomDay : String!
    @IBOutlet weak var weekDaysCollectionView : UICollectionView!
    @IBOutlet weak var randomDateLabel : UILabel!
    @IBOutlet weak var answerLabel : UILabel!
    @IBOutlet weak var countDownLabel : UILabel!
    
    var timer : Timer?
    var countDownTimer : Timer?
    var timeInterval = 15
    let startDateValue:String = "01 Jan 1753"
    let endDateValue:String = "01 Jan 1753"
    let dateFormatterValue:String = "dd MMM YYYY"
    let weekDays = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.weekDaysCollectionView.register(UINib(nibName: "WeekDayCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        weekDaysCollectionView.register(UINib(nibName: "WeekDayCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        startTimer()
        genearateRandomDate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK:Date Function
public extension Date {
    
    public static func random(between initial: Date, and final :Date) -> Date {
        let randomInterval = TimeInterval(arc4random_uniform(UInt32.max))
        return initial.addingTimeInterval(randomInterval)
    }
    
    public func dayFromDate() ->String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        dateFormatter.dateStyle = .full
        let components = dateFormatter.string(from: self).split(separator: ",")
        if components.count>0{
            return "\(components[0])"
        }
        return nil
    }
}

//MARK:Function
extension ViewController {
    
    @objc func genearateRandomDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatterValue
        
        let startDate = dateFormatter.date(from: startDateValue)
        let endDate = dateFormatter.date(from: endDateValue)
        
        let random = Date.random(between: startDate!, and: endDate!)
        randomDateLabel.text = dateFormatter.string(from: random)
        
        if let day = random.dayFromDate(){
            randomDay = day
            print(randomDay)
        }
        
        timeInterval = 15
        startCountDownTimer()
    }
    
    
    func isDayMathced(aIndexPath: IndexPath) -> Bool{
        
        stopTimer()
        stopCountDownTimer()
        if ( randomDay == weekDays[aIndexPath.row]) {
            answerLabel.text = "Correct. \(randomDay!)"
            return true
        }
        else{
            answerLabel.text = "Wrong. \(randomDay!)"
            return false
        }
    }
    
    func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval),target: self,selector: #selector(self.genearateRandomDate),userInfo: nil,repeats: true)
        }
    }
    
    func stopTimer(){
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    func stopCountDownTimer(){
        if countDownTimer != nil {
            countDownTimer!.invalidate()
            countDownTimer = nil
        }
    }
    
    @objc func startCountDownTimer(){
        
        if countDownTimer == nil {
            countDownTimer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDownTimer), userInfo: nil, repeats: true)
        }
        if timeInterval > 0 {
            countDownLabel.text = String(timeInterval)
            timeInterval -= 1
        }
    }
    
}
//MARK:UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WeekDayCell
        cell.weekDayLabel.text = String(self.weekDays[indexPath.item].prefix(3))
        return cell
    }
}

//MARK:UICollectionViewDelegate
extension ViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isCorrect = isDayMathced(aIndexPath: indexPath)
        print(isCorrect)
        genearateRandomDate()
        startTimer()
    }
}
