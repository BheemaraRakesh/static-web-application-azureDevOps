# Ansible Concepts

## Overview
Ansible is an open-source automation tool for configuration management, application deployment, and task automation. It uses SSH for communication and doesn't require agents on managed nodes.

## Key Concepts

### 1. Architecture

#### Control Node
Machine where Ansible is installed and playbooks are executed.

#### Managed Nodes
Target systems to be configured.

#### Inventory
List of managed nodes, organized in groups.

**Example inventory.ini:**
```ini
[webservers]
web1.example.com
web2.example.com

[dbservers]
db1.example.com

[all:vars]
ansible_user=ansible
ansible_ssh_private_key_file=/home/ansible/.ssh/id_rsa
```

### 2. Playbooks

#### Basic Structure
YAML files defining automation tasks.

**Example playbook.yml:**
```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present
    
    - name: Start Apache service
      service:
        name: apache2
        state: started
        enabled: yes
```

#### Plays
Individual configuration units within a playbook.

#### Tasks
Individual actions within a play.

### 3. Modules

#### Common Modules
- **package:** Install/remove packages
- **service:** Manage services
- **file:** Manage files and directories
- **copy:** Copy files to remote hosts
- **template:** Copy templates with variable substitution
- **command/shell:** Execute commands
- **git:** Manage git repositories

**Example:**
```yaml
- name: Install packages
  package:
    name: 
      - nginx
      - php
      - mysql-server
    state: present

- name: Create directory
  file:
    path: /var/www/html
    state: directory
    owner: www-data
    group: www-data
    mode: '0755'
```

### 4. Variables

#### Variable Sources
- Playbook vars
- Inventory vars
- Host vars
- Group vars
- Facts (gathered automatically)
- Registered variables

**Example:**
```yaml
---
- name: Configure application
  hosts: appservers
  vars:
    app_port: 8080
    db_host: db.example.com
  
  tasks:
    - name: Configure app
      template:
        src: app.conf.j2
        dest: /etc/app/app.conf
      vars:
        port: "{{ app_port }}"
        database: "{{ db_host }}"
```

### 5. Templates (Jinja2)

#### Template Files
Use .j2 extension, support Jinja2 syntax.

**Example app.conf.j2:**
```jinja2
# Application Configuration
app_port = {{ app_port }}
db_host = {{ db_host }}
environment = {{ env | default('production') }}

{% if ssl_enabled %}
ssl_certificate = /etc/ssl/certs/app.crt
ssl_key = /etc/ssl/private/app.key
{% endif %}

{% for server in app_servers %}
server {{ server }}
{% endfor %}
```

### 6. Roles

#### Role Structure
Organized way to group related tasks, variables, and files.

```
roles/
├── webserver/
│   ├── tasks/
│   │   └── main.yml
│   ├── handlers/
│   │   └── main.yml
│   ├── vars/
│   │   └── main.yml
│   ├── defaults/
│   │   └── main.yml
│   ├── files/
│   ├── templates/
│   └── meta/
│       └── main.yml
```

#### Using Roles
```yaml
---
- name: Configure web server
  hosts: webservers
  roles:
    - webserver
    - database
```

### 7. Handlers

#### Purpose
Execute tasks only when notified of changes.

**Example:**
```yaml
tasks:
  - name: Update nginx config
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    notify: Restart nginx

handlers:
  - name: Restart nginx
    service:
      name: nginx
      state: restarted
```

### 8. Conditionals and Loops

#### When Condition
Execute tasks based on conditions.

**Example:**
```yaml
- name: Install Apache on Ubuntu
  apt:
    name: apache2
    state: present
  when: ansible_distribution == "Ubuntu"

- name: Install httpd on CentOS
  yum:
    name: httpd
    state: present
  when: ansible_distribution == "CentOS"
```

#### Loops
Iterate over items.

**Example:**
```yaml
- name: Create users
  user:
    name: "{{ item.name }}"
    state: present
    groups: "{{ item.groups }}"
  loop:
    - { name: 'alice', groups: 'wheel' }
    - { name: 'bob', groups: 'users' }

- name: Install packages
  package:
    name: "{{ item }}"
    state: present
  loop:
    - nginx
    - php
    - mysql-server
```

### 9. Vault

