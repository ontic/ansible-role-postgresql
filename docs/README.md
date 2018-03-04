# Documentation

## Example

```
postgresql_version: '10'
postgresql_authentication:
  - { type: 'local', database: 'all', user: 'postgres', auth_method: 'peer' }
  - { type: 'local', database: 'all', user: 'all', auth_method: 'peer' }
  - { type: 'host', database: 'all', user: 'all', address: '127.0.0.1/32', auth_method: 'md5' }
  - { type: 'host', database: 'all', user: 'all', address: '::1/128', auth_method: 'md5' }
  - { type: 'host', database: 'all', user: 'all', address: '172.168.0.0/16', method: 'md5' }
postgresql_global_config:
  - { option: 'listen_addresses', value: '*' }
  - { option: 'max_connections', value: '150' }
postgresql_users:
  - name: 'web'
    password: 'md5{{ "password" + "web" | hash("md5") }}'
  - name: 'joe'
    password: 'md5{{ "password" + "joe" | hash("md5") }}'
postgresql_databases:
  - name: 'application'
postgresql_schemas:
  - name: 'staging'
    database: 'application'
postgresql_privileges:
  - database: 'application'
    type: 'schema'
    roles: 'web'
    privs: 'ALL'
    objs: 'public,staging'
  - database: 'application'
    type: 'schema'
    roles: 'joe'
    privs: 'ALL'
    objs: 'staging'
```

## Role Variables

Available variables are listed below, along with default values (see [defaults/main.yml](/defaults/main.yml)):

```
postgresql_version: '10'
```

The PostgreSQL package version you want to install.

```
postgresql_user: 'postgres'
```

The user under which PostgreSQL will run.

```
postgresql_group: '{{ postgresql_user }}'
```

The group under which PostgreSQL will run.

```
postgresql_service_name:
```

The name of the daemon under which PostgreSQL runs. Typically this can be omitted since it's automatically determined
based on the target operating system and version of PostgreSQL installed.

```
postgresql_service_state: 'started'
```

The desired PostgreSQL service state, valid values are `started`, `stopped`, `restarted` or `reloaded`.

```
postgresql_service_enabled: 'yes'
```

Whether the PostgreSQL service should start on boot, valid values are `yes`, or `no`.

```
postgresql_repo_state: 'present'
```

The desired PostgreSQL repository state, valid values are `present`, or `absent`.

```
postgresql_repo_uid: 'pgdg'
```

The unique repository identifier for RedHat/CentOS .

```
postgresql_repo_name: 'PostgreSQL'
```

The human readable repository name for RedHat/CentOS.

```
postgresql_repo_baseurl: 'https://download.postgresql.org/pub/repos/yum/{{ postgresql_version }}/redhat/rhel-$releasever-$basearch/'
```

The repository URL for RedHat/CentOS.

```
postgresql_repo_gpgkey: 'https://download.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG'
```

The GPG key URL for RedHat/CentOS.

```
postgresql_repo_gpgcheck: '1'
```

Whether GPG signature checking is enabled or disabled for RedHat/CentOS.

```
postgresql_repo_enabled: '1'
```

Whether the repository is enabled or disabled globally for RedHat/CentOS.

```
postgresql_repo_url: 'deb http://apt.postgresql.org/pub/repos/apt/ {{ ansible_distribution_release | lower }}-pgdg main'
```

The repository URL for Debian/Ubuntu.

```
postgresql_repo_key_id: 'ACCC4CF8'
```

The repository key identifier for Debian/Ubuntu.

```
postgresql_repo_key_url: 'https://www.postgresql.org/media/keys/ACCC4CF8.asc'
```

The URL to provide the GPG key for Debian/Ubuntu.

```
postgresql_bin_path:
```

The directory path PostgreSQL binary files are located. Typically this can be omitted since it's automatically determined
based on the target operating system and version of PostgreSQL installed.

```
postgresql_config_path:
```

The directory path PostgreSQL configuration files are located. Typically this can be omitted since it's automatically determined
based on the target operating system and version of PostgreSQL installed.

