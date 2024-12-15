//
//  ProfileView.swift
//  Nexa
//
//  Created by Emmanuel Moulin on 29/11/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @EnvironmentObject private var alertManager: AlertManager
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                // Header
                NavigateBackHeader(title: "profile_title".translate(moduleName: "Authentication"))
                    .padding(.horizontal)
                    .padding(.bottom)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    Spacer()
                } else {
                    VStack(spacing: 16) {
                        // Profile Picture Section
                        Button(action: {
                            viewModel.isShowingImagePicker = true
                        }) {
                            ZStack {
                                ZStack {
                                    if let avatarUrl = viewModel.profile?.avatarUrl, let url = URL(string: avatarUrl) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    } else {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .overlay(
                                    Circle()
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [.blue, .purple]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 2
                                        )
                                        .frame(width: 110, height: 110)
                                )
                                
                                Image(systemName: "pencil.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .offset(x: 40, y: 40)
                            }
                        }
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 110, height: 110)
                        )
                    }
                    .padding(.bottom, 8)
                    
                    // Info section
                    VStack {
                        // Profile data Section
                        VStack(spacing: 8) {
                            // Email Field
                            EditableTextField(
                                placeholder: "email_field".translate(moduleName: "Authentication"),
                                systemImage: "envelope",
                                text: Binding(
                                    get: {
                                        viewModel.user?.email ?? ""
                                    }, set: { newValue in
                                        viewModel.user?.email = newValue
                                    }),
                                isEditing: $viewModel.isEmailEditing
                            ) {
                                Task {
                                    await viewModel.updateEmail()
                                }
                            }
                            
                            // Username Field
                            EditableTextField(
                                placeholder: "username_field".translate(moduleName: "Authentication"),
                                systemImage: "person",
                                text: Binding(
                                    get: {
                                        viewModel.profile?.username ?? ""
                                    }, set: { newValue in
                                        viewModel.profile?.username = newValue
                                    }),
                                isEditing: $viewModel.isUsernameEditing
                            ) {
                                Task {
                                    await viewModel.updateUsername()
                                }
                            }
                        }
                        .padding(.top, 8)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        // Actions Section
                        VStack(spacing: 16) {
                            SecondaryButton(title: "change_password".translate(moduleName: "Authentication")) {
                                viewModel.isShowingChangePassword = true
                            }
                            
                            AlertButton(
                                title: "logout_action".translate(moduleName: "Authentication"),
                                isLoading: $viewModel.isLogoutLoading
                            ) {
                                Task {
                                    await viewModel.logout()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $viewModel.isShowingChangePassword) {
                ChangePasswordView(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.isShowingImagePicker, onDismiss: loadImage) {
                //ImagePicker(image: $inputImage)
            }
            
            if viewModel.isUpdating {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            }
        }
        .onAppear {
            viewModel.setup(alertManager)
            Task {
                await viewModel.fetchData()
            }
        }
    }
    
    func loadImage() {
        // Implementation for loading image
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(NavigationManager())
        .environmentObject(AlertManager())
}

