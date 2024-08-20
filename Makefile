.PHONY: setup clean

setup: 
	@echo "Removing old project files..."
	@rm -rf DigioChallenge.xcodeproj  # Remove o projeto Xcode existente
	@rm -f Podfile.lock  # Remove o arquivo Podfile.lock
	@echo "Installing gems..."
	@bundle install  # Instala as dependências Ruby (incluindo o Bundler)
	@echo "Generating Xcode project with XcodeGen..."
	@xcodegen generate  # Gera o projeto Xcode com XcodeGen
	@echo "Deintegrating Pods..."
	@pod deintegrate  # Remove a integração atual dos Pods
	@echo "Installing Pods..."
	@pod install  # Instala os Pods
	@echo "Setup complete."
	
clean:
	@echo "Cleaning up..."
	@rm -rf DigioChallenge.xcworkspace
	@rm -rf Pods
	@rm -rf ~/Library/Developer/Xcode/DerivedData
	@rm -rf DigioChallenge.xcodeproj
