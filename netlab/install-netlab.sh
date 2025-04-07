sudo apt update && apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev \
liblzma-dev python3-openssl libssh-dev openvswitch-switch sshpass

cat << EOF >> ~/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"
EOF
source ~/.bashrc


# voir les versions
#pyenv install -l
pyenv install 3.11
pyenv virtualenv 3.11 netlab
pyenv activate netlab
pip install pip --upgrade
pip install ansible-pylibssh networklab[ALL] ansible
docker image pull registry.iutbeziers.fr/ceos:4.33.1F
bash -c "$(curl -sL https://get-gnmic.openconfig.net)"
