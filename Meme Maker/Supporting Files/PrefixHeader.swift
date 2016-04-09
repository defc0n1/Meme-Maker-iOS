//
//  PrefixHeader.swift
//  Meme Maker
//
//  Created by Avikant Saini on 4/4/16.
//  Copyright © 2016 avikantz. All rights reserved.
//

import Foundation
import UIKit

let API_BASE_URL: String = "http://alpha-meme-maker.herokuapp.com/"

func apiMemesPaging(page: Int) -> NSURL {
	return NSURL(string: "http://alpha-meme-maker.herokuapp.com/\(page)")!
}

func apiParticularMeme(memeID: Int) -> NSURL {
	return NSURL(string: "http://alpha-meme-maker.herokuapp.com/memes/\(memeID)")!
}

func apiSubmissionsPaging(page: Int) -> NSURL {
	return NSURL(string: "http://alpha-meme-maker.herokuapp.com/submissions/\(page)")!
}

func apiSubmissionsForMeme(memeID: Int) -> NSURL {
	return NSURL(string: "http://alpha-meme-maker.herokuapp.com/memes/\(memeID)/submissions")!
}

func getDocumentsDirectory() -> String {
	let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
	let documentsDirectory = paths[0]
	return documentsDirectory
}

func imagesPathForFileName(name: String) -> String {
	let directoryPath = getDocumentsDirectory().stringByAppendingString("/images/")
	let manager = NSFileManager.defaultManager()
	if (!manager.fileExistsAtPath(directoryPath)) {
		do {
			try manager.createDirectoryAtPath(directoryPath, withIntermediateDirectories: true, attributes: nil)
		} catch _ { }
	}
	return directoryPath.stringByAppendingString("\(name).jpg")
}

func userImagesPathForFileName(name: String) -> String {
	let directoryPath = getDocumentsDirectory().stringByAppendingString("/userImages/")
	let manager = NSFileManager.defaultManager()
	if (!manager.fileExistsAtPath(directoryPath)) {
		do {
			try manager.createDirectoryAtPath(directoryPath, withIntermediateDirectories: true, attributes: nil)
		} catch _ { }
	}
	return directoryPath.stringByAppendingString("\(name).jpg")
}

func documentsPathForFileName(name: String) -> String {
	let directoryPath = getDocumentsDirectory().stringByAppendingString("/resources/")
	let manager = NSFileManager.defaultManager()
	if (!manager.fileExistsAtPath(directoryPath)) {
		do {
			try manager.createDirectoryAtPath(directoryPath, withIntermediateDirectories: true, attributes: nil)
		} catch _ { }
	}
	return directoryPath.stringByAppendingString("\(name).dat")
}

func getCircularImage(image: UIImage) -> UIImage {
	let minwh = min(image.size.width, image.size.height)
	let centerRect = CGRectMake((image.size.width - minwh)/2, (image.size.height - minwh)/2, minwh, minwh)
	let imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
	UIGraphicsBeginImageContext(imageRect.size)
	let maskPath = UIBezierPath(ovalInRect: centerRect)
	maskPath.addClip()
	image.drawInRect(imageRect)
	let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return newImage
}

func getSquareImage(image: UIImage) -> UIImage {
	let minwh = min(image.size.width, image.size.height)
	let centerRect = CGRectMake((image.size.width - minwh)/2, (image.size.height - minwh)/2, minwh, minwh)
	let imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
	UIGraphicsBeginImageContext(imageRect.size)
	let maskPath = UIBezierPath(rect: centerRect)
	maskPath.addClip()
	image.drawInRect(imageRect)
	let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return newImage
}

func getImageByResizingImage(image: UIImage, ratio: CGFloat) -> UIImage {
	let imageRect = CGRectMake(0, 0, image.size.width * ratio, image.size.height * ratio)
	UIGraphicsBeginImageContext(CGSizeMake(image.size.width * ratio, image.size.height * ratio))
	image.drawInRect(imageRect)
	let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return newImage
}

func modalAlertControllerFor(title: String, message: String) -> UIAlertController {
	let alertC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
	let cancelA = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
	alertC.addAction(cancelA)
	return alertC
}

extension UIColor {
	var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
		getRed(&r, green: &g, blue: &b, alpha: &a)
		return (r,g,b,a)
	}
}

extension UIDevice {
	var modelName: String {
		var systemInfo = utsname()
		uname(&systemInfo)
		let machineMirror = Mirror(reflecting: systemInfo.machine)
		let identifier = machineMirror.children.reduce("") { identifier, element in
			guard let value = element.value as? Int8 where value != 0 else { return identifier }
			return identifier + String(UnicodeScalar(UInt8(value)))
		}
		switch identifier {
			case "iPod5,1":                                 return "iPod Touch 5"
			case "iPod7,1":                                 return "iPod Touch 6"
			case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
			case "iPhone4,1":                               return "iPhone 4s"
			case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
			case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
			case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
			case "iPhone7,2":                               return "iPhone 6"
			case "iPhone7,1":                               return "iPhone 6 Plus"
			case "iPhone8,1":                               return "iPhone 6s"
			case "iPhone8,2":                               return "iPhone 6s Plus"
			case "iPhone8,4":                               return "iPhone SE"
			case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
			case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
			case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
			case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
			case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
			case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
			case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
			case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
			case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
			case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
			case "AppleTV5,3":                              return "Apple TV"
			case "i386", "x86_64":                          return "Simulator"
			default:                                        return identifier
		}
	}
	
}