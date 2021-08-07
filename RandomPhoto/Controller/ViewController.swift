//
//  ViewController.swift
//  RandomPhoto
//
//  Created by Santiago Gomez del campo on 16/07/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var imageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageManager.delegate = self
        
        // Button Properties
        imageButton.layer.cornerRadius = 12
        imageButton.layer.borderWidth = 1
        imageButton.layer.borderColor = UIColor(named: "ColorSet")?.cgColor
        
        // Image View properties
        imageView.layer.cornerRadius = 12
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor(named: "ColorSet")?.cgColor
        imageView.image = UIImage(named: "StartingImage")
        
        // Title properties
        appTitle.adjustsFontForContentSizeCategory = true
        appTitle.minimumScaleFactor = 0.2
        
    }
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        imageManager.getRandomImage()
    }

}


extension ViewController : ImageManagerDelegate {
    
    func didUpdateImage(_ imageManager: ImageManager, _ image: ImageModel) {
        print("URL = \(image.imageURL)")
        print("Description = \(image.description)")
        
        let imageURL = URL(string: image.imageURL)!
        let imageData = try! Data(contentsOf: imageURL)
        
        DispatchQueue.main.async {
            self.descriptionLabel.text = image.description
            self.imageView.image = UIImage(data: imageData)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
