# DigioChallenge

## How to Run the Project

To run the project, follow the steps below:

### 1. Install Project Dependencies

Make sure you have Bundler, CocoaPods, and XcodeGen installed. If not, install them using the following commands:

- **Install Bundler:**
    ```bash
    gem install bundler
    ```
- **Install CocoaPods:**
    ```bash
    sudo gem install cocoapods
    ```
- **Install XcodeGen:**
    ```bash
    brew install xcodegen
    ```

### 2. Set Up the Project

Run the following command at the root of the project to install dependencies and generate the project with XcodeGen:

```bash
make setup
```

The **make setup** command will execute the following steps:

- **Install necessary gems:**
```bash
bundle install
``` 
- **Install CocoaPods dependencies:**
```bash
pod install
``` 
- **Generate the project with XcodeGen:**
```bash
xcodegen generate
``` 

###  3. Open the Project
After running **make setup**, open the project using the DigioChallenge.xcworkspace file to start development.

### SwiftLint
SwiftLint is configured to run automatically during the build time, but you can also run it manually via the terminal. To run SwiftLint manually, use the command:

```bash
swiftlint
```
This command should be executed at the root of the project.
