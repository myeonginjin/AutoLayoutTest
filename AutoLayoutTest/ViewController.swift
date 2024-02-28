
import UIKit

class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

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
    private var collectionView: UICollectionView!

    
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
        
        setupCollectionView()
        
        
        self.view.addSubview(toptabBar)
        self.view.addSubview(imageView)
        self.view.addSubview(editBar)
//        self.view.addSubview(filterView)


        
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
            editBar.bottomAnchor.constraint(equalTo:collectionView.topAnchor, constant: -16),
            
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
            
//            filterView.heightAnchor.constraint(equalToConstant: 100),
//            filterView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            filterView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            filterView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
        ])
        
    
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 70)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FilterButtonCell.self, forCellWithReuseIdentifier: "FilterButtonCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 110),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
        ])
        
        collectionView.backgroundColor = .gray
    }
    
    // MARK: UICollectionView DataSource & DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterButtonCell", for: indexPath) as? FilterButtonCell else {
            fatalError("Unable to dequeue FilterButtonCell")
        }
        cell.configure(with: UIImage(named: "input.jpg")!, name: "Filter \(indexPath.row)")
        return cell
    }
    
}



// MARK: - FilterButtonCell
class FilterButtonCell: UICollectionViewCell {
    private let thumbnailImageView = UIImageView()
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        thumbnailImageView.contentMode = .scaleAspectFit
        contentView.addSubview(thumbnailImageView)
        
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(nameLabel)
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            thumbnailImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func configure(with image: UIImage, name: String) {
        thumbnailImageView.image = image
        nameLabel.text = name
    }
}
