#!/binsh

name="Ones"

#cd /Users/tousan/Desktop/Ones/Frameworks
#sh framework_builder_release.sh

cd /Users/tousan/.jenkins/workspace/${name}
#cd /Users/tousan/Desktop/Ones/Ones

plistPath="${name}/Info.plist"
buddy="/usr/libexec/PlistBuddy"

version=$(${buddy} -c "Print:CFBundleShortVersionString" "${plistPath}")
build=$(${buddy} -c "Print:CFBundleVersion" "${plistPath}")

if [ "$Env"x = "x" ]; then
    Env="APPStore"
fi

echo ${version}_${build}版本的${name}发布到在${Env}

now=`date -u -v "+8H" +"%y%m%d%H%M%S"`
targetDir="/Users/tousan/Documents/自动打包/${now}"
archivePath="${targetDir}/${name}_${version}_${build}.xcarchive"
ipaPath="${targetDir}"

if [ ! -d ${targetDir} ]; then
    mkdir -p ${targetDir}
fi

xcodebuild archive -workspace "./${name}.xcworkspace" -scheme ${name} -configuration "ReleaseWithEnvironment" -archivePath ${archivePath}
if [ $? -eq 0 ]; then
    echo "打包成功"

    dSYMsPath="${archivePath}/dSYMs/${name}.app.dSYM"

    cp -r "${dSYMsPath}" "${targetDir}/${name}_${version}_${build}.app.dSYM"

    if [ "$Env"x = "APPStore"x ]; then
        xcodebuild -exportArchive -archivePath ${archivePath} -exportPath ${ipaPath} -exportOptionsPlist /Users/tousan/Desktop/${name}/Frameworks/plist/APPStoreExportOptions.plist -allowProvisioningUpdates
        if [ $? -eq 0 ]; then
            echo "导出成功"
            fastlane deliver --ipa "${ipaPath}/${name}.ipa" --force
        else
            echo "导出失败"
        fi
    elif [ "$Env"x = "FIR"x ]; then
        xcodebuild -exportArchive -archivePath ${archivePath} -exportPath ${ipaPath} -exportOptionsPlist /Users/tousan/Desktop/${name}/Frameworks/plist/FIRExportOptions.plist -allowProvisioningUpdates
        if [ $? -eq 0 ]; then
            echo "导出成功"
        else
            echo "导出失败"
        fi
    else
        xcodebuild -exportArchive -archivePath ${archivePath} -exportPath ${ipaPath} -exportOptionsPlist /Users/tousan/Desktop/${name}/Frameworks/plist/LocalExportOptions.plist -allowProvisioningUpdates
        if [ $? -eq 0 ]; then
            echo "导出成功"
        else
            echo "导出失败"
        fi
    fi
else
    echo "打包失败"
fi
