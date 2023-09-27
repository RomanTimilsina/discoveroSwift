
struct LanguageModel {
    let language: String
    let isSelected: Bool?
}

//func createNewCountryModel(from country: CountryModel) -> NewCountryModel {
//    // Assuming your flag images are stored in the "Assets" directory
//    let flagImageName = country.code  // Use the country code as the image name
//    let flagImage = UIImage(named: flagImageName)
//
//    return NewCountryModel(name: country.name, dialCode: country.dialCode, code: country.code, flagImage: UIImage(named: country.code))
//}

struct LanguageManager {
    private var data = [LanguageModel]()
    
    init() {
        
    }
    
    func getData () -> [LanguageModel] {
        return data
    }
    
    mutating func setData (language: String, isSelected: Bool) {
        data.append(LanguageModel(language: language, isSelected: isSelected))
    }
}
