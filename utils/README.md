 # *UTILS*

#  **__com1**
 
  --  this command populates list from commands in "\$PATH" and pritns to screen this list is also filtered through awk
  return just the command name
  
# **__coms**

  -- this command does the same as com1 without the awk filter
        the value returned is   command = /path/to/command
        
# **bli**

  --  this command brings up a menue to adjust the backlight at 100 / 75 / 50 percent and uses xfmp backlight helper
  
# **cmds**

  --  this is the same as __com1 but is a script instead of a function
  
# **coms**

  --  this takes the __coms function and pipes it into fzf with a preview of man {} which allows browsing of commands and viewing the manpages
  in preview window
  
# **estrip**

  --  this function strips color escapes from input/outout  '\E[ \[[033' etc very usefuflly if your coloring programs get piped to something that doesnt process
  the colors but outputs them to stdout
  
# **fzcom**

  --  previews a list of avaiable manpages and prieviews the manpage in window
  
# **rgd**

  --  this function uses ripgrep to search for directories
  
 #  **rgf**
 
  --  this function uses ripgrep to search for files
