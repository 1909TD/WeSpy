import SwiftUI

struct KeywordManagementView: View {
    @ObservedObject var keywordManager: KeywordManager
    @State private var newKeyword: String = ""
    @State private var showingAddKeyword = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Quản lý từ khóa")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Thêm từ khóa tùy chỉnh của bạn")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .padding(.top)
                    
                    // Add keyword section
                    VStack(spacing: 12) {
                        HStack {
                            TextField("Nhập từ khóa mới...", text: $newKeyword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .submitLabel(.done)
                                .onSubmit {
                                    addKeyword()
                                }
                            
                            Button(action: addKeyword) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            .disabled(newKeyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding(.horizontal)
                        
                        if !keywordManager.customKeywords.isEmpty {
                            Text("Từ khóa tùy chỉnh (\(keywordManager.customKeywords.count))")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top)
                        }
                    }
                    
                    // Custom keywords list
                    if !keywordManager.customKeywords.isEmpty {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(keywordManager.customKeywords, id: \.self) { keyword in
                                    HStack {
                                        Text(keyword)
                                            .foregroundColor(.white)
                                            .padding(.leading)
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            keywordManager.removeCustomKeyword(keyword)
                                        }) {
                                            Image(systemName: "trash.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title3)
                                        }
                                        .padding(.trailing)
                                    }
                                    .padding(.vertical, 8)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 12) {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.6))
                            
                            Text("Chưa có từ khóa tùy chỉnh")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text("Thêm từ khóa đầu tiên của bạn ở trên")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding()
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                    
                    // Info section
                    VStack(spacing: 8) {
                        Text("💡 Gợi ý")
                            .font(.headline)
                            .foregroundColor(.yellow)
                        
                        Text("• Từ khóa tùy chỉnh sẽ được lưu trên thiết bị của bạn\n• Chúng sẽ xuất hiện trong gợi ý khi tìm kiếm\n• Bạn có thể xóa từ khóa bất cứ lúc nào")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Đóng") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    private func addKeyword() {
        let trimmedKeyword = newKeyword.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedKeyword.isEmpty {
            keywordManager.addCustomKeyword(trimmedKeyword)
            newKeyword = ""
        }
    }
}

#Preview {
    KeywordManagementView(keywordManager: KeywordManager())
} 