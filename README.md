# ParkWise - A Parking utility app for Skopje
ParkWise helps you stay up to date with the parking system in Skopje

## Features 
-  Gives you occupancy estimates based on user contributions
-  Allows you to contribute easily
-  Easy payment and tracking (uses SMS payments for you)
-  Parking end reminders (coming soon!)
-  ML predictions for availability based on many factors (coming soon!)


## Building and development

### Dev builds

To build dev, you must take care that you provide a **flavor**. You can do so by adding the following arguments either in the command line or your run configuration:
```--flavor FLAVOR --dart-define=app.flavor=FLAVOR``` 
> You should also provide the flavor in the Build Flavor field in Android Studio, if that's your IDE

The accepted flavors are :
- ```prod``` : Uses firebase and real data, also sends real SMS
- ```dev``` : Has Fake services for data and SMS

### Building an APK
```flutter build apk --flavor FLAVOR --dart-define=app.flavor=FLAVOR```


### Generating factories
It is required to generate the factories after changing one of the services annotated with @injectable, or adding a new one. 
You may do so with the command: 
```flutter pub run build_runner build --delete-conflicting-outputs```

### Generate app icons 
1. First you must place the icon in lib/icons/ and name it icon.png. So the resulting path to the icon is ```/lib/icons/icon.png```
2. Run the command: ```flutter pub run flutter_launcher_icons```

### Generate splash screens
The process is nearly identical to the icons
1. The same image as the icon is used (for now). The path needs to be ```/lib/icons/icon.png```
2. Run the command: ```flutter pub run flutter_native_splash:create```

