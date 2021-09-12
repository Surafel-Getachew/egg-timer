import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var eggTimerTitle: UILabel!
    @IBOutlet weak var boilngProgress: UIProgressView!
    
    let eggTimes = ["Soft":3,"Medium":4,"Hard":7];
    
    var boilSecond = 0;
    var totalSecondToBoil = 0;
    var timer = Timer()
    
    var player: AVAudioPlayer?

    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    @objc func updateCounter() {
        if boilSecond <
            totalSecondToBoil {
            boilSecond += 1
            boilngProgress.progress = (Float(boilSecond)*1)/Float(totalSecondToBoil)
           
        } else {
            timer.invalidate()
            eggTimerTitle.text = "Done ✅"
            playSound()
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        
        timer.invalidate();
        boilSecond = 0;
        boilngProgress.progress = 0
        
        
        let hardness = sender.currentTitle!;
        totalSecondToBoil = eggTimes[hardness]!
        
        eggTimerTitle.text = hardness;

        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
}
