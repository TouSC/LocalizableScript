cp -R "../Analysis/Build/Products/Debug-iphoneos/Analysis.framework" "./"
cp -R "../AnimationKit/Build/Products/Debug-iphoneos/AnimationKit.framework" "./"
cp -R "../AsyncDataWork/Build/Products/Debug-iphoneos/AsyncDataWork.framework" "./"
cp -R "../CUIKit/Build/Products/Debug-iphoneos/CUIKit.framework" "./"
cp -R "../CocoaHardwareKit/Build/Products/Debug-iphoneos/CocoaHardwareKit.framework" "./"

lipo -create "../Analysis/Build/Products/Debug-iphoneos/Analysis.framework/Analysis" "../Analysis/Build/Products/Debug-iphonesimulator/Analysis.framework/Analysis" -output "./Analysis.framework/Analysis"
lipo -create "../AnimationKit/Build/Products/Debug-iphoneos/AnimationKit.framework/AnimationKit" "../AnimationKit/Build/Products/Debug-iphonesimulator/AnimationKit.framework/AnimationKit" -output "./AnimationKit.framework/AnimationKit"
lipo -create "../AsyncDataWork/Build/Products/Debug-iphoneos/AsyncDataWork.framework/AsyncDataWork" "../AsyncDataWork/Build/Products/Debug-iphonesimulator/AsyncDataWork.framework/AsyncDataWork" -output "./AsyncDataWork.framework/AsyncDataWork"
lipo -create "../CUIKit/Build/Products/Debug-iphoneos/CUIKit.framework/CUIKit" "../CUIKit/Build/Products/Debug-iphonesimulator/CUIKit.framework/CUIKit" -output "./CUIKit.framework/CUIKit"
lipo -create "../CocoaHardwareKit/Build/Products/Debug-iphoneos/CocoaHardwareKit.framework/CocoaHardwareKit" "../CocoaHardwareKit/Build/Products/Debug-iphonesimulator/CocoaHardwareKit.framework/CocoaHardwareKit" -output "./CocoaHardwareKit.framework/CocoaHardwareKit"

cp -R "./Analysis.framework" "../Ones/Ones/Frameworks/"
cp -R "./AnimationKit.framework" "../Ones/Ones/Frameworks/"
cp -R "./AsyncDataWork.framework" "../Ones/Ones/Frameworks/"
cp -R "./CUIKit.framework" "../Ones/Ones/Frameworks/"
cp -R "./CocoaHardwareKit.framework" "../Ones/Ones/Frameworks/"

echo "done"
