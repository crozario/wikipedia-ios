import Foundation
import UIKit
import WMF

class PreviewLicenseView: EmbeddableView, Themeable {
    @IBOutlet weak var licenseLoginLabel: UILabel!
    public weak var previewLicenseViewDelegate: PreviewLicenseViewDelegate?
    @IBOutlet private weak var topDividerHeight: NSLayoutConstraint!
    @IBOutlet private weak var bottomDividerHeight: NSLayoutConstraint!
    @IBOutlet private weak var licenseTitleLabel: UILabel!
    private var hideTopDivider = false
    private var hideBottomDivider = false
    public var theme: Theme = .standard

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        hideTopDivider = true
        hideBottomDivider = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        licenseTitleLabel.text = WMFLocalizedStringWithDefaultValue("wikitext-upload-save-terms-cc-by-sa-and-gfdl", nil, nil, "By publishing changes, you agree to the %1$@, and you irrevocably agree to release your contribution under the %2$@ License and the %3$@. You agree that a hyperlink or URL is sufficient attribution under the Creative Commons license.", "Button text for information about the Terms of Use and edit licenses. Parameters:\n* %1$@ - 'Terms of Use' link ([[Wikimedia:Wikipedia-ios-wikitext-upload-save-terms-name]])\n* %2$@ - license name link 1\n* %3$@ - license name link 2")
        
        styleLinks(licenseTitleLabel)
        licenseLoginLabel.text = CommonStrings.editAttribution
        underlineSign(in: licenseLoginLabel)
        
        bottomDividerHeight.constant = hideBottomDivider ? 0.0 : 1.0 / UIScreen.main.scale
        topDividerHeight.constant = hideTopDivider ? 0.0 : 1.0 / UIScreen.main.scale
    }
    
    private func styleLinks(_ label: UILabel?) {
        var baseAttributes: [NSAttributedString.Key : AnyObject]? = nil
        if let textColor = label?.textColor, let font = label?.font {
            baseAttributes = [
                .foregroundColor: textColor,
                .font: font
            ]
        }
        
        let linkAttributes = [
            NSAttributedString.Key.foregroundColor: theme.colors.link
        ]
        
        label?.attributedText = label?.text?.attributedString(attributes: baseAttributes, substitutionStrings: [
            Licenses.localizedSaveTermsTitle,
            Licenses.localizedCCBYSA3Title,
            Licenses.localizedGFDLTitle
        ], substitutionAttributes: [linkAttributes, linkAttributes, linkAttributes])
    }

    @IBAction private func termsLicenseLabelTapped(_ recognizer: UITapGestureRecognizer?) {
        previewLicenseViewDelegate?.previewLicenseViewTermsLicenseLabelWasTapped(self)
    }
    
    private func underlineSign(in label: UILabel?) {
        var baseAttributes: [NSAttributedString.Key : AnyObject]? = nil
        if let textColor = label?.textColor, let font = label?.font {
            baseAttributes = [
                .foregroundColor: textColor,
                .font: font
            ]
        }
        
        let substitutionAttributes: [NSAttributedString.Key : AnyObject] = [
            .underlineStyle: NSNumber(value: NSUnderlineStyle.single.rawValue),
            .foregroundColor: theme.colors.link
        ]
        
        label?.attributedText = label?.text?.attributedString(attributes: baseAttributes, substitutionStrings: [CommonStrings.editSignIn], substitutionAttributes: [substitutionAttributes])
    }

    public func apply(theme: Theme) {
        self.theme = theme
        backgroundColor = theme.colors.paperBackground
    }
}

protocol PreviewLicenseViewDelegate: NSObjectProtocol {
    func previewLicenseViewTermsLicenseLabelWasTapped(_ previewLicenseview: PreviewLicenseView?)
}
