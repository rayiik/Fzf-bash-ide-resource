#  Man-fzf-scripts
A collection of scripts custom scripts I have made and others have mande that revolove around the
use of fzf to find and search manpages interactivly with many other useful scritps as well. I have 
only been programming a couple of months so some of these may not be the most efficent way to do things
feel free to shoot me a message at dsimon_aas@hotmail.com and i will try to fix/update/learn what i can.
The only programming language i currently know is bash so these scripts will be maintained and updated 
primarly in bash.

## Requirements: 
**-nvimpager** (allows you to use neovim as either a pager or a cat 
nvimpager folder goes in ~/.config/nvimpager and i recommend you not source your .vimrc 
as it is wonky but you can keep a seperate init.vim like ive provided i set PAGER && MANPAGER 
to nvimpager the nicest feature is that it allows you to follow tags split window open terminal
yank sections of text from man pages all while in a submenu of fzf)

**-Bash**

**-moreman** (Python program that replaces the man command, if man page exists use man page else creat manpage from --help flag)

**-rip grep** (Because its better than grep there are many articles about why and what you can do with it but its necessary to some 
of the scripts here)

**-fd** (Rust replacement for most of find features[https://github.com/sharkdp/fd])
Some of these scripts are incomplete & some of these scripts are experiemental (ive done my best of cleaning up my project folder 
but as this is my first one i may have missed some stuff) so please have a quick once over before use

**-fzf** 

**-colorizer**
Colors the out put deliminated by coloumn not necessary but its there and may need to be removed if you dont want it)

### Side notes
   I posted these before being able to fully clean up becuase i wanted people to have access to the man page utilities much much 
earliery but ive been fussing with polishing ad implamenting new things as i learned bash scripting. this project for me was so 
   I could learn and put into practice that learning. realistically the man pages have been ready to go for a while and work both 
in tui and gui
   I have made demos for a few of the major commands that are done/inprogress and i hope their use can be helpfull some of the items 
still have workd to do but i wanted to get the man commands out as soon as possible for whoever they might benifit
    
   Also if you inprove one of my scritps id love to know so i can update here and make changes.
heres a few demos in action but will update soon

[![asciicast](https://asciinema.org/a/koNsn3tulFkKoMZOljC2SawmK.svg)](https://asciinema.org/a/koNsn3tulFkKoMZOljC2SawmK)



[![asciicast](https://asciinema.org/a/Nwc6f8BtbhSK5sQtfIYmPEDuU.svg)](https://asciinema.org/a/Nwc6f8BtbhSK5sQtfIYmPEDuU)



[![asciicast](https://asciinema.org/a/jkWUP3P8JXa5h36AK3aAGyxKo.svg)](https://asciinema.org/a/jkWUP3P8JXa5h36AK3aAGyxKo)

