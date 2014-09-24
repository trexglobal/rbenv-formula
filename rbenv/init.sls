rbenv:
  pkg.latest:
    - refresh: True

# Update list of available rubies before updating
'cd /usr/local/rbenv/plugins/ruby-build && git pull':
  cmd.run

rbenv-deps:
  pkg.installed:
    - pkgs:
      - bash
      - git
      - openssl
      - curl
      - make
      - gcc
      - libssl-dev
      - nodejs
      - libreadline-dev

ruby-2.1.0:
  rbenv.absent:
    - require:
      - pkg: rbenv-deps

ruby-2.1.2:
  rbenv.installed:
    - default: True
    - require:
      - pkg: rbenv-deps

app-deps:
  pkg.installed:
    - names:
      - libxml2-dev # required by nokogiri
      - libxslt1-dev # required by nokogiri
      - g++ # required by eventmachine
      - libmysqlclient-dev # required by mysql
      - libexpat1-dev # required by xmlparser

# Hack until we will get rbenv.do in upcomming saltstack version
'RBENV_ROOT=/usr/local/rbenv RBENV_VERSION=2.1.2 rbenv exec gem install bundler':
  cmd.run:
    - unless: 'RBENV_ROOT=/usr/local/rbenv RBENV_VERSION=2.1.2 rbenv exec gem list | grep bundler'


/etc/profile.d/rbenv.sh:
  file:
    - managed
    - user: root
    - group: root
    - mode: 755
    - source: salt://rbenv/files/profile/rbenv.sh
    - require:
      - pkg: rbenv
