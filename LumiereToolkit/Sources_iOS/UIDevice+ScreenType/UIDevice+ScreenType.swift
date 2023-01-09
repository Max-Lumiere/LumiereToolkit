
import UIKit

public extension UIDevice {

    enum ScreenType: String {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case unknown
    }

    var screenType: ScreenType {
        guard UIDevice.current.userInterfaceIdiom == .phone else { return .unknown }

        switch UIScreen.main.nativeBounds.height {
        case 960: return .iPhone4
        case 1136: return .iPhone5
        case 1334: return .iPhone6
        case 1920, 2208: return .iPhone6Plus
        case 2436: return .iPhoneX
        default: return .unknown
        }
    }

    var isSmallScreen: Bool { screenType == .iPhone4 || screenType == .iPhone5 }

    var isXFamily: Bool { !Set([ScreenType.iPhone6,
                                       ScreenType.iPhone6Plus,
                                       ScreenType.iPhone4,
                                       ScreenType.iPhone5]).contains(screenType) }

    func uiScreenSizeChose(_ small: CGFloat, _ normal: CGFloat) -> CGFloat {
        isSmallScreen ? small : normal
    }
}