#### Encrypting Sensitive Data
```bash
# Create encrypted file
ansible-vault create secrets.yml

# Edit encrypted file
ansible-vault edit secrets.yml

# Encrypt existing file
ansible-vault encrypt secrets.yml

# Decrypt file
ansible-vault decrypt secrets.yml
```

#### Using Vault in Playbooks
```bash
# Run playbook with vault password
ansible-playbook --ask-vault-pass playbook.yml

# Use vault password file
ansible-playbook --vault-password-file ~/.vault_pass playbook.yml
```

### 10. Ansible Tower/AWX

#### Features
- Web-based UI
- Role-based access control
- Job scheduling
- REST API
- Workflow orchestration

## Real Project Examples

### LAMP Stack Deployment
```yaml
---
- name: Deploy LAMP stack
  hosts: webservers
  become: yes
  vars:
    php_version: "7.4"
    mysql_root_password: "secure_password"
  
  tasks:
    - name: Update package cache
      apt:
        update_cache: yes
      when: ansible_distribution == "Ubuntu"
    
    - name: Install Apache
      apt:
        name: apache2
        state: present
    
    - name: Install PHP
      apt:
        name: 
          - php{{ php_version }}
          - php{{ php_version }}-mysql
          - php{{ php_version }}-cli
        state: present
    
    - name: Install MySQL
      apt:
        name: mysql-server
        state: present
    
    - name: Set MySQL root password
      mysql_user:
        name: root
        password: "{{ mysql_root_password }}"
        host: localhost
    
    - name: Create application directory
      file:
        path: /var/www/html/myapp
        state: directory
        owner: www-data
        group: www-data
        mode: '0755'
    
    - name: Deploy application files
      copy:
        src: ../files/app/
        dest: /var/www/html/myapp/
        owner: www-data
        group: www-data
    
    - name: Configure Apache virtual host
      template:
        src: templates/apache-vhost.conf.j2
        dest: /etc/apache2/sites-available/myapp.conf
      notify: Restart Apache
    
    - name: Enable site
      command: a2ensite myapp.conf
      notify: Restart Apache
    
    - name: Disable default site
      command: a2dissite 000-default.conf
      notify: Restart Apache
    
    - name: Start services
      service:
        name: "{{ item }}"
        state: started
        enabled: yes
      loop:
        - apache2
        - mysql
    
  handlers:
    - name: Restart Apache
      service:
        name: apache2
        state: restarted
```

### Multi-Tier Application Deployment
```yaml
---
- name: Configure load balancers
  hosts: loadbalancers
  roles:
    - nginx-lb

- name: Configure web servers
  hosts: webservers
  roles:
    - apache
    - php
    - wordpress

- name: Configure database servers
  hosts: dbservers
  roles:
    - mysql
    - mysql-replication

- name: Configure monitoring
  hosts: all
  roles:
    - monitoring-agent
```

### Infrastructure Provisioning with Ansible
```yaml
---
- name: Provision infrastructure
  hosts: localhost
  connection: local
  gather_facts: no
  
  tasks:
    - name: Create resource group
      azure_rm_resourcegroup:
        name: myapp-rg
        location: eastus
    
    - name: Create virtual network
      azure_rm_virtualnetwork:
        resource_group: myapp-rg
        name: myapp-vnet
        address_prefixes: "10.0.0.0/16"
    
    - name: Create subnet
      azure_rm_subnet:
        resource_group: myapp-rg
        name: myapp-subnet
        address_prefix: "10.0.1.0/24"
        virtual_network: myapp-vnet
    
    - name: Create VM
      azure_rm_virtualmachine:
        resource_group: myapp-rg
        name: webserver
        vm_size: Standard_DS1_v2
        virtual_network: myapp-vnet
        subnet_name: myapp-subnet
        admin_username: azureuser
        ssh_password_enabled: false
        ssh_public_keys:
          - path: /home/azureuser/.ssh/authorized_keys
            key_data: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
        image:
          offer: Ubuntu2204
          publisher: Canonical
          sku: 22_04-lts-gen2
          version: latest
```

## Best Practices
- Use roles for reusable components
- Implement proper error handling
- Use Ansible Vault for secrets
- Test playbooks with --check mode
- Use tags for selective execution
- Implement idempotent tasks
- Use dynamic inventories
- Document playbooks and roles
- Implement version control
- Use CI/CD for playbook testing