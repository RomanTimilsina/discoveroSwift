import UIKit

class testVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        findSubstring()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    func findSubstring() {
        let sampleString = "Hello, Swift Programming!"
        let searchSubstring = "Swift"

        // Find the range of the searchSubstring within the sampleString
        let range = (sampleString as NSString).range(of: searchSubstring)
        print(range)

        // Check if the searchSubstring was found
        if range.location != NSNotFound {
            let startIndex = range.location
            let endIndex = range.location + range.length
            let foundSubstring = (sampleString as NSString).substring(with: range)

            print("Search Substring: \(searchSubstring)")
            print("Found at Start Index: \(startIndex)")
            print("Found at End Index: \(endIndex)")
            
            // Create a regular (black) attributed string for the part before the found substring
            let regularAttributedString = NSMutableAttributedString(string: "Found Substring: ")
            regularAttributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: regularAttributedString.length))
            
            // Create a red attributed string for the found substring
            let redAttributedString = NSMutableAttributedString(string: foundSubstring)
            redAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: redAttributedString.length))
            
            // Apply bold font to the found substring
            redAttributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange(location: 0, length: redAttributedString.length))

            // Combine the regular and red attributed strings
            regularAttributedString.append(redAttributedString)

            // Create a UILabel to display the attributed string
            let label = UILabel()
            label.attributedText = regularAttributedString
            label.textAlignment = .center
            label.numberOfLines = 0 // Allow multiple lines if needed
            label.translatesAutoresizingMaskIntoConstraints = false

            // Add the label to the view
            view.addSubview(label)

            // Create constraints to position the label
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        } else {
            print("Search Substring not found in the sampleString.")
        }
    }
}
