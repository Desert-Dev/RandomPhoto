//
//  ImageManager.swift
//  RandomPhoto
//
//  Created by Santiago Gomez del campo on 17/07/21.
//

import Foundation

//if let url = URL(string: "https://api.unsplash.com/photos/random?client_id=bPHyShm3_x8EGNWOi9dFCiTQ2pbMqf_0acpG6GQehjA") {

protocol ImageManagerDelegate {
    func didUpdateImage(_ imageManager: ImageManager, _ image: ImageModel)
    func didFailWithError(error: Error)
}

struct ImageManager {
    
    var delegate : ImageManagerDelegate?
    
    func getRandomImage() {
        
        // 1. Create URL
        if let imageURL = URL(string: "https://api.unsplash.com/photos/random?client_id=bPHyShm3_x8EGNWOi9dFCiTQ2pbMqf_0acpG6GQehjA") {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Create a new data task for the URLSession (dataTask = "Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.")
            let task = session.dataTask(with: imageURL) { data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let image = self.parseJSON(safeData) {
                        self.delegate?.didUpdateImage(self, image)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ data: Data) -> ImageModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ImageData.self, from: data)
            let URLImage = decodedData.urls.regular
            let imageDescription = decodedData.alt_description
            
            let randomImage = ImageModel(imageURL: URLImage, description: imageDescription)
            
            return randomImage

        } catch {
            print("Error en catch de image manager linea 65")
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
