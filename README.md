rbenv-formula
=============

Installing ruby with rbenv

## Install

1. Add remotes to /etc/salt/master

  ```yaml
  gitfs_remotes:
    - git://github.com/trexglobal/rbenv-formula
  ```
2. Add basic to your server [state file](http://docs.saltstack.com/en/latest/topics/tutorials/starting_states.html)

  ```yaml
  include:
      - rbenv
  ```

  or to the [top.sls](http://docs.saltstack.com/en/latest/ref/states/top.html) file
  

  ```yaml
  base:
    'some.server.example.com':
      - rbenv
  ```

