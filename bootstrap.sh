#!/usr/bin/env bash
set -e

install_on_debian() {
    sudo apt-get update
    sudo apt-get install -y ansible git
}

install_on_arch() {
    sudo pacman -Syu --noconfirm --needed ansible git
}

install_on_fedora() {
    sudo dnf install -y ansible git
}

run_bootstrap() {
    echo ">>> Bootstrap: Start."
    sudo ansible-pull -U https://github.com/ozluuh/.bootstrap.git local.yml
    echo ">>> Bootstrap: Complete."
}

echo "=== First Boot ==="
if [ ! "$(command -v ansible)" ] || [ ! "$(command -v git)" ]; then
    OS="$(uname -s)"
    case "${OS}" in
        Linux*)
            _id="$(grep '^ID=' /etc/os-release)"
            echo ">>> Install: Ansible and Git"
            case "${_id:3}" in
                arch )
                    install_on_arch
                    ;;
                debian|ubuntu)
                    install_on_arch
                    ;;
                fedora)
                    install_on_fedora
                    ;;
                * )
                    echo "Unsupported Linux distribution: ${_id:3}"
                    exit 1
                    ;;
            esac
        ;;
        * )
            echo "Unsupported operating system: ${OS}"
            exit 1
            ;;
    esac
    echo ">>> Install: Complete."
fi

run_bootstrap
