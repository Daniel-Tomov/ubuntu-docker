#update
sudo apt update

#install zsh and any other stuff
sudo apt install curl git zsh autojump -y
curl -L git.io/antigen > antigen.zsh

# copy files to home directory
cp .zshrc /home/daniel
cp .p10k.zsh /home/daniel
