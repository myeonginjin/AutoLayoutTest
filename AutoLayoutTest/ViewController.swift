
import UIKit
import PhotosUI

struct XMLFilter {
    var name: String = ""
}





class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    private let toptabBar : UIView = UIView()
    private let galleryBtn : UIButton = UIButton()
    private let toggleBtn : UIButton = UIButton()
    private let saveBtn : UIButton = UIButton()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let editBar : UIView = UIView()
    private let slider1 : UISlider = UISlider()
    private let slider2 : UISlider = UISlider()
    private let likeBtn : UIButton = UIButton()
    private let filterView : UIView  = UIView()
    private let inputImage = CIImage(image: UIImage(named: "input.jpg")!)
    private var collectionView: UICollectionView!

    private var xmlFiltersList: [XMLFilter] = []
    
    private var originalImage: UIImage?
    private var filteredImage: UIImage?
    
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
        
        
    
        
        editBar.addSubview(slider1)
        editBar.addSubview(slider2)
        editBar.addSubview(likeBtn)
        
        
        
        
        setupCollectionView()
        loadXMLFiltersData()
        
        self.view.addSubview(toptabBar)
        self.view.addSubview(imageView)
        self.view.addSubview(editBar)
//        self.view.addSubview(filterView)

        
        // slider2 설정
        slider2.minimumValue = 0.0  // 최소 투명도 값
        slider2.maximumValue = 1.0  // 최대 투명도 값
        slider2.value = 1.0  // 초기 투명도 값 (기본적으로 이미지가 완전 불투명하도록 설정)
        slider2.addTarget(self, action: #selector(slider2ValueChanged(_:)), for: .valueChanged)
        
        
        galleryBtn.setTitle("Gallery", for: .normal)
        galleryBtn.addTarget(self, action: #selector(openGallery(_:)), for: .touchUpInside)
        
        toggleBtn.setTitle("Toggle", for: .normal)
        toggleBtn.addTarget(self, action: #selector(toggleImage), for: .touchDown)
        toggleBtn.addTarget(self, action: #selector(showFilteredImage), for: .touchUpInside)
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.addTarget(self, action: #selector(saveImage), for: .touchUpInside)
        
        
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
    
    @objc private func openGallery() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        originalImage = image

        imageView.image = originalImage
        dismiss(animated: true)
    }
    
    @objc private func toggleImage() {
        imageView.image = originalImage
    }

    @objc private func showFilteredImage() {
        imageView.image = filteredImage
    }
    
    @objc private func saveImage() {
        guard let imageToSave = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // 에러 처리
            showToast(message: "Error saving image: \(error.localizedDescription)", seconds: 0.5)
        } else {
            // 저장 성공 알림
            showToast(message: "Image successfully saved", seconds: 0.5)
        }
    }
    
    @objc func slider2ValueChanged(_ sender: UISlider) {
        imageView.alpha = CGFloat(sender.value)
    }


    func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
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
        return xmlFiltersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterButtonCell", for: indexPath) as? FilterButtonCell else {
            fatalError("Unable to dequeue FilterButtonCell")
        }
        let filter = xmlFiltersList[indexPath.row]
        cell.configure(with: UIImage(named: "input.jpg")!, name: "\(filter.name)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        let filterName = xmlFiltersList[indexPath.row].name
        
        print(filterName)
        applyFilter(filterName: filterName)
        
    }
    
    func applyFilter(filterName: String) {
        guard let originalImage = originalImage else { return }
        let ciImage = CIImage(image: originalImage) // UIImage를 CIImage로 변환

        if let filter = CIFilter(name: filterName) {
            filter.setValue(ciImage, forKey: kCIInputImageKey) // CIImage 사용

            // 필터마다 필요한 추가 파라미터 설정
            switch filterName {
            case "CISepiaTone":
                filter.setValue(0.8, forKey: kCIInputIntensityKey) // 세피아 강도 설정
            case "CIVignette":
                filter.setValue(2, forKey: kCIInputIntensityKey) // 빈야트 강도 설정
                filter.setValue(30, forKey: kCIInputRadiusKey) // 빈야트 반경 설정
            case "CIColorControls":
                filter.setValue(0.5, forKey: kCIInputBrightnessKey) // 밝기 조절
                filter.setValue(1.5, forKey: kCIInputContrastKey) // 대비 조절
                filter.setValue(1.2, forKey: kCIInputSaturationKey) // 채도 조절
            case "CIColorMonochrome":
                filter.setValue(CIColor(color: UIColor.gray), forKey: "inputColor") // 흑백 색상 설정
                filter.setValue(1.0, forKey: "inputIntensity") // 색상 강도 설정
            case "CIPhotoEffectChrome":
                // 크롬 효과는 추가 파라미터가 필요 없습니다.
                break
            default:
                print("Filter not supported")
                return
            }

            let context = CIContext()
            if let outputCIImage = filter.outputImage,
               let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(cgImage: cgImage)
                    self.filteredImage = UIImage(cgImage: cgImage) // 필터 적용 이미지 저장
                }
            } else {
                print("Failed to create output image")
            }
        }
    }

        
        
    
    
    func loadXMLFiltersData() {
        if let url = Bundle.main.url(forResource: "filters", withExtension: "xml"),
           let data = try? Data(contentsOf: url) {
            print("XML 데이터 로드 성공") // 성공적으로 로드되었는지 확인
            let parser = XMLFiltersParser()
            let xmlFilters = parser.parse(data: data)
            self.xmlFiltersList = xmlFilters
            collectionView.reloadData()
        } else {
            print("XML 데이터 로드 실패") // 파일 로드 실패 시
        }
    }
    
    class XMLFiltersParser: NSObject, XMLParserDelegate {
        var filters: [XMLFilter] = []
        var currentElement = ""
        var currentFilter: XMLFilter?
        var currentValue = ""

        // 추가된 parse(data:) 메서드
        func parse(data: Data) -> [XMLFilter] {
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            return filters
        }

        // 태그의 시작
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            print("시작 태그: \(elementName)")
            
            currentElement = elementName
            if elementName == "filter" {
                currentFilter = XMLFilter()
            }
        }

        // 태그 사이의 문자열
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            
            print("찾은 문자열: \(string)")
            
            currentValue += string
        }

        // 태그의 끝
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            
            print("종료 태그: \(elementName)")
            
            switch elementName {
            case "filter":
                if let filter = currentFilter {
                    filters.append(filter)
                }
                currentFilter = nil
            case "name":
                currentFilter?.name = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)

            default:
                currentFilter?.name = currentValue.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            currentValue = ""
        }
    }
    
    
    // ViewController 클래스 내에 추가합니다.

    @objc func openGallery(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            // 갤러리 사용 불가능 알림
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
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
        nameLabel.font = UIFont.systemFont(ofSize: 10)
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
