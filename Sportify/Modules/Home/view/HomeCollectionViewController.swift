//
//  HomeCollectionViewController.swift
//  Sportify
//
//  Created by aya on 15/05/2024.
//

import UIKit



class HomeCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var sportTypes = ["Football", "Basketball", "Cricket" , "Tennis" ]
    let imageNames = ["18.jpg", "11.jpg", "19.jpg","10.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            let spacing: CGFloat = 80
        
            collectionView.contentInset = UIEdgeInsets(top: spacing, left: 10, bottom: 0, right: 10)
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            collectionView.backgroundColor = UIColor.white
            collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportTypes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! CustomCell
        cell.images.image = UIImage(named:imageNames[indexPath.row])
        cell.label(with: sportTypes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 270)
    }


    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tappped")
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
            guard let secondVC = secondStoryboard.instantiateViewController(withIdentifier: "SecondViewControllerIdentifier") as? LeguesTableViewController else {
                return
            }
        secondVC.sportType = sportTypes[indexPath.row].lowercased()

        navigationController?.pushViewController(secondVC, animated: true)
    }
  
}


class CustomCell :UICollectionViewCell{
    let images = UIImageView()
      let label = UILabel()
      override init(frame: CGRect) {
          super.init(frame: frame)
         
          addSubview(images)
          images.translatesAutoresizingMaskIntoConstraints = false
          images.topAnchor.constraint(equalTo: topAnchor).isActive = true
          images.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
          images.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
          images.heightAnchor.constraint(equalToConstant: 200).isActive = true

          addSubview(label)
          label.translatesAutoresizingMaskIntoConstraints = false
          label.topAnchor.constraint(equalTo: images.bottomAnchor, constant: 8).isActive = true
          label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
          label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
          label.heightAnchor.constraint(equalToConstant: 30).isActive = true

          label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
          label.textColor = .black
          label.textAlignment = .center

          images.layer.cornerRadius = 20
          images.layer.masksToBounds = true
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init has been imp")
      }

      func label(with text: String) {
          label.text = text
      }
}
