//
//  UploadViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/31/24.
//

import Foundation

import SwiftUI
import Firebase
import FirebaseStorage

class UploadViewModel: ObservableObject {
   
    // Observable properties to track image upload status
    @Published var selectedImage: UIImage? // Holds the image selected by the user
    @Published var uploadedImageURL: URL? // Holds the URL of the uploaded image
    @Published var isImageUploaded = false // Tracks whether the image has been successfully uploaded
    @Published var errorMessage: String? // Stores error messages in case of failures during the upload process

    // Method to upload image data to Firebase Storage
    func uploadImage(_ image: UIImage) {
        // Convert the UIImage to JPEG data
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            // If conversion fails, set error message and return
            self.errorMessage = "Failed to convert image to data."
            return
        }

        // Initialize Firebase Storage
        let storage = Storage.storage()
        
        // Generate a unique reference for the image in Firebase Storage
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")

        // Set metadata for the image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // Upload image data to Firebase Storage
        storageRef.putData(imageData, metadata: metadata) { (_, error) in
            if let error = error {
                // If there's an error during upload, set error message
                self.errorMessage = "Error uploading image data: \(error.localizedDescription)"
            } else {
                // If upload is successful, retrieve the download URL
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        // If there's an error retrieving download URL, set error message
                        self.errorMessage = "Error getting download URL: \(error.localizedDescription)"
                    } else if let url = url {
                        // If download URL is retrieved successfully, update properties
                        print("Image uploaded successfully. URL: \(url)")
                        self.uploadedImageURL = url
                        self.isImageUploaded = true
                    }
                }
            }
        }
    }

    // Method to persist image to storage (private method)
    private func persistImageToStorage(uid: String) {
        // Print debug information
        print("Inside persistImageToStorage: ", uid)
        print("Inside persistImageToStorage uploadViewModel.selectedImage: ", self.selectedImage)
    
        // Initialize Firebase Storage reference
        let ref = Storage.storage().reference(withPath: uid)
        
        // Convert selected image to JPEG data
        guard let imageData = self.selectedImage?.jpegData(compressionQuality: 0.5) else { return }
        print("imageData: ", imageData)
        
        // Upload image data to Firebase Storage
        ref.putData(imageData, metadata: nil) {metadata, err in
            if let err = err {
                // Handle upload error
                print("Failed to push image to storage:\(err)")
                return
            }
            // Retrieve download URL for the uploaded image
            ref.downloadURL { url, err in
                if let err = err {
                    // Handle error retrieving download URL
                    print("Failed to retrieve downloadURL:\(err)")
                    return
                }
                // Print the URL path
                let urlPath = url?.absoluteString ?? ""
                print("URL Path: ", urlPath)
            }
        }
    }
}


//old
//import SwiftUI
//import Firebase
//import FirebaseStorage
//
//class UploadViewModel: ObservableObject {
//    @Published var uploadedImageURL: URL?
//    @Published var isImageUploaded = false
//    
//    func uploadImage(_ image: UIImage) {
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//
//        let storage = Storage.storage()
//        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
//
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//
//        storageRef.putData(imageData, metadata: metadata) { (_, error) in
//            if let error = error {
//                print("Error uploading image: \(error)")
//            } else {
//                storageRef.downloadURL { (url, error) in
//                    if let error = error {
//                        print("Error getting download URL: \(error)")
//                    } else if let url = url {
//                        print("Image uploaded successfully. URL: \(url)")
//                        self.uploadedImageURL = url
//                        self.isImageUploaded = true
//                    }
//                }
//            }
//        }
//    }
//}
//
