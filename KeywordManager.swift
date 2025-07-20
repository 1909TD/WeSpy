import Foundation
import SwiftUI

class KeywordManager: ObservableObject {
    @Published var customKeywords: [String] = []
    @Published var suggestions: [String] = []
    
    private let userDefaults = UserDefaults.standard
    private let customKeywordsKey = "CustomKeywords"
    
    init() {
        loadCustomKeywords()
    }
    
    func addCustomKeyword(_ keyword: String) {
        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedKeyword.isEmpty && !customKeywords.contains(trimmedKeyword) {
            customKeywords.append(trimmedKeyword)
            saveCustomKeywords()
        }
    }
    
    func removeCustomKeyword(_ keyword: String) {
        customKeywords.removeAll { $0 == keyword }
        saveCustomKeywords()
    }
    
    func getSuggestions(for searchText: String) -> [String] {
        let lowerSearchText = searchText.lowercased()
        var allKeywords: [String] = []
        
        // Thêm từ khóa tùy chỉnh
        allKeywords.append(contentsOf: customKeywords)
        
        // Thêm từ khóa từ danh sách có sẵn
        let predefinedKeywords = KeywordManager.predefinedKeywords
        allKeywords.append(contentsOf: predefinedKeywords)
        
        // Lọc và sắp xếp gợi ý
        let filteredKeywords = allKeywords
            .filter { $0.lowercased().contains(lowerSearchText) }
            .filter { !$0.isEmpty }
            .sorted()
        
        return Array(Set(filteredKeywords)).prefix(10).map { $0 }
    }
    
    private func loadCustomKeywords() {
        if let savedKeywords = userDefaults.stringArray(forKey: customKeywordsKey) {
            customKeywords = savedKeywords
        }
    }
    
    private func saveCustomKeywords() {
        userDefaults.set(customKeywords, forKey: customKeywordsKey)
    }
    
