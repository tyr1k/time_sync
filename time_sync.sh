#!/bin/bash

#Скрипт для автоматической синхронизации времени при разнице в 1 час

# Значения IP-адреса и имени пользователя удаленной машины
remote_host="172.29.100.2"
remote_user="mtrust"

# Функция для проверки разницы во времени
check_time_difference() {
    local remote_time=$(ssh $remote_user@$remote_host date +%s)
    local local_time=$(date +%s)
    local time_difference=$((remote_time - local_time))

    # Проверяем, превышает ли разница во времени 1 час (3600 секунд)
    if [ $time_difference -gt 3600 ]; then
        # Выставляем время на удаленной машине с помощью команды date
        ssh $remote_user@$remote_host date -s "$(date +"%Y-%m-%d %H:%M:%S")"
        echo "Время на удаленной машине было обновлено."
    else
        echo "Разница во времени между клиентской и удаленной машинами не превышает 1 час."
    fi
}

# Вызываем функцию для проверки времени
check_time_difference
