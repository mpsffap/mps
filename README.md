# mps

My Perfect System (Ansible)

## Configuration

The contained tasks rely on a host configuration which itself refer to a user config.
These configurations shall reside in a ansible-vault in the "vars" directory.

A host config for the two hosts "hivehome" and "hivevm" might look like this:

```
---
config_hosts:
  hosts:
    hivehome:
      luks_part: "/dev/nvme0n1p4"
      luks_pass: "diskpass"
      install_lockdown: true
      users:
        - test_hive_root
        - test_hive_deploy
        - test_hive_foo
    hivevm:
      luks_part: "/dev/vda3"
      luks_pass: "diskpass"
      install_lockdown: true
      users:
        - test_hive_root
        - test_hive_deploy
        - test_hive_foo

```

A user config containing the four users "root", "foo", "deploy"
and "testuser" might look like this:

```
---
users:
  - name: test_hive_root
    accname: root
    password: "rootpass"
    comment: "root test user"
    shell: /bin/bash
    homedir: /root
    groups: ["docker"]
    keygen: true
    keygen_force: false
    config_terminal: false
    config_desktop: false
    config_develop: false
    config_gaming: false
    admin: false
    deployment: false
    state: "present"

  - name: test_hive_foo
    accname: foo
    password: "foopass"
    comment: "foo"
    shell: /bin/bash
    homedir: /home/foo
    groups: ["docker"]
    keygen: true
    keygen_force: false
    config_terminal: true
    config_desktop: true
    config_develop: true
    config_gaming: true
    admin: true
    deployment: false
    state: "present"

  - name: test_hive_deploy
    accname: deploy
    password: "deploypass"
    comment: "Test User"
    groups: ["docker"]
    shell: /bin/bash
    homedir: /home/deploy
    keypairs:
      - private: |
          -----BEGIN OPENSSH PRIVATE KEY-----
          YOUR PRIVKEY HERE
          -----END OPENSSH PRIVATE KEY-----
        public: YOUR PUBKEY HERE
        name: id_test
    keygen: false
    keygen_force: false
    config_terminal: false
    config_desktop: false
    config_develop: false
    config_gaming: false
    admin: false
    deployment: true
    state: "present"

  - name: test_hive_testuser
    accname: testuser
    password: "testuserpass"
    comment: "Test User"
    groups: ["docker"]
    shell: /bin/bash
    homedir: /home/testuser
    keygen: true
    keygen_force: true
    config_terminal: false
    config_desktop: false
    config_develop: false
    config_gaming: false
    admin: false
    deployment: false
    state: "present"

```

The actual build_type is configured in "inventory/group_vars/all/all.common.yml.
The default is "test".
The filenames must therefore adhere to the following name pattern:

```
# Config
vars/vault_config_prod.yml for a production host config
vars/vault_config_test.yml for a test host config

# Users
vars/vault_users_prod.yml for a production user config
vars/vault_users_test.yml for a test user config
```

A vault-pass-file is assumed to be located in the "vault" directory.
Vault files can be created and edited with the usual ansible-vault commands.

```
vault create --vault-pass-file vault/vault_pass.txt vault_config_prod.yml
vault edit --vault-pass-file vault/vault_pass.txt vault_config_prod.yml
```

## Examples

```
ansible-playbook playbooks/minimal.yml --vault-pass-file vault/vault_pass.txt
ansible-playbook playbooks/terminal.yml --vault-pass-file vault/vault_pass.txt
ansible-playbook playbooks/desktop.yml --vault-pass-file vault/vault_pass.txt
ansible-playbook playbooks/optimize.yml --vault-pass-file vault/vault_pass.txt
```
