import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let myChannnel = FlutterMethodChannel(
                            name: "app.id.com/my_channel_name",
                            binaryMessenger: controller.binaryMessenger)
      
          myChannnel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              
              if(call.method == "addnumbers"){
                  let c: Int = self.addNumber(call: call) // function is written separately
                  let finalResult: [String: Int] = ["Sum" : c]
                  result(finalResult)
              }else if(call.method == "getbatterylevel"){
                  self.receiveBatteryLevel(result: result)
              }else{
                  result(FlutterMethodNotImplemented)
              }
          })
      
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    
    func addNumber(call: FlutterMethodCall) -> Int {
        let args = call.arguments as? Dictionary<String, Any>
         let a = args?["n1"] as! Int
       let b = args?["n2"] as! Int
         print(a as Int)
         print(b as Int)
         let c = a + b
        return c;
    }

    
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
        UIDevice.current.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available.",
                            details: nil))
      } else {
          var batteryLevel: Float { device.batteryLevel }
        result(Int(batteryLevel * 100))
      }
    }
}
