import UIKit;

var standartUserDefaults = NSUserDefaults.standardUserDefaults()

var currentLocalStorageDict: NSMutableDictionary!

class LocalStorage {

    class func obtainData() {


    }
    // Setting a key to a localstorage
    class func set(key: String, object: AnyObject) {
        standartUserDefaults.setObject(object, forKey: key)
    }

    class func remove(key: String) {
        standartUserDefaults.removeObjectForKey(key)
    }

    class func getObject(key: String) -> AnyObject! {

        return standartUserDefaults.objectForKey(key)
    }

    // Getting a string
    class func getString(key: String) -> String! {
        var strResult: String!;
        var data = getObject(key)
        if data != nil {
            strResult = data as String;
        }
        return strResult
    }

    // Saving to file
    class func save() {
        obtainData();
        standartUserDefaults.synchronize()
    }

    class func saveDataToFileName(fileName: String, data: NSData) {
        var path = self.getPath(fileName)
        data.writeToFile(path, atomically: false)
    }

    class func getDataFromFileName(key: String) -> NSData! {
        var path = getPath(key);
        var data: NSData!;

        var checkValidation = NSFileManager.defaultManager()
        if (checkValidation.fileExistsAtPath(path)) {
            data = NSData(contentsOfFile: path)!
        }
        return data;
    }

    class func getDirectory() -> String {
        let dirs: [String]? = NSSearchPathForDirectoriesInDomains(
        NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        if let directories = dirs {
            return directories[0]
        }
        return "";
    }


    class func getPath(fileName: String) -> String {
        let bundle = NSBundle.mainBundle()
        //let path = bundle.pathForResource("localStorage", ofType: "json")
        let dir = self.getDirectory()
        let path = dir.stringByAppendingPathComponent(fileName);
        return path;
    }
}