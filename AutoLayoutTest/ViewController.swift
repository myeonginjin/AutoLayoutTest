
import UIKit

class ViewController: UIViewController {

    private let toptabBar : UIView = UIView()
    private let galleryBtn : UIButton = UIButton()
    private let toggleBtn : UIButton = UIButton()
    private let saveBtn : UIButton = UIButton()
    private let imageView : UIImageView = UIImageView()
    private let editBar : UIView = UIView()
    private let slider1 : UISlider = UISlider()
    private let slider2 : UISlider = UISlider()
    private let likeBtn : UIButton = UIButton()
    private let filterView : UIView  = UIView()
    private let inputImage = CIImage(image: UIImage(named: "input.jpg")!)

    
    override func viewDidLoad() {
        
        toptabBar.translatesAutoresizingMaskIntoConstraints = false
        galleryBtn.translatesAutoresizingMaskIntoConstraints = false
        toggleBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        editBar.translatesAutoresizingMaskIntoConstraints = false
        slider1.translatesAutoresizingMaskIntoConstraints = false
        slider2.translatesAutoresizingMaskIntoConstraints = false
        likeBtn.translatesAutoresizingMaskIntoConstraints = false
        filterView.translatesAutoresizingMaskIntoConstraints = false
        
        toptabBar.backgroundColor = .gray
        imageView.backgroundColor = .gray
        editBar.backgroundColor = .gray
        filterView.backgroundColor = .gray
        galleryBtn.backgroundColor = .white
        toggleBtn.backgroundColor = .white
        saveBtn.backgroundColor = .white
        slider1.backgroundColor = .white
        slider2.backgroundColor = .white
        likeBtn.backgroundColor = .white
        
        
        toptabBar.addSubview(galleryBtn)
        toptabBar.addSubview(toggleBtn)
        toptabBar.addSubview(saveBtn)
        
        
        imageView.image = UIImage(ciImage: inputImage!)
        
        editBar.addSubview(slider1)
        editBar.addSubview(slider2)
        editBar.addSubview(likeBtn)
        
        
        self.view.addSubview(toptabBar)
        self.view.addSubview(imageView)
        self.view.addSubview(editBar)
        self.view.addSubview(filterView)


        
        NSLayoutConstraint.activate([
            toptabBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            toptabBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            toptabBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            toptabBar.heightAnchor.constraint(equalToConstant: 50),

            galleryBtn.leadingAnchor.constraint(equalTo: toptabBar.leadingAnchor, constant: 8),
            galleryBtn.centerYAnchor.constraint(equalTo: toptabBar.centerYAnchor),
            galleryBtn.heightAnchor.constraint(equalToConstant: 50),
            galleryBtn.widthAnchor.constraint(equalToConstant: 30),

            saveBtn.trailingAnchor.constraint(equalTo: toptabBar.trailingAnchor, constant: -8),
            saveBtn.centerYAnchor.constraint(equalTo: toptabBar.centerYAnchor),
            saveBtn.heightAnchor.constraint(equalToConstant: 50),
            saveBtn.widthAnchor.constraint(equalToConstant: 30),

            toggleBtn.trailingAnchor.constraint(equalTo: saveBtn.leadingAnchor, constant: -8),
            toggleBtn.centerYAnchor.constraint(equalTo: toptabBar.centerYAnchor),
            toggleBtn.heightAnchor.constraint(equalToConstant: 50),
            toggleBtn.widthAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: toptabBar.bottomAnchor, constant: 24),
            imageView.bottomAnchor.constraint(equalTo:editBar.topAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 8),
            
            
            editBar.heightAnchor.constraint(equalToConstant: 50),
            editBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            editBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            editBar.bottomAnchor.constraint(equalTo:filterView.topAnchor, constant: -16),
            
            slider1.leadingAnchor.constraint(equalTo: editBar.leadingAnchor, constant: 24),
            slider1.topAnchor.constraint(equalTo: editBar.topAnchor, constant: 8),
            slider1.bottomAnchor.constraint(equalTo: editBar.bottomAnchor, constant: -8),
            slider1.widthAnchor.constraint(equalToConstant: 126),
            
            
            slider2.leadingAnchor.constraint(equalTo: slider1.trailingAnchor, constant: 24),
            slider2.topAnchor.constraint(equalTo: editBar.topAnchor, constant: 8),
            slider2.bottomAnchor.constraint(equalTo: editBar.bottomAnchor, constant: -8),
            slider2.widthAnchor.constraint(equalToConstant: 126),
            
            likeBtn.trailingAnchor.constraint(equalTo: editBar.trailingAnchor, constant: -24),
            likeBtn.topAnchor.constraint(equalTo: editBar.topAnchor, constant: 8),
            likeBtn.bottomAnchor.constraint(equalTo: editBar.bottomAnchor, constant: -8),
            likeBtn.widthAnchor.constraint(equalToConstant: 30),
            
            filterView.heightAnchor.constraint(equalToConstant: 100),
            filterView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            filterView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
        ])
        
        
    }
    
    




}


