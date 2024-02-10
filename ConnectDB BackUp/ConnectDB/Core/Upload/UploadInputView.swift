//
//  UploadInputView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 2/9/24.
//
import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

struct UploadInputView: View {
    @State private var avatarImage: UIImage?
    let defaultAvatarImage: UIImage? = UIImage(named: "defaultAvatar") // Default image as UIImage
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var title = ""
    @State private var description = ""
    @State private var isUploadSuccessful = false
    @State private var isImagePickerPresented = false // shouldShowImagePicker

    @Binding var showSignInView: Bool
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
//            List {
//                if let user = viewModel.user {
//                    Text("UserId: \(user.uid)")
//                }
//            }
//            .onAppear {
//               try? viewModel.loadCurrentUser()
//            }
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                Image(uiImage: avatarImage ?? defaultAvatarImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:75, height: 75)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            
            TextField("Title", text: $title)
                .padding()
            TextField("Description", text: $description)
                .padding()

            Button(action: {
                if avatarImage != nil {
                    uploadButtonWasTapped()
                } else {
                    photosPickerItem = PhotosPickerItem(itemIdentifier: "defaultAvatar")
                }
            }) {
                Text("Upload")
            }
        }
        .padding(30)
        .onChange(of: photosPickerItem) { _ in
            Task {
                if let photosPickerItem = photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    avatarImage = UIImage(data: data)
                }
                photosPickerItem = nil
            }
        }
    }
    

    func uploadButtonWasTapped() {
        guard let image = avatarImage else {
            print("Image not available")
            return
        }

        let randomId = UUID().uuidString
        let uploadRef = Storage.storage().reference(withPath: "memes/\(randomId).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            print("Error converting image to data")
            return
        }

        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"

        let _ = uploadRef.putData(imageData, metadata: uploadMetaData) { (downloadMetadata, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
                return
            }
            print("Put is complete. Metadata name: \(downloadMetadata?.name)")
           
            // Get the download URL
            uploadRef.downloadURL { (url, error) in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    return
                }
                if let downloadURL = url {
                    print("Image uploaded successfully. Download URL: \(downloadURL)")
                    // Get the full path
                    let fullPath = uploadRef.fullPath
                    print("Image uploaded successfully. Full path: \(fullPath)")
                    uploadToFirestore(imagePath: downloadURL.absoluteString)
                } else {
                    print("Download URL not found")
                }
            }
            // Get the full path
            let fullPath = uploadRef.fullPath
            print("Image uploaded successfully. Full path: \(fullPath)")
//            uploadToFirestore(imagePath: fullPath)
        }
    }
    
    func uploadToFirestore(imagePath: String) {
        let db = Firestore.firestore()

        let contentCollection = db.collection("content")

       
        if let userId = try? AuthenticationManager.shared.getAuthenticatedUser().uid {
                var documentData: [String: Any] = [
                    "title": title,
                    "description": description,
                    "imageUrl": imagePath,
                    "userId": userId
                ]
            
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
}

#Preview {
    UploadInputView(showSignInView: .constant(false))
}
