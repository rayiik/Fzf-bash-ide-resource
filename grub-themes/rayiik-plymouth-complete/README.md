# Animated Boot Screen Shell Script

This is a template built off of Eonix's animated cat plymouth theme. I just wrote some scripts to make it easier to make your own.


## Instructions

1. Install Plymouth themes:

`sudo apt install plymouth-themes`

2. Go to the plymouth themes folder

`
cd /usr/share/plymouth/themes
`

3. Create new theme folder

`
sudo mkdir ./{{ThemeNameHere}}
`

4. Move into your new theme folder.

`
cd {{ThemeNameHere}}
`

3. Clone this repo contents into the folder.

`
sudo git clone https://github.com/thedonquixotic/plymouth-animated-boot-screen-creator.git .
`
the dot at the end will clone the contents of the template folder into your new theme folder.

### customization

1. put mp4 or gif into the "input" folder.
2. run the correct .sh file for the file type you are using.
3. transfer the image sequence to the root of the project folder.
4. open up template.script and change the lines:
```
for (i = 0; i < {{number of images in sequence}}; i++)
  flyingman_image[i] = image("progress-" + i + ".png");
flyingman_sprite = sprite();
```
and
```
flyingman_sprite.setimage(flyingman_image[math.int(progress / 3) % {{number of images}}]);
```
to have the correct number of images in the sequence.

5. resave the template.script file as "animated-boot.script".
6. open up template.plymouth and enter in your name, descriptions, and new script paths etc and save as {{themenamehere}}.plymouth

### installation
1. Install the theme using this script, be sure to replace the template variables used:

```
 sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/{{ThemeName}}/{{ThemeName}}.plymouth 100
```
In my case it looks like this:
```
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/slash/slash.plymouth 100
```

2. Select the default theme.
`sudo update-alternatives --config default.plymouth`
And select the number for your theme (I can't say this for sure but if the theme you want is under 0 for the auto mode, then I would select that as I think it boots in faster than manual)

3. Update the initramfs image.

`
sudo update-initramfs -u
`

4. Now reboot.

If you want to install this on < Ubuntu 16.04, change the path from /usr/share/plymouth to /lib/plymouth/ . You need to do this on the eionix-cat.plymouth file also.

Also other possible perks:

I found some scripts that are supposed to improve the transitions etc between Plymouth and the other parts of the start up process. I don't know if they worked for me or not. I had trouble getting the plymouth-gdm thing working as it seems that it's primarily something to do with pre-gdm3 versions and I'm on Ubuntu 18.04

Anyway:

- Edit the file /etc/initramfs-tools/conf.d/splash and add this line:

`
FRAMEBUFFER=y
`

- To enable smooth transition you have to disable your display manager unit, e.g.

`
systemctl disable gdm.service
`

- Enable the respective DM-plymouth Unit (GDM, LXDM, SLiM units provided), e.g.

`
systemctl enable gdm-plymouth.service
`




### Credits
Original repo by Eionix: https://github.com/krishnan793/PlymouthTheme-Cat/commits?author=krishnan793

[![Video](https://4.bp.blogspot.com/-gG0MBGjEE9M/WBYXrOGrVGI/AAAAAAAABVE/auGpLRYf7jor4hu3jurYGcjaVBapHyAVACLcB/s320/8998adc40112985a8f29cf414925d390.gif)](https://www.youtube.com/watch?v=c6f478VBhtE)


[Video] https://www.youtube.com/watch?v=c6f478VBhtE

[Blog] http://eionix.blogspot.in/2016/10/plymouth-theme-for-ubuntu.html

And if you want to check out my blog for more creative coding and unix customization stuff, check out https://www.jackalope.tech/blog
