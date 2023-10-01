
struct LanguageModel {
    var language: String
    var isSelected: Bool?
}

struct LanguageManager {
    private var data = [LanguageModel]()
    
    func getData () -> [LanguageModel] {
        return data
    }
    
    mutating func setData (language: String, isSelected: Bool) {
        data.append(LanguageModel(language: language, isSelected: isSelected))
    }
}