```
postgresql_data_path:
```

The directory path PostgreSQL data files are located. Typically this can be omitted since it's automatically determined
based on the target operating system and version of PostgreSQL installed.

```
postgresql_log_path:
```

The directory path PostgreSQL log files are located. Typically this can be omitted since it's automatically determined
based on the target operating system and version of PostgreSQL installed.

```
postgresql_runtime_path:
```

The directory path PostgreSQL runtime files are located. Typically this can be omitted since it's automatically determined
based on the target operating system and version of PostgreSQL installed.

```
postgresql_locales:
  - name: 'en_US.UTF-8'
```

A list of the locales to install for Debian/Ubuntu. Each locale supports all parameters from the
[locale](http://docs.ansible.com/ansible/latest/locale_gen_module.html) module.

```
postgresql_global_config:
```

An array of option hashes used to customise the global PostgreSQL configuration settings. Each option expects two
parameters, `option` the name of the option being added/updated/removed. Then finally `value`, a string value to be
associated with an option, this can also be omitted when removing an option.

```
postgresql_global_config_file_refresh: no
```

Whether to refresh the PostgreSQL configuration file by overriding it with the contents of `postgresql_global_config_template`.

```
postgresql_global_config_template: 'postgresql.conf.j2'
```

The name of the PostgreSQL configuration template. Typically you won't need to override this value since it's only used
as an initial replacement, for normalising settings across different operating systems.

```
postgresql_global_authentication_template: 'pg_hba.conf.j2'
```

The name of the PostgreSQL host based authentication template. Typically you won't need to override this value since
it's only used as an initial replacement, for normalising settings across different operating systems. Managing entries
can be achieved using the `postgresql_authentication` variable.

```
postgresql_packages:
```

A list of the PostgreSQL packages to install. Each package supports all parameters from the
[apt](http://docs.ansible.com/ansible/apt_module.html) or [yum](http://docs.ansible.com/ansible/yum_module.html) modules.
If the value remains omitted, the following packages will be installed by default.

| Debian/Ubuntu                               | RedHat/CentOS                              |
| :------------------------------------------ | :----------------------------------------- |
| postgresql-{{ postgresql_version }}         | postgresql{{ postgresql_version }}-server  |
| postgresql-client-{{ postgresql_version }}  | postgresql{{ postgresql_version }}         |
| postgresql-contrib-{{ postgresql_version }} | postgresql{{ postgresql_version }}-contrib |
| libpq-dev                                   | postgresql{{ postgresql_version }}-libs    |

```
postgresql_authentication:
```

A list of the PostgreSQL [host-based authentication](https://www.postgresql.org/docs/current/static/auth-pg-hba-conf.html) 
records to manage. Each record supports the following parameters:

| Name         | Required                             |
| :----------- | :----------------------------------- |
| type         | yes                                  |
| database     | yes                                  |
| user         | yes                                  |
| address      | yes when `ip_address` is not defined |
| ip_address   | yes when `address` is not defined    |
| ip_mask      | no                                   |
| auth_method  | no                                   |
| auth_options | no                                   |

```
postgresql_users:
```

A list of the PostgreSQL users to manage. Each user supports all parameters from the
[postgresql_user](http://docs.ansible.com/ansible/latest/postgresql_user_module.html) module.

```
postgresql_databases:
```

A list of the PostgreSQL databases to manage. Each database supports all parameters from the
[postgresql_db](http://docs.ansible.com/ansible/latest/postgresql_db_module.html) module.

```
postgresql_schemas:
```

A list of the PostgreSQL schemas to manage. Each schema supports all parameters from the
[postgresql_schema](http://docs.ansible.com/ansible/latest/postgresql_schema_module.html) module.

```
postgresql_privileges:
```

A list of the PostgreSQL privileges to manage. Each privilege supports all parameters from the
[postgresql_privs](http://docs.ansible.com/ansible/latest/postgresql_privs_module.html) module.