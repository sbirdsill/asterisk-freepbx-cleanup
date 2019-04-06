# Asterisk/FreePBX Removal and Cleanup
Quickly clean up Asterisk/FreePBX files on Ubuntu

When installing FreePBX and Asterisk, I noticed that the FreePBX installer has a lot of bugs and you may need to reinstall FreePBX a few times. The installer also didn't work well if you already have an installation of FreePBX (whether it's functional or not), so after lots of research, I wrote a quick bash script to automatically remove and cleanup any Asterisk and FreePBX installations whether it was installed from a package or from source along with any of its configuration files, install files, etc. so that I could completely start over. After running, the FreePBX installer should allow you to install without giving you errors. You may even need to restart your server after running it.

I didn't really design this script to work out of the box for anyone other than myself, so if you plan to use it, please look it over first before you run it. You will likely need to modify parts of it to fit your needs. However, it shouldn't destroy anything, so if you're feeling up to it, go ahead and run it out of the box and see what happens. 
