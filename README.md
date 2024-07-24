# Laniakea Galaxy

Ansible role to install Galaxy 23.0 using roles developed by the Galaxy community.

## Requirements

Required roles:

- src: galaxyproject.galaxy
  version: 0.10.14
- src: galaxyproject.nginx
  version: 0.7.1
- src: galaxyproject.postgresql
  version: 1.1.2
- src: galaxyproject.postgresql_objects
  version: 1.2.0
- src: geerlingguy.pip
  version: 2.0.0
- src: galaxyproject.miniconda
  version: 0.3.1
- src: usegalaxy_eu.certbot
  version: 0.1.11
- src: galaxyproject.tusd
  version: 0.0.1
- src: galaxyproject.cvmfs
  version: 0.2.14

### Ansible-version

**tested with** : Ansible 4.10.0 with Ansible core 2.11.12

## Tasks
`main.yml` includes all necessary sub-roles

`pre_tasks.yml` calls OS-specific set of pre_tasks: for CentOS7 or RockyLinux9

## Variables
- Laniakea variables: `vars/main.yml`
- Default variables (Admin, paths): `defaults/mail.yml`
- Role-specific varibles are in the tasks files:
  - PostgeSQL: `tasks/postgresql_objects.yml`
  - NGINX: `tasks/nginx.yml`
  - Galaxy: `tasks/install_galaxy_role_vars.yml`
  - TUSD: `tasks/tusd.yml` and partially in `tasks/install_galaxy_role_vars.yml`

## Local Test Execution

```bash
# on a blank VM
# install requirements
sudo yum install -y git pip vim
pip install ansible==4.10.0 ansible-core==2.11.12
# clone repo
git clone <repo_path>
# copy test playbook
cp ansible-role-laniakea-galaxy/tests/test.yml test.yml
# update hostname and asnible user
vim inventory
ansible-galaxy install -r ansible-role-laniakea-galaxy/requirements.yml
cd ../
# run playbook
ansible-playbook -i ansible-role-laniakea-galaxy/inventory test.yml
```

Logs:
  - `<galaxy_install_path>/var/gravity/log/` (with the default paths `/home/galaxy/galaxy/var/gravity/log/`) - Gravity log files:
    - gunicorns
    - handlers
    - celery
    - tusd
    - interactive tools (if enabled)
  - ```sudo journalctl -u galaxy``` all Galaxy logs (come from supervisor, located at `/home/galaxy/galaxy/var/gravity/supervisor/supervisord.log`)


## Example Playbook

     ---

     - hosts: galaxyservers
       become: true
       vars:
         GALAXY_ADMIN_USERNAME: ""
         GALAXY_ADMIN_PASSWORD: ""
         GALAXY_ADMIN_API_KEY: ""
         GALAXY_ADMIN_EMAIL: ""
       roles:
         - ansible-role-laniakea-galaxy

## License

Apache Licence v2

http://www.apache.org/licenses/LICENSE-2.0

## Author Information

Pietro Mandreoli email: pietro.mandreoli@unimi.it
Polina Khmelevskaia: khmelevskayapv@gmail.com 
