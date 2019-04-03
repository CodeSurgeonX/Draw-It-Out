//
//  ViewController.swift
//  Drawing
//
//  Created by Shashwat  on 03/04/19.
//  Copyright © 2019 Shashwat . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var colorsSelection : [UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.9614303708, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1),#colorLiteral(red: 1, green: 0.3407757282, blue: 0.0481993109, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1),#colorLiteral(red: 0, green: 1, blue: 0.272815913, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 1, green: 0.6377373934, blue: 0.8127990365, alpha: 1),#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)]
    
    lazy var clearButton : UIButton = {
        let button =  UIButton()
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(cleanCanvas), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    lazy var colorPallete : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout:flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "Reusable Cell")
        cv.bounces = true
        return cv
        
    }()
    
    var canvas : Canvas!
    var size : CGSize!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let barButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(cleanCanvas))
//
//        self.navigationItem.rightBarButtonItem = barButton
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cleanCanvas))
//        self.navigationController?.navigationBar.tintColor = .clear
//        self.navigationController?.navigationBar.barTintColor = .clear
//        self.navigationController?.navigationBar.backgroundColor = .clear
        // Do any additional setup after loading the view.
        canvas = Canvas(frame:  CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 100), withColor: .black)
        self.view.addSubview(canvas)
        canvas.backgroundColor = .white
        self.view.addSubview(colorPallete)
        colorPallete.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 0).isActive = true
        colorPallete.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 0).isActive = true
        colorPallete.topAnchor.constraint(equalToSystemSpacingBelow: canvas.bottomAnchor, multiplier: 0).isActive = true
        colorPallete.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        self.view.addSubview(clearButton)
        clearButton.rightAnchor.constraint(equalToSystemSpacingAfter: view.rightAnchor, multiplier: 0).isActive = true
        clearButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0).isActive = true
        clearButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func  cleanCanvas(){
        canvas.cleanCanvas()
    }


}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorsSelection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorPallete.dequeueReusableCell(withReuseIdentifier: "Reusable Cell", for: indexPath)
        cell.backgroundColor = colorsSelection[indexPath.row]
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        canvas.chosenColor = colorsSelection[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
   
    
  
    
}

class CustomCell : UICollectionViewCell {
    
}

