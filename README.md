# .files

![i user arch btw](https://i.imgur.com/l9bHeq0.png)

# Setting default fonts
If you happen to install something like otf-ipafont or some other font that overrides your default font, the easiest way I found to fix that is to 
go to `/etc/fonts/conf.d` 
grep for the font you want to move down in priority (e.g. grep IPA \*)
In my case it was 65-nonlatin.conf that contained it.
I wanted to have 66-noto* to have priority over it
So i just `mv 65-nonlatin.conf 67-nonlatin.conf`
