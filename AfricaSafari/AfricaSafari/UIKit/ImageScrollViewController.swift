import UIKit

class ImageScrollViewController: UIViewController {

    // MARK:- Properties
    let resuseIdentifier: String = "cell"
    
    var imgArr = [UIImage]()
    
    var timer: Timer!
    var counter = 0
    
    lazy var backgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        return v
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 16
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor(.accentColor)
        pc.pageIndicatorTintColor = .systemGray5
        return pc
    }()
    
    // MARK:- Intializer
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        pageControl.numberOfPages = imgArr.count
        pageControl.currentPage = 0
        self.timer = Timer
            .scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        setupViews()
    }
    
    // MARK:- Helpers
    
    private func setupViews() {

        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundView.heightAnchor.constraint(equalToConstant: 300)
        ])
        

        backgroundView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: resuseIdentifier)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -50)
        ])

        backgroundView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0),
            pageControl.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0),
            pageControl.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -8),
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 4)
        ])
    }
    
    @objc func changeImage() {
        scrollCollectionView(at: counter)
    }
    
    private func scrollCollectionView(at position: Int) {
        let indexpath: IndexPath
        
        if position < imgArr.count {
            indexpath = IndexPath(item: position, section: 0)
            self.collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = position
            counter += 1
            
        } else {
            counter = 0
            indexpath = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
    }
}

// MARK:- UICollectionViewDelegate
extension ImageScrollViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath) as! ImageCell
        cell.imageView.image = imgArr[indexPath.item]
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension ImageScrollViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}
