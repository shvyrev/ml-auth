 #!/bin/bash

# Скрипт проверки развертывания Keycloak
set -e

echo "=== ПРОВЕРКА РАЗВЕРТЫВАНИЯ KEYCLOAK ==="

# Проверяем namespace
echo "1. Проверка namespace..."
kubectl get namespace infra

# Проверяем pods
echo -e "\n2. Проверка pods..."
kubectl get pods -n infra

# Проверяем services
echo -e "\n3. Проверка services..."
kubectl get services -n infra

# Проверяем ingress
echo -e "\n4. Проверка ingress..."
kubectl get ingress -n infra

# Проверяем PVC
echo -e "\n5. Проверка PersistentVolumeClaims..."
kubectl get pvc -n infra

# Проверяем logs PostgreSQL
echo -e "\n6. Логи PostgreSQL..."
POSTGRES_POD=$(kubectl get pods -n infra -l app=postgres -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || echo "")
if [ -n "$POSTGRES_POD" ]; then
    kubectl logs $POSTGRES_POD -n infra --tail=10
else
    echo "PostgreSQL pod не найден"
fi

# Проверяем logs Keycloak
echo -e "\n7. Логи Keycloak..."
KEYCLOAK_POD=$(kubectl get pods -n infra -l app=keycloak -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || echo "")
if [ -n "$KEYCLOAK_POD" ]; then
    kubectl logs $KEYCLOAK_POD -n infra --tail=10
else
    echo "Keycloak pod не найден"
fi

# Пробрасываем порт Keycloak
echo -e "\n8. Проброс порта Keycloak на localhost:8082..."
echo "Запустите в отдельном терминале:"
echo "kubectl port-forward -n infra svc/keycloak-service 8082:8080"
echo ""
echo "После проброса порта откройте в браузере:"
echo "Админка: http://localhost:8082/admin (admin/admin)"
echo "Тестовый пользователь: http://localhost:8082 (user/password)"
echo ""
echo "ДЛЯ ДОСТУПА ЧЕРЕЗ INGRESS:"
echo "Добавьте в /etc/hosts: 127.0.0.1 keycloak.local"
echo "Откройте: http://keycloak.local"

# Проверяем readiness probes
echo -e "\n9. Проверка readiness probes..."
kubectl describe pods -n infra | grep -A5 -B5 "Readiness"

echo -e "\n=== ПРОВЕРКА ЗАВЕРШЕНА ==="