//
//  CustomImageView.swift
//  UITV_Programmatically
//  https://youtu.be/Axe4SoUigLU - Async image loading
//  Created by Uri on 6/12/22.
//

import UIKit

// MARK: - Image Caching

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - Custom Image View

class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL) {
        image = nil         // to delete the previous image stored on the reused cell
        addSpiner()
        
        if let task = task {    // if there's a task running...
            task.cancel()       // cancel the task running
        }
        
        // if there's an image stored in cache
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache
            removeSpinner()
            return
        }
        
        // if there's no image stored in cache we download it calling the URL from our Amiibo class
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print("Couldn't load image from url: \(url)")
                return
            }
            
            // store the newImage using its unique URL
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task.resume()
    }
    
    func addSpiner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.removeFromSuperview()
    }
}
