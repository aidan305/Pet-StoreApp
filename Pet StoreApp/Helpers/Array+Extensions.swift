//
//  Array+Extensions.swift
//  Pet StoreApp
//
//  Created by aidan egan on 27/07/2020.
//  Copyright © 2020 aidan egan. All rights reserved.
//

import Foundation
import SwiftUI

extension Array {
   //https://www.youtube.com/watch?v=VciK90dMgSo
    //whatever xontent of array is
    func chunks(size: Int) -> [ArraySlice<Element>]{
        
        var chunks: [ArraySlice<Element>] = [ArraySlice<Element>]()
        
        for index in stride(from: 0, to: self.count - 1, by: size){
            
            var chunk = ArraySlice<Element>()
            let end = index + size
            
            if end >= self.count {
                chunk = self[index..<self.count]
            } else {
                chunk = self[index..<end]
            }
            
            chunks.append(chunk)
            
            if (end + 1) == self.count {
                let remainingChunk = self[end..<self.count]
                chunks.append(remainingChunk)
            }
        }
        
        return chunks
    }
}

class Helpers {
    
    func get_image(url:URL, _completion: @escaping (Image) -> Void) {
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    let imageToReturn = Image(uiImage: image ?? UIImage())
                    _completion(imageToReturn)
                }
                
            }
        })
        task.resume()
    }
    
}

