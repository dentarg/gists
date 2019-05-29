# ansible testing

## Problem with `tags: never` and role with tags

Role is tagged with`localhost`, and when used, `never` isn't working:

```
$ ansible-playbook tags_test.yml --tags localhost

PLAY [localhost] *******************************************************************************************************************************************************************************************

TASK [debug] ***********************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "[tags_test.yml] task with always"
}

PLAY [localhost] *******************************************************************************************************************************************************************************************

TASK [tags_test : debug] ***********************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "[main.yml] task with no tags"
}

TASK [tags_test : debug] ***********************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "[main.yml] task with tag never and debug"
}

TASK [tags_test : debug] ***********************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "[included_tasks.yml] task with no tags"
}

TASK [tags_test : debug] ***********************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "[included_tasks.yml] task with tag never and debug"
}

PLAY RECAP *************************************************************************************************************************************************************************************************
localhost                  : ok=5    changed=0    unreachable=0    failed=0
```

```
$ ansible-playbook --version
ansible-playbook 2.7.9
  config file = /Users/dentarg/Dropbox/code/gists/gists/ansible/ansible.cfg
  configured module search path = [u'/Users/dentarg/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /Users/dentarg/Library/Python/2.7/lib/python/site-packages/ansible
  executable location = /Users/dentarg/Library/Python/2.7/bin/ansible-playbook
  python version = 2.7.16 (default, Mar  4 2019, 09:01:38) [GCC 4.2.1 Compatible Apple LLVM 10.0.0 (clang-1000.11.45.5)]
```
