.PHONY: setup
setup:
	./script/setup.sh
generate-screen:
	ruby ./templates/generate-viper.rb
	./script/setup.sh
