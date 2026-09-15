# Bootstrap

This repository sets up a new machine in two stages:

1. A bootstrap script that installs `git` and `Ansible`.
2. An Ansible playbook, executed via `ansible-pull`, that performs base machine configuration — installing [1Password](https://1password.com), the 1Password CLI, [chezmoi](https://www.chezmoi.io), and Flatpak.

## Supported systems

|                 | Bootstrap script | Ansible    |
|-----------------|------------------|------------|
| Debian / Ubuntu | ✅               | 🔜 planned |
| Arch Linux      | ✅               | ✅         |
| Fedora          | ✅               | 🔜 planned |
| macOS           | 🔜 planned       | 🔜 planned |

## Prerequisites

- Internet access
- 1Password desktop app installed and unlocked at least once (required for the SSH agent to work, once configured)

## Usage

Run the command below in your terminal and wait for it to finish:

```sh
curl -s -L https://raw.githubusercontent.com/ozluuh/.bootstrap/main/bootstrap.sh | bash
```

If `curl` isn't available, use `wget` instead:

```sh
wget -qO- https://raw.githubusercontent.com/ozluuh/.bootstrap/main/bootstrap.sh | bash
```

> ⚠️ This command downloads and executes a script directly from the internet. If you'd rather review it first, download the script separately:
>
> ```sh
> curl -s -L https://raw.githubusercontent.com/ozluuh/.bootstrap/main/bootstrap.sh -o bootstrap.sh
> # or: wget -q https://raw.githubusercontent.com/ozluuh/.bootstrap/main/bootstrap.sh -O bootstrap.sh
> cat bootstrap.sh   # review the contents
> bash bootstrap.sh
> ```

## What happens

1. The bootstrap script installs `git` and `Ansible`.
2. Ansible runs via `ansible-pull`, cloning this repository locally and applying the playbook directly — installing `1Password`, `1Password CLI`, `chezmoi`, and `Flatpak`.

## Troubleshooting

- **`op` not authenticated**: run `eval $(op signin)` manually, then run the script again.
- **`ansible-pull` fails to clone**: make sure `git` was installed correctly by the bootstrap script and that you have network access to the repository host.
