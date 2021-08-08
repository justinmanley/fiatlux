import os
import subprocess
import argparse
import sys
from typing import Iterable, Union, Dict


DOTFILES_DIR = os.path.abspath('./dotfiles')
HOME_DIR = os.path.expanduser('~')

def echo_run(command):
    print(command)
    return subprocess.run(command.split())

class Dependency:
    def install(self):
        pass

# For dependencies managed by the system package manager
class SystemDependency(Dependency):
    def __init__(self, dependency_name_by_os):
        if not dependency_name_by_os:
            raise ValueError("Dependencies must have a name on at least one operating system")

        if isinstance(dependency_name_by_os, str):
            self._name_by_os = {
                sys.platform: dependency_name_by_os
            }
        elif isinstance(dependency_name_by_os, dict):
            self._name_by_os = dependency_name_by_os
        else:
            raise TypeError()

        canonical_os = next(iter(self._name_by_os))
        self._canonical_name = self._name_by_os[canonical_os]
        
        self._install_commands = {
            "darwin": "brew install",
            "linux": "sudo apt-get install"
        }

    def install(self):
        if sys.platform not in self._install_commands:
            raise NotImplementedError(f"Installing system dependencies for {sys.platform} is not configured.")
        install = self._install_commands[sys.platform]
        
        if sys.platform not in self._name_by_os:
            raise ValueError(f"Dependency {self._canonical_name} has no install name on {sys.platform}")
        name = self._name_by_os[sys.platform]

        echo_run(f"{install} {name}")


class CustomSystemDependency(Dependency):
    def __init__(self, canonical_name, installation_commands_by_os):
        self._canonical_name = canonical_name
        self._install_commands = installation_commands_by_os

    def install(self):
        if sys.platform not in self._install_commands:
            raise ValueError(f"Dependency {self._canonical_name} has no install name on {sys.platform}")
        for command in self._install_commands[sys.platform]:
            echo_run(command)


class Homebrew(Dependency):
    # TODO: Implement
    pass


class Conda(Dependency):
    def __init__(self):
        conda_platforms = {
            "darwin": "MacOSX",
            "linux": "Linux",
        }
        if sys.platform not in conda_platforms:
            raise NotImplementedError(f"Installing conda for {sys.platform} is not configured.")
        conda_platform = conda_platforms[sys.platform]
        self._install_script_url = f"https://repo.anaconda.com/miniconda/Miniconda3-latest-{conda_platform}-x86_64.pkg"
        self._install_target = "/tmp/install_conda.sh"

    def install(self):
        if self._is_installed():  # check to see if conda is already installed
            print("Installing conda...")
            subprocess.run(f"curl {self._install_script_url} --output {self._install_target}")
            subprocess.run(self._install_target)

    def _is_installed(self):
        run_conda = subprocess.run(
            "conda",
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return run_conda.returncode != 0


class Mamba(Dependency):
    def install(self):
        echo_run("conda install mamba -n base -c conda-forge")


DEPENDENCIES: Iterable[Dependency] = [
    # Package managers
    Homebrew(),
    Conda(),
    Mamba(),

    SystemDependency('pass'),
    SystemDependency('pandoc'),
    SystemDependency('htop'),
    CustomSystemDependency("git-credential-manager", {
        "darwin": [
            "brew tap microsoft/git",
            "brew install --cask git-credential-manager-core",
        ],
    })
]


def link_dotfiles():
	home_files = os.listdir(HOME_DIR)

	for config_file in os.listdir(DOTFILES_DIR):
		if config_file not in home_files:
			print(f"Linking {config_file}")
			os.symlink(
				os.path.join(DOTFILES_DIR, config_file),
				os.path.join(HOME_DIR, config_file)
			)


def setup_git(email: str):
    user_info = subprocess.check_output(['finger', '$(whoami)'], shell=True, encoding='utf8').split()
    first_name, last_name = user_info[9:11]
    full_name = " ".join([first_name, last_name])

    echo_run(f"git config --global user.name {full_name}")
    echo_run(f"git config --global user.email {email}")
    echo_run(f"git config --global init.defaultBranch main")


def setup_pass():
    print("In order to set up 'pass', this script needs the appropriate credentials to be present.")
    print(
        """
        Specifically: (1) GPG keys used to encrypt passwords for 'pass' must be placed in ~/.gnupg.
                      (2) GPG-encrypted files containing passwords must be populated in ~/.password-store.
        """
    )

    def skip_pass_setup():
        continue_options = ["c", "continue"]
        skip_options = ["s", "skip"]

        selection = input("Would you like to continue, or skip and come back later? [c]ontinue or [s]kip: ")

        if selection not in continue_options + skip_options:
            return get_selection()

        return selection in skip_options 

    if skip_pass_setup():
        return

    # Set proper permissions on ~/.gnupg directory.
    for dirpath, dirnames, filenames in os.walk(os.path.expanduser("~/.gnupg")):
        for dirname in dirnames:
            os.chmod(os.path.join(dirpath, dirname), 0o700)
        for filename in filenames:
            os.chmod(os.path.join(dirpath, filename), 0o600)

    # So pass doesn't print '.gpg' at the end of every password filename.
    for dirpath, dirnames, filenames in os.walk(os.path.expanduser("~/.password-store")):
        for filename in filenames:
            os.chmod(os.path.join(dirpath, filename), 0o600)
    

def main():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--email', help='Email to associate with this user profile', required=True)
    args = parser.parse_args()

    # All commands should be idempotent
    link_dotfiles()
    setup_git(args.email)

    for dependency in DEPENDENCIES:
        dependency.install()

    setup_pass()
	

if __name__ == '__main__':
	main()
