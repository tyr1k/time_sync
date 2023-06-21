#!/bin/bash

# Значения IP-адреса и имени пользователя удаленной машины
remote_host="ip_address"
remote_user="username"

# Функция для проверки разницы во времени
check_time_difference() {
    local remote_time=$(ssh $remote_user@$remote_host date +%s)
    local local_time=$(date +%s)
    local time_difference=$(echo $((remote_time - local_time)) | tr -d '-')

    echo $time_difference

    # Проверяем, превышает ли разница во времени 1 час (3600 секунд)
    if [ $time_difference -gt 3600 ]; then
        # Выставляем время на удаленной машине с помощью команды date
        ssh $remote_user@$remote_host "sudo date -s '$(date +"%Y-%m-%d %T")'"
        echo "Время на удаленной машине было обновлено."
    else
        echo "Разница во времени между клиентской и удаленной машинами не превышает 1 час."
    fi
}

# Вызываем функцию для проверки времени
check_time_difference
