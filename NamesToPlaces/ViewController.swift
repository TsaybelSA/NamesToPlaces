//
//  ViewController.swift
//  NamesToPlaces
//
//  Created by Сергей Цайбель on 08.06.2022.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var places = [Place]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPlace))
		
	}
	
	@objc func addNewPlace() {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.allowsEditing = true
		present(picker, animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }
		
		let imageName = UUID().uuidString
		let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
		
		if let jpeg = image.jpegData(compressionQuality: 0.7) {
			try? jpeg.write(to: imagePath)
		}
		
		places.append(Place(name: "Unknown", image: imageName))
		
		collectionView?.reloadData()
		
		dismiss(animated: true)
	}
	
	func getDocumentsDirectory() -> URL {
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return path[0]
	}
	
	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return places.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Place", for: indexPath) as! PlaceCell
		
		let place = places[indexPath.item]
		cell.name.text = place.name
		
		let path = getDocumentsDirectory().appendingPathComponent(place.image)
		cell.imageView.image = UIImage(contentsOfFile: path.path)
		
//		cell.imageView.layer.borderWidth
		return cell
	}
}

