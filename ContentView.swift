import SwiftUI

struct ContentView: View {
    @StateObject private var keywordManager = KeywordManager()
    @State private var keyword: String = ""
    @State private var result: [String] = []
    @State private var suggestions: [String] = []
    @State private var showingSuggestions = false
    @State private var showingKeywordManagement = false
    @FocusState private var isTextFieldFocused: Bool
    
    // Danh sách nhóm từ khoá
    let keywordGroups: [[String]] = [
        ["phố đi bộ", "vỉa hè"],
        ["Quyển sách", "quyển từ điển", "quyển vở"],
        ["đà lạt", "gia lai"],
        ["con bọ cạp", "con tôm"],
        ["hạt tiêu", "ớt"],
        ["phú quốc", "phú quý"],
        ["trúc", "tre"],
        ["tre", "cao"],
        ["đi bộ", "chạy"],
        ["Ngôi mộ đom đóm", "thuỷ thủ mặt trăng"],
        ["xe hơi", "xe máy"],
        ["gạo nếp", "gạo lức", "gạo tẻ", "gạo thường"],
        ["hàm nghi", "tôn thất thuyết"],
        ["răng xứ", "răng khểnh"],
        ["thuốc lá", "xì gà", "thuốc lào"],
        ["Long An", "An Giang"],
        ["đấu trường ai cập"],
        ["brazil", "argentina"],
        ["Nguyễn Quan Hải", "Nguyễn Công Phượng"],
        ["con rắn", "con thạch sùng"],
        ["chạy tiếp sức", "chạy marathon"],
        ["Lan", "Ly"],
        ["Đũa", "nĩa"],
        ["cung kim ngưu", "cung sư tử"],
        ["bánh xèo", "bánh khọt"],
        ["mì tôm", "bún đậu"],
        ["xe container", "xe tải"],
        ["Lavie", "TH truewater", "Aquafina"],
        ["pizza", "hotdog", "hamburger"],
        ["hình chụp", "Tranh vẽ"],
        ["Bọ Cạp", "Bạch Dương"],
        ["đậu bắp", "đậu đũa"],
        ["cá rô", "cá nóc"],
        ["Kristen Stewart", "Emma Watson"],
        ["chim sơn ca", "chim gõ kiến"],
        ["nước lọc", "nước suối", "nước muối", "nước mắm", "nước cốt dừa","nước đường","nước ngọt"],
        ["con hến", "con sò"],
        ["triết lí", "triếc học"],
        ["Mỳ trộn", "Mỳ xào"],
        ["yomost", "milo"],
        ["cacao", "cà phê"],
        ["Hậu Hoàng", "Vanh Leg"],
        ["bút mực", "bút máy", "bút chì", "bút xoá", "bút bi","bút lông"],
        ["Quan Hiểu Đồng","Cúc Tịnh Y"],
        ["Đài phát thanh","Máy nghe nhạc"],
        ["Android","Iphone"],
        ["cờ caro","áo caro"],
        ["con gấu trúc","con gấu đỏ","(Gợi ý fake vui ngựa vằng nếu gốc trúc)"],
        ["kẹo dẻo","kẹo cao cu"],
        ["jack","soobin hoàng sơn"],
        ["đấu trường Ai Cập","Vường treo Babilon"],
        ["diều","máy bay"],
        ["jung kook","Jimin"],
        ["sạc diện thoại","sạc dự phòng"],
        ["tỏ tình","cầu hôn"],
        ["chữ cái","chữ số"],
        ["Cá Ngựa","Cá vàng"],
        ["thập kỉ","thiên niên kỉ"],
        ["Gin Tuấn Kiệt","Lê Dương Bảo Lâm"],
        ["Giáo Viên","Học Sinh"],
        ["bình thạnh","bình tân"],
        ["Midu","Han Sara"],
        ["Sa Tăng","Trư Bát Giới"],
        ["Khu du lịch","Khu sinh thái"],
        ["Phương Mỹ Chi","Hồ Ngọc Hà"],
        ["Kẹo gừng","Kẹo lạc"],
        ["Chè hạt sen","chè bưởi"],
        ["Phu nhân","Tình Nhân"],
        ["Gà tre","Gà ác"],
        ["Lò sưởi","Điều hoà"],
        ["Con khỉ","Con lười","Con đười ươi"],
        ["Cây chuối","Cây mít"],
        ["Bún","Miến"],
        ["Aladdin","alibaba"],
        ["muối hảo hảo","muối ô mai"],
        ["chipu","chi dân"],
        ["cây táo","cây mít"],
        ["Hình học","Đại số"],
        ["pháo","boom"],
        ["ôtô bán tải","ôtô tảo"],
        ["chipu","chi dân"],
        ["zalo","facebook","Wechat"],
        ["quạt hơi nước","náy phun sương"],
        ["Nốt ruồi","Vết bớt"],
        ["thịt bò","thịt gà"],
        ["hoa hồng","hoa huệ"],
        ["găng tay","đôi tất"],
        ["Tôm Hùm","Tôm Sông"],
        ["lắc chân","vòng tay"],
        ["Người yêu củ","Người yêu"],
        ["Con bò","Con mèo"],
        ["củi","gỗ"],
        ["Bồn cầu","Thùng rác"],
        ["chipu","chi dân"],
        ["Xiaomi","vivo"],
        ["Cáibát","Cái chén"],
        ["canh cua rau","canh chua cá"],
        ["bịt mặt","khẩu trang"],
        ["thẻ căn cước","thẻ học sinh"],
        ["chipu","chi dân"],
        ["khoai tây","khoai lang"],
        ["Sữa tắm","Dầu massage"],
        ["Hồ","Biển"],
        ["Áo Dài","Áo Tấc"],
        ["bồn rửa mặt","Bồn rửa chén"],
        ["trái sầu riêng","trái kiwi"],
        ["hồng ngọc","pha lê"],
        ["Hoa Dã quỳ","Hoa Quỳnh"],
        ["trái sầu riêng","Hoa Quỳnh"],
        ["bánh tét","bánh chưng"],
        ["Đại bàng","Kền kền"],
        ["ghế lười","ghế sofa"],
        ["kẹo dẻo","kẹo ngậm"],
        ["chân mày","chân tóc"],
        ["Biden","Obama"],
        ["tuyết","đá"],
        ["cục tẩy","vở"],
        ["quả bở","quả táo"],
        ["Bột chiên xù","Bột mì"],
        ["Anh tú","Trường Giang"],
        ["ca sĩ Mỹ Linh","ca sĩ Mỹ Tâm"],
        ["mật mía","mật ong"],
        ["áo sơ mi","áo thun"],
        ["Quang Linh","Quang Hà"],
        ["Công chúa","Công chúa Ariel"],
        ["Girls' Generation","TWiCE"],
        ["cá 7 màu","cá koi"],
        ["rạp phim","công viên"],
        ["khoai môn","khoai sọ"],
        ["Gấu Đỏ","Hảo Hảo"],
        ["bún chả","bún bò"],
        ["Đô thứ","Đô trưởng"],
        ["Vương Hạc Đệ","Vương Tử kỳ"],
        ["quạt tích điện","quạt điện"],
        ["Kỵ binh","Bộ binh"],
        ["Mixue","TocoToco"],
        ["Toshiba","Sharp"],
        ["cây đào","cây thông"],
        ["chè sen","chè khúc bạch"],
        ["Tôn Ngộ Không","Lục Tiểu Linh"],
        ["phấn phủ","cushion"],
        ["Cặp tóc","Bờm tóc"],
        ["Shin cậu bé bút chì","Naruto"],
        ["bia hanoi","bia saigon"],
        ["Gạo","Cơm"],
        ["Datkaa","Hồ Phi Nal"],
        ["Đồng phục","Áo đôi"],
        ["hà mã","hải cẩu"],
        ["sấm","mưa"],
        ["pepsi","c2"],
        ["đồ lót","bikini"],
        ["tủ đồ","tủ giày"],
        ["di ngôn","di chúc"],
        ["mì tôm","bánh bao"],
        ["mikita","chupa chups"],
        ["táo","ổi"],
        ["quần ống loe","quần ống rộng"],
        ["dầu ô liu","dầu đậu nành"],
        ["trà tắc","trà sữa"],
        ["Vĩnh Dạ Tinh Hà","Rèm Ngọc Châu Sa"],
        ["cây tre","cây nêu"],
        ["bánh tráng nướng","bánh mì"],
        ["Rap Việt","The king of rap"],
        ["Tiếng Trung Quốc","Tiếng Quảng Đông"],
        ["Nabati","Danisa"],
        ["liễu như yên","bạch nguyệt quang"],
        ["trứng gà","trứng chim"],
        ["thùng","hộp"],
        ["Trường Giang","Xuân Bắc"],
        ["trái quýt","trái cam"],
        ["hồ bơi","ao nước"],
        ["Thước dẻo","Thước cứng"],
        ["cuộc đua kỳ thú","hành trình rực rỡ"],
        ["Lâm Vỹ Dạ","KhảNhư","Tiến Luật"],
        ["bánh bao","tiểu màn thầu"],
        ["Rhyder","Pháp Kiều"],
        ["muối tôm","muối ớt"],
        ["hoa sen","hoa súng"],
        
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(spacing: 32) {
                Text("WeSpy")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 8)
                    .padding(.top, 40)
                Text("Nhập từ khoá để đoán nhóm từ liên quan!")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                
                // Search field with suggestions
                VStack(spacing: 0) {
                    HStack {
                        TextField("Nhập từ khoá...", text: $keyword)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .focused($isTextFieldFocused)
                            .submitLabel(.done)
                            .onSubmit { guess() }
                            .onChange(of: keyword) { newValue in
                                updateSuggestions()
                            }
                        
                        Button(action: guess) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.purple)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        
                        Button(action: {
                            showingKeywordManagement = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.orange)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding(.horizontal)
                    .onChange(of: keywordManager.customKeywords) { _ in
                        updateSuggestions()
                    }
                    
                    // Suggestions dropdown
                    if showingSuggestions && !suggestions.isEmpty && !keyword.isEmpty {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(suggestions, id: \.self) { suggestion in
                                    Button(action: {
                                        keyword = suggestion
                                        showingSuggestions = false
                                        guess()
                                    }) {
                                        HStack {
                                            Text(suggestion)
                                                .foregroundColor(.black)
                                                .padding(.leading)
                                            Spacer()
                                        }
                                        .padding(.vertical, 12)
                                        .background(Color.white.opacity(0.95))
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    if suggestion != suggestions.last {
                                        Divider()
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .frame(maxHeight: 200)
                    }
                }
                if !result.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Kết quả:")
                            .font(.headline)
                            .foregroundColor(.white)
                        ForEach(result, id: \.self) { word in
                            Text(word)
                                .font(.title2)
                                .foregroundColor(.yellow)
                                .padding(.vertical, 2)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(16)
                    .shadow(radius: 6)
                } else if !keyword.isEmpty {
                    Text("Không tìm thấy nhóm từ khoá phù hợp.")
                        .foregroundColor(.white)
                        .padding(.top, 12)
                }
                Spacer()
                
                // Thông báo về tính chất miễn phí
                VStack(spacing: 12) {
                    Text("⚠️ IMPORTANT NOTICE")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.center)
                    
                    Text("Ứng dụng này hoàn toàn miễn phí và phi lợi nhuận,được phát triển với mục tiêu đóng góp tích cực cho cộng đồng.Nếu bạn phát hiện bất kỳ cá nhân hoặc tổ chức nào sử dụng ứng dụng với mục đích thương mại hoặc thu lợi nhuận,xin vui lòng thông báo trực tiếp cho nhà phát triển để kịp thời xử lý.")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.3))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                VStack(spacing: 8) {
                    Link(destination: URL(string: "https://facebook.com/thanhdark1909")!) {
                        Text("Developed by: ThanhDark1909 (Nguyen Thanh Dat)")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.8))
                            .underline()
                            .multilineTextAlignment(.center)
                    }
                    
                    Text("Thank to: Đì lie for helping collect keywords")
                        .font(.footnote)
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingKeywordManagement) {
            KeywordManagementView(keywordManager: keywordManager)
        }
        .onTapGesture {
            showingSuggestions = false
        }
    }
    
    func guess() {
        let lowerKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if let group = keywordGroups.first(where: { $0.map { $0.lowercased() }.contains(lowerKeyword) }) {
            result = group.filter { $0.lowercased() != lowerKeyword }
        } else if let custom = keywordManager.customKeywords.first(where: { $0.lowercased() == lowerKeyword }) {
            result = ["Đây là từ khoá tuỳ chỉnh bạn đã thêm!"]
        } else {
            result = []
        }
        showingSuggestions = false
        isTextFieldFocused = false
    }
    
    func updateSuggestions() {
        let searchText = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchText.count >= 1 {
            suggestions = keywordManager.getSuggestions(for: searchText)
            showingSuggestions = !suggestions.isEmpty
        } else {
            suggestions = []
            showingSuggestions = false
        }
    }
}
