# SSHA - Simple SSH Alias Manager

SSHA (Simple SSH Alias Manager) is a command-line tool designed to simplify the management of SSH aliases. Instead of typing out full server addresses each time you want to connect via SSH, SSHA allows you to use custom aliases for your most frequently accessed servers.

## Features

- **Alias Management:** Easily add, update, and remove SSH aliases.
- **Connection Simplification:** Connect to SSH servers using user-defined aliases.
- **Persistent Storage:** Aliases are stored locally for convenient access across sessions.

## Installation

To install SSHA, you can add the repository to your system and install it via apt:

```bash
sudo add-apt-repository ppa:hasarinduperera/ssha
sudo apt update
sudo apt install ssha
```

## Usage

After installation, you can use the `ssha` command to manage SSH aliases. Here are some examples of how to use it:


- **Add a New Alias:**

  ```bash
  ssha new <alias> <target>
  ```

- **Connect to a Server Using an Alias:**

  ```bash
  ssha con <alias>
  ```

- **Remove an Existing Alias:**

  ```bash
  ssha del <alias>
  ```

- **Show All Existing Aliases:**

  ```bash
  ssha show
  ```

## License

SSHA is licensed under the GNU General Public License (GPL) version 3.0. See the [LICENSE](LICENSE) file for details.

