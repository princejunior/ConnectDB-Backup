//
//  UploadView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage


struct UploadView: View {
    
    @State private var title = ""
    @State private var description = ""
    @State private var isUploadSuccessful = false
    @State var image: UIImage?
//    @State var selectedImage = ""
    //        @StateObject private var uploadViewModel = UploadViewModel()
    @ObservedObject var uploadViewModel = UploadViewModel()
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
                
                // Text fields for entering title and description
                TextField("Title", text: $title)
                    .padding()
                
                TextField("Description", text: $description)
                    .padding()
                
                // Button to trigger the data upload
                Button("Upload to Firestore") {
                    uploadToFirestore()
                }
                .padding()
                
                // Navigation link to display view upon successful upload
                NavigationLink(
                    destination: isUploadSuccessful ? DisplayView(showSignInView: $showSignInView) : nil,
                    isActive: $isUploadSuccessful,
                    label: { EmptyView() }
                )
                .hidden()
                
                // Spacer for layout
                Spacer()
            }
            .navigationTitle("Upload Data")
        }
        .onChange(of: uploadViewModel.isImageUploaded) { newValue in
            if newValue {
                //                    ImagePicker(selectedImage: $image)
                uploadToFirestore()
            }
        }
    }
    
//    func uploadToFirestore() {
//        print("uploadToFirestore uploadViewModel.selectedImage" , uploadViewModel.selectedImage)
//        
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        let db = Firestore.firestore()
//        
//        let contentCollection = db.collection("content")
//        
//        // Create document data
//        var documentData: [String: Any] = [
//            "user_id": uid,
//            "title": title,
//            "description": description,
//        ]
//        
//        // Unwrap and append the image URL if available
//        if let imageURLString = uploadViewModel.uploadedImageURL?.absoluteString {
//            documentData["image"] = [imageURLString]
//        }
//        
//        let contentDocument = contentCollection.document()
//        
//        documentData["id"] = contentDocument.documentID
//        
//        contentDocument.setData(documentData) { error in
//            if let error = error {
//                print("Error adding document: \(error)")
//            } else {
//                print("Document added successfully with ID: \(contentDocument.documentID)")
//                isUploadSuccessful = true
//            }
//        }
//    }
//    private func  persistImageToStorage(uid: String) {
//        print("Inside persistImageToStorage: ", uid)
//        print("Inside persistImageToStorage uploadViewModel.selectedImage: ", uploadViewModel.selectedImage)
//        //        let filename = UUID().uuidString
//        
//        //        guard let uid = UserManager.shared.user.uid else {
//        //
//        //        }
//        //        FirebaseManager.shared.storage.reference(withPath: <#T##String#>)
//        
//        let ref = Storage.storage().reference(withPath: uid)
//        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {return}
//        print("imageData: ", imageData)
//        ref.putData(imageData, metadata: nil) {metadata, err in
//            if let err = err {
//                print("Failed to push image to storage:\(err)")
//                return
//            }
//            ref.downloadURL { url, err in
//                if let err = err {
//                    print("Failed to retrieve downloadURL:\(err)")
//                    return
//                }
//                let urlPath = url?.absoluteString ?? ""
//                print("URL Path: ", urlPath)
//            }
//        }
//    }
//}
    
    func uploadToFirestore() {
        let db = Firestore.firestore()

        let contentCollection = db.collection("content")

        var documentData: [String: Any] = [
            "title": title,
            "description": description
            // Add any other fields you need
        ]
        // Then, when appending the image URL:
        if var imageArray = documentData["image"] as? NSMutableArray {
            // The "image" key already has a mutable array value
            imageArray.add(uploadViewModel.uploadedImageURL?.absoluteString ?? "")
            documentData["image"] = imageArray
        } else {
            // The "image" key does not exist or is not a mutable array, create a new mutable array
            documentData["image"] = NSMutableArray(array: [uploadViewModel.uploadedImageURL?.absoluteString ?? ""])
        }

//        if let uploadedImageURL = uploadViewModel.uploadedImageURL {
//
//           documentData["image"] = uploadedImageURL.absoluteString
//        }
        print(documentData)
        let contentDocument = contentCollection.document()

        documentData["id"] = contentDocument.documentID

        contentDocument.setData(documentData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully with ID: \(contentDocument.documentID)")
                isUploadSuccessful = true
            }
        }
    }
}



// old
//// View for uploading data to Firestore
//struct UploadView: View {
//    // State variables to hold title, description, and upload success state
//    @State private var title = ""
//    @State private var description = ""
//    @State private var isUploadSuccessful = false
//    
//    // Binding to control the visibility of the sign-in view
//    @Binding var showSignInView: Bool
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Text field for entering the title
//                TextField("Title", text: $title)
//                    .padding()
//                
//                // Text field for entering the description
//                TextField("Description", text: $description)
//                    .padding()
//                
//                // Button to trigger the data upload
//                Button("Upload to Firestore") {
//                    uploadToFirestore()
//                }
//                .padding()
//                
//                // Navigation link to display view upon successful upload
//                NavigationLink(
//                    destination: isUploadSuccessful ? DisplayView(showSignInView: $showSignInView) : nil,
//                    isActive: $isUploadSuccessful,
//                    label: { EmptyView() }
//                )
//                .hidden()  // Hidden, as it's programmatically triggered
//                
//                // Spacer for layout
//                Spacer()
//            }
//            .navigationTitle("Upload Data")
//        }
//    }
//    
//    // Function to upload data to Firestore
//    func uploadToFirestore() {
//        let db = Firestore.firestore()
//        
//        // Assuming you have a "content" collection
//        let contentCollection = db.collection("content")
//        
//        // Prepare document data with title and description
//        var documentData: [String: Any] = [
//            "title": title,
//            "description": description
//            // Add any other fields you need
//        ]
//        
//        // Use document() to automatically generate a unique ID for the document
//        let contentDocument = contentCollection.document()
//        
//        // Set the document ID in the data
//        documentData["id"] = contentDocument.documentID
//        
//        // Set data in Firestore document
//        contentDocument.setData(documentData) { error in
//            if let error = error {
//                print("Error adding document: \(error)")
//            } else {
//                // Print success message and trigger navigation
//                print("Document added successfully with ID: \(contentDocument.documentID)")
//                isUploadSuccessful = true
//            }
//        }
//    }
//}

// Preview provider for UploadView
struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(showSignInView: .constant(false))
    }
}
