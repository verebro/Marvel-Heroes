//
//  DetailViewCellViewController.swift
//  Marvel Heroes
//
//  Created by Владислав Керечанин on 25.11.2020.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    var player: AVAudioPlayer!
    var selectedImage: String?
    

    
    @IBOutlet var imageView: UIImageView!
    @IBAction func playButton(_ sender: UIButton) {
    
        let imageName = "\(selectedImage!.dropLast(4))"
        sender.setTitle(imageName, for: .normal)
        
        playSound(soundName: sender.currentTitle!)
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
       
        if url != nil {
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
        title = "\(selectedImage?.dropLast(4) ?? "Picture")"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector (shareTapped))
        
        }
    
   override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false

    }
    
   @objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
    else {
        print("No image found. Hi Lyosha")
        return
    }
    
    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    
    //code for ipad. "ShareSheet will pop up from right button in navbar
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
