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

### Observations
- **Updated README:** Includes detailed instructions on how to set up the project, run the make setup command, and open the project in Xcode.
- **Use of make setup:** Clearly explains that all project files and configurations will be automatically generated when the make setup command is executed.
- **Prevents Inclusion in Git:** Reinforces that the repository does not contain Xcode configuration files or dependency directories, and that these are generated at runtime.

### To Do
- Create UI tests