    // Danh sách từ khóa có sẵn từ keywordGroups
    static let predefinedKeywords: [String] = [
        "phố đi bộ", "vỉa hè", "Quyển sách", "quyển từ điển", "quyển vở",
        "đà lạt", "gia lai", "con bọ cạp", "con tôm", "hạt tiêu", "ớt",
        "phú quốc", "phú quý", "trúc", "tre", "cao", "đi bộ", "chạy",
        "Ngôi mộ đom đóm", "thuỷ thủ mặt trăng", "xe hơi", "xe máy",
        "gạo nếp", "gạo lức", "gạo tẻ", "gạo thường", "hàm nghi", "tôn thất thuyết",
        "răng xứ", "răng khểnh", "thuốc lá", "xì gà", "thuốc lào", "Long An", "An Giang",
        "đấu trường ai cập", "brazil", "argentina", "Nguyễn Quan Hải", "Nguyễn Công Phượng",
        "con rắn", "con thạch sùng", "chạy tiếp sức", "chạy marathon", "Lan", "Ly",
        "Đũa", "nĩa", "cung kim ngưu", "cung sư tử", "bánh xèo", "bánh khọt",
        "mì tôm", "bún đậu", "xe container", "xe tải", "Lavie", "TH truewater", "Aquafina",
        "pizza", "hotdog", "hamburger", "hình chụp", "Tranh vẽ", "Bọ Cạp", "Bạch Dương",
        "đậu bắp", "đậu đũa", "cá rô", "cá nóc", "Kristen Stewart", "Emma Watson",
        "chim sơn ca", "chim gõ kiến", "nước lọc", "nước suối", "nước muối", "nước mắm",
        "nước cốt dừa", "nước đường", "nước ngọt", "con hến", "con sò", "triết lí", "triếc học",
        "Mỳ trộn", "Mỳ xào", "yomost", "milo", "cacao", "cà phê", "Hậu Hoàng", "Vanh Leg",
        "bút mực", "bút máy", "bút chì", "bút xoá", "bút bi", "bút lông", "Quan Hiểu Đồng", "Cúc Tịnh Y",
        "Đài phát thanh", "Máy nghe nhạc", "Android", "Iphone", "cờ caro", "áo caro",
        "con gấu trúc", "con gấu đỏ", "kẹo dẻo", "kẹo cao cu", "jack", "soobin hoàng sơn",
        "đấu trường Ai Cập", "Vường treo Babilon", "diều", "máy bay", "jung kook", "Jimin",
        "sạc diện thoại", "sạc dự phòng", "tỏ tình", "cầu hôn", "chữ cái", "chữ số",
        "Cá Ngựa", "Cá vàng", "thập kỉ", "thiên niên kỉ", "Gin Tuấn Kiệt", "Lê Dương Bảo Lâm",
        "Giáo Viên", "Học Sinh", "bình thạnh", "bình tân", "Midu", "Han Sara",
        "Sa Tăng", "Trư Bát Giới", "Khu du lịch", "Khu sinh thái", "Phương Mỹ Chi", "Hồ Ngọc Hà",
        "Kẹo gừng", "Kẹo lạc", "Chè hạt sen", "chè bưởi", "Phu nhân", "Tình Nhân",
        "Gà tre", "Gà ác", "Lò sưởi", "Điều hoà", "Con khỉ", "Con lười", "Con đười ươi",
        "Cây chuối", "Cây mít", "Bún", "Miến", "Aladdin", "alibaba", "muối hảo hảo", "muối ô mai",
        "chipu", "chi dân", "cây táo", "cây mít", "Hình học", "Đại số", "pháo", "boom",
        "ôtô bán tải", "ôtô tảo", "zalo", "facebook", "Wechat", "quạt hơi nước", "náy phun sương",
        "Nốt ruồi", "Vết bớt", "thịt bò", "thịt gà", "hoa hồng", "hoa huệ", "găng tay", "đôi tất",
        "Tôm Hùm", "Tôm Sông", "lắc chân", "vòng tay", "Người yêu củ", "Người yêu", "Con bò", "Con mèo",
        "củi", "gỗ", "Bồn cầu", "Thùng rác", "Xiaomi", "vivo", "Cáibát", "Cái chén",
        "canh cua rau", "canh chua cá", "bịt mặt", "khẩu trang", "thẻ căn cước", "thẻ học sinh",
        "khoai tây", "khoai lang", "Sữa tắm", "Dầu massage", "Hồ", "Biển", "Áo Dài", "Áo Tấc",
        "bồn rửa mặt", "Bồn rửa chén", "trái sầu riêng", "trái kiwi", "hồng ngọc", "pha lê",
        "Hoa Dã quỳ", "Hoa Quỳnh", "bánh tét", "bánh chưng", "Đại bàng", "Kền kền", "ghế lười", "ghế sofa",
        "kẹo dẻo", "kẹo ngậm", "chân mày", "chân tóc", "Biden", "Obama", "tuyết", "đá",
        "cục tẩy", "vở", "quả bở", "quả táo", "Bột chiên xù", "Bột mì", "Anh tú", "Trường Giang",
        "ca sĩ Mỹ Linh", "ca sĩ Mỹ Tâm", "mật mía", "mật ong", "áo sơ mi", "áo thun", "Quang Linh", "Quang Hà",
        "Công chúa", "Công chúa Ariel", "Girls' Generation", "TWiCE", "cá 7 màu", "cá koi",
        "rạp phim", "công viên", "khoai môn", "khoai sọ", "Gấu Đỏ", "Hảo Hảo", "bún chả", "bún bò",
        "Đô thứ", "Đô trưởng", "Vương Hạc Đệ", "Vương Tử kỳ", "quạt tích điện", "quạt điện",
        "Kỵ binh", "Bộ binh", "Mixue", "TocoToco", "Toshiba", "Sharp", "cây đào", "cây thông",
        "chè sen", "chè khúc bạch", "Tôn Ngộ Không", "Lục Tiểu Linh", "phấn phủ", "cushion",
        "Cặp tóc", "Bờm tóc", "Shin cậu bé bút chì", "Naruto", "bia hanoi", "bia saigon",
        "Gạo", "Cơm", "Datkaa", "Hồ Phi Nal", "Đồng phục", "Áo đôi", "hà mã", "hải cẩu",
        "sấm", "mưa", "pepsi", "c2", "đồ lót", "bikini", "tủ đồ", "tủ giày", "di ngôn", "di chúc",
        "mì tôm", "bánh bao", "mikita", "chupa chups", "táo", "ổi", "quần ống loe", "quần ống rộng",
        "dầu ô liu", "dầu đậu nành", "trà tắc", "trà sữa", "Vĩnh Dạ Tinh Hà", "Rèm Ngọc Châu Sa",
        "cây tre", "cây nêu", "bánh tráng nướng", "bánh mì", "Rap Việt", "The king of rap",
        "Tiếng Trung Quốc", "Tiếng Quảng Đông", "Nabati", "Danisa", "liễu như yên", "bạch nguyệt quang",
        "trứng gà", "trứng chim", "thùng", "hộp", "Trường Giang", "Xuân Bắc", "trái quýt", "trái cam",
        "hồ bơi", "ao nước", "Thước dẻo", "Thước cứng", "cuộc đua kỳ thú", "hành trình rực rỡ",
        "Lâm Vỹ Dạ", "KhảNhư", "bánh bao", "tiểu màn thầu", "Rhyder", "Pháp Kiều", "muối tôm", "muối ớt"
    ]
} 