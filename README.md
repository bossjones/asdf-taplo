# asdf-taplo

[taplo](https://github.com/tamasfe/taplo) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

## Install

Plugin:

```shell
asdf plugin add taplo
# or
asdf plugin add taplo https://github.com/your-username/asdf-taplo.git
```

taplo:

```shell
# Show all installable versions
asdf list-all taplo

# Install specific version
asdf install taplo latest

# Set a version globally (on your ~/.tool-versions file)
asdf global taplo latest

# Now taplo commands are available
taplo --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/your-username/asdf-taplo/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Your Name](https://github.com/your-username/)
