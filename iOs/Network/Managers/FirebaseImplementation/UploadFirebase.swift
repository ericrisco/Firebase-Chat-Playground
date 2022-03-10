//
//  UploadFirebase.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 8/3/22.
//  Copyright © 2022 ERISCO. All rights reserved.
//

import Foundation
import FirebaseStorage

public class UploadFirebase: UploadManager {
    
    public func save(name: String, image: UIImage, onSuccess: @escaping (String) -> Void, onError: ErrorClosure?) {
        
        let ref = Storage.storage().reference().child("ChatKeepcoding").child(name)
        
        if let imageData = UIImageJPEGRepresentation(image, 0.4) {
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            metadata.customMetadata = [ "user" : "Papa Noel" ]
            
            ref.putData(imageData, metadata: metadata) { metadata, error in
                
                if let err = error, let retError = onError {
                    retError(err)
                }
                
                ref.downloadURL { url, error in
                    
                    if let err = error, let retError = onError {
                        retError(err)
                    }
                    
                    onSuccess(url?.absoluteString ?? "")
                    
                }
            
            }
            
        }
        
    }
    
}
