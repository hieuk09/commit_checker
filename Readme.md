commit_checker
==============

Simple tool for adding best practices checker hooks to git

Install
==

You can install from console and install the hook.

```zsh
gem install commit_checker
rake hooks:install
```

After that, the hook will run rubocop to all the files changed in your commit.

Credit
==

This gem rely on [Rubocop](https://github.com/bbatsov/rubocop) as checker

Author: [Hieu Nguyen](hieu.nguyen@eastagile.com)
