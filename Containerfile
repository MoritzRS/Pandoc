FROM archlinux:latest

# Update System
RUN pacman -Syyu --noconfirm

# Install Texlive
RUN pacman -Syy --needed --noconfirm texlive texlive-lang biber 

# Install Pandoc 
RUN pacman -Syy --needed --noconfirm pandoc-cli pandoc-crossref

# Install Spell Checkers
RUN pacman -Syy --needed --noconfirm aspell aspell-en aspell-de

WORKDIR /data
CMD ["/bin/bash"]