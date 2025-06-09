[[__TOC__]]

# подготовка ansible
Установить нужные коллекции (или через requirements.yaml)
`ansible-galaxy collection install community.vmware cloud.terraform ansible.posix community.general prometheus.prometheus geerlingguy.nginx --force`

# настройка хостов
скопировать .terraformrc в корень домашней папи пользователя
выполнить 
```
terraform init
terraform plan 
terraform apply
```

установить телеметрию:
```
cd ansible
ansible-playbook telemetry.yml -i terraform.yml --extra-vars=\"ansible_password='pZAIHz5k71LyUbTD'\" --extra-vars=\"ansible_become_password='pZAIHz5k71LyUbTD'
```

# установка nginx ролью 
```
cd ansible
ansible-playbook telemetry.yml -i nginx-method01.yml --extra-vars=\"ansible_password='pZAIHz5k71LyUbTD'\" --extra-vars=\"ansible_become_password='pZAIHz5k71LyUbTD'
```

# установка nginx сырым плейбуком 
```
cd ansible
ansible-playbook telemetry.yml -i nginx-method02.yml --extra-vars=\"ansible_password='pZAIHz5k71LyUbTD'\" --extra-vars=\"ansible_become_password='pZAIHz5k71LyUbTD'
```
