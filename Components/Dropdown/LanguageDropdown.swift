import SwiftUI

struct LanguageDropdown: View {
    enum DropdownSize: String {
        case small = "small"
        case medium = "medium"
        case large = "large"
        
        var height: CGFloat {
            switch self {
            case .small:
                return 44
            case .medium:
                return 48
            case .large:
                return 52
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small:
                return 14
            case .medium:
                return 16
            case .large:
                return 18
            }
        }
        
        var flagSize: CGFloat {
            switch self {
            case .small:
                return 20
            case .medium:
                return 24
            case .large:
                return 28
            }
        }
    }
    
    let size: DropdownSize
    let languages: [Language]
    @Binding var selectedLanguage: Language
    @State private var isExpanded = false
    @Binding var isLoading: Bool
    
    init(
        size: DropdownSize,
        languages: [Language],
        selectedLanguage: Binding<Language>,
        isLoading: Binding<Bool> = .constant(false)
    ) {
        self.size = size
        self.languages = languages
        self._selectedLanguage = selectedLanguage
        self._isLoading = isLoading
    }
    
    var body: some View {
        VStack(spacing: 2) {
            // Selected Language Button
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            }) {
                LanguageRow(size: self.size, language: self.selectedLanguage, isMainRow: true, isExpanded: $isExpanded, isLoading: $isLoading)
                    .frame(height: size.height)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.05))
                    )
            }
            .disabled(isLoading)
            
            // Dropdown List
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(languages) { language in
                        if language != selectedLanguage {
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedLanguage = language
                                    isExpanded = false
                                }
                            }) {
                                LanguageRow(size: self.size, language: language, isMainRow: false, isExpanded: $isExpanded, isLoading: $isLoading)
                                    .frame(height: size.height)
                                    .padding(.horizontal)
                                    .background(Color.white.opacity(0.05))
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct LanguageRow: View {
    let size: LanguageDropdown.DropdownSize
    let language: Language
    let isMainRow: Bool
    @Binding var isExpanded: Bool
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            if size == .small || size == .large {
                Text(language.flag)
                    .font(.system(size: size.flagSize))
            }
            
            if size == .medium {
                Text(language.code.uppercased())
                    .foregroundColor(.white)
                    .font(.system(size: size.fontSize, weight: .medium))
            }
            
            if size == .large {
                Text(language.name)
                    .foregroundColor(.white)
                    .font(.system(size: size.fontSize, weight: .medium))
            }
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(size == .small ? 0.8 : 1.0)
            } else if (isMainRow) {
                Image(systemName: "chevron.down")
                    .foregroundColor(.white.opacity(0.7))
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .font(.system(size: size.fontSize))
            }
        }
    }
}

#Preview {
    HStack(spacing: 20) {
        LanguageDropdown(
            size: .small,
            languages: [
                Language(code: "fr", region: "FR", name: "Français"),
                Language(code: "en", region: "GB", name: "English")
            ],
            selectedLanguage: .constant(Language(code: "fr", region: "FR", name: "Français"))
        )
        
        LanguageDropdown(
            size: .medium,
            languages: [
                Language(code: "fr", region: "FR", name: "Français"),
                Language(code: "en", region: "GB", name: "English")
            ],
            selectedLanguage: .constant(Language(code: "fr", region: "FR", name: "Français"))
        )
        
        LanguageDropdown(
            size: .large,
            languages: [
                Language(code: "fr", region: "FR", name: "Français"),
                Language(code: "en", region: "GB", name: "English")
            ],
            selectedLanguage: .constant(Language(code: "fr", region: "FR", name: "Français"))
        )
    }
    .padding()
    .background(Color.black)
}

