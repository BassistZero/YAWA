# Yet Another Weather App (YAWA)

## Installation
```
git clone https://github.com/BassistZero/YAWA.git
cd YAWA/YAWA
open YAWA.xcodeproj

Select your favorite simulator / device and `⌘ + R`
```

## Screenshots
<p float="left">
  <img src="https://github.com/BassistZero/YAWA/blob/master/Screenshots/cities_dark.png" width="20%" height="20%"/>
  <img src="https://github.com/BassistZero/YAWA/blob/master/Screenshots/current_light.png" width="20%" height="20%"/>
  <img src="https://github.com/BassistZero/YAWA/blob/master/Screenshots/modular_dark.png" width="20%" height="20%"/>  
</p>


## Development Details

- MVP Pattern (mostly 😰)
- `ModuleConfigurator` for DI
- Shared `ViewService` for views creation

## Features

- Dark-mode gradients support (in run-time, try it out 😎)
- No third-parties! (Swiftlint'd been used for "nit" commit)
- Cities cell's are so good to rest a thumb on 'em! 😜
- Smart usage of UserDefaults (saving cities' name only, no need of weather cache)

## Things to Improve

- Localization
- Advanced view-builders (OMG `ViewService` _singleton_ RLY??7?)
- Appropriate tab's naming...
- Me, myself and I on interviews: "`Presenter` **prepares** data to display". Also me: "`ViewController`'s supremacy, muah-ah-huh! Tasty SLOCs! Om-nom-nom!"
- Don't save user's input directly, they can do anything in here...
