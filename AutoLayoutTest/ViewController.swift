//
//  ViewController.swift
//  AutoLayoutTest
//
//  Created by Jaein Yoo on 2/20/24.
//

import UIKit

class ViewController: UIViewController {

    private let inputImage = CIImage(image: UIImage(named: "input.jpg")!)
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: self.view.frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image = UIImage(ciImage: inputImage!)

    
        return imageView
        }()
    
    lazy var slider: UISlider = {
//        let greenSlider = UISlider(frame: .init())
//        greenSlider.layer.position = CGPoint(x:self.view.frame.midX, y:500)
        
        let greenSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
        
        
          
        greenSlider.layer.position = CGPoint(x:self.view.frame.midX, y:700)

        
//        greenSlider.translatesAutoresizingMaskIntoConstraints = false
        greenSlider.backgroundColor = UIColor.white
        greenSlider.layer.cornerRadius = 10.0
        greenSlider.layer.shadowOpacity = 0.5
        greenSlider.layer.masksToBounds = false
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 1
        greenSlider.value = 0.5
        greenSlider.maximumTrackTintColor = UIColor.gray
        greenSlider.minimumTrackTintColor = UIColor.black
        greenSlider.addTarget(self, action: #selector(onChangeValueSlider(sender:)), for: .valueChanged)
        return greenSlider
              }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(self.imageView)
        
        self.view.addSubview(self.slider)

        self.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor(red: 0, green: CGFloat(slider.value), blue: 0, alpha: 1)

        
        NSLayoutConstraint.activate([
             imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
             imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
             imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
             imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//             slider.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
//             slider.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
//             slider.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -100)
        ])
        

        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        
        
          
        super.didReceiveMemoryWarning()
    
        }
    

    @objc func onChangeValueSlider(sender: UISlider){

        self.view.backgroundColor = UIColor(red: 0, green: CGFloat(sender.value), blue: 0, alpha: 1)

        let colorFilter = CIFilter(name: "CIColorCrossPolynomial")

        colorFilter!.setValue(self.inputImage, forKey: kCIInputImageKey)


        let r: [CGFloat] = [0.0, CGFloat(sender.value), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        colorFilter!.setValue(CIVector(values: r, count: 10), forKey: "inputRedCoefficients")

        colorFilter!.setValue(CIVector(values: g, count: 10), forKey: "inputGreenCoefficients")

        colorFilter!.setValue(CIVector(values: b, count: 10), forKey: "inputBlueCoefficients")

        let outputImage : CIImage = colorFilter!.outputImage!


        self.imageView.image = UIImage(ciImage: outputImage)
        self.imageView.setNeedsDisplay()

    }


}


