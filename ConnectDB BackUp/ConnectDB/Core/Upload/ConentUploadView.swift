//
//  ConentUploadView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 2/1/24.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ContentUploadViewModel: ObservableObject {
    
     @Published var selectedImage: UIImage?
     @Published var uploadedImageURL: URL?
     @Published var isImageUploaded = false
     @Published var errorMessage: String?
    
    // Singleton instance for shared access
    static let shared = ContentUploadViewModel()
    // Initialize the user manager and fetch initial user data from Firestore
    init() {
        // Points to the root reference
        let storageRef = Storage.storage().reference()

        // Points to "images"
        let imagesRef = storageRef.child("images")
        }
    }
    
    func createNewContent() {
        
        // Points to the root reference
        let storageRef = Storage.storage().reference()

        // Points to "images"
        let imagesRef = storageRef.child("images")

        // Points to "images/space.jpg"
        // Note that you can use variables to create child values
        let fileName = "space.jpg"
        let spaceRef = imagesRef.child(fileName)

        // File path is "images/space.jpg"
        let path = spaceRef.fullPath

        // File name is "space.jpg"
        let name = spaceRef.name

        // Points to "images"
        let images = spaceRef.parent()
        
        // Local file you want to upload
        let localFile = URL(string: "path/to/image")!

        // Create the file metadata
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        // Upload file and metadata to the object 'images/mountains.jpg'
        let uploadTask = storageRef.putFile(from: localFile, metadata: metadata)

        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
          // Upload resumed, also fires when the upload starts
        }

        uploadTask.observe(.pause) { snapshot in
          // Upload paused
        }

        uploadTask.observe(.progress) { snapshot in
          // Upload reported progress
          let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
        }

        uploadTask.observe(.success) { snapshot in
          // Upload completed successfully
        }

        uploadTask.observe(.failure) { snapshot in
          if let error = snapshot.error as? NSError {
            switch (StorageErrorCode(rawValue: error.code)!) {
            case .objectNotFound:
              // File doesn't exist
              break
            case .unauthorized:
              // User doesn't have permission to access file
              break
            case .cancelled:
              // User canceled the upload
              break

            /* ... */

            case .unknown:
              // Unknown error occurred, inspect the server response
              break
            default:
              // A separate error occurred. This is a good place to retry the upload.
              break
            }
          }
        }
}

struct ConentUploadView: View {
    
    @State private var isUploadSuccessful = false
    @State var image: UIImage?
    @ObservedObject var uploadViewModel = ContentUploadViewModel()
    @Binding var showSignInView: Bool
    
    @State private var isImagePickerPresented = false // shouldShowImagePicker
    
    
    var body: some View {
        NavigationView {
            VStack {
                // Display the selected image or the default image
                if let selectedImage = uploadViewModel.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding()
                } else {
                    // Default image
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding()
                        .foregroundColor(.gray)
                }
                // Image picker button
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    Text("Choose Image")
                }
                .padding()
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $uploadViewModel.selectedImage)
                }
                // Button to trigger the data upload
                Button("Upload to Firestore") {
                    createNewContent()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ConentUploadView(showSignInView: .constant(false))
}
