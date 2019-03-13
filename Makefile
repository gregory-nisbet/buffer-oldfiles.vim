faketarget:
	@echo "Cowardly refusing to do anything. Please read the Makefile."

# for testing purposes. This target copies the vim scripts in this repo into
# your ~/.vim directory.
# We check that the environment variable REALLY_CLOBBER has been set to "yes"
# to avoid nasty surprises.
clobber:
	test "$$REALLY_CLOBBER" "=" "yes"
	mkdir -p ~/.vim/plugin
	mkdir -p ~/.vim/autoload
	cp ./plugin/buffer_oldfiles.vim   ~/.vim/plugin/buffer_oldfiles.vim
	cp ./autoload/buffer_oldfiles.vim ~/.vim/autoload/buffer_oldfiles.vim

test:
	prove
