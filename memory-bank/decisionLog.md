# Decision Log

This file records architectural and implementation decisions using a list format.
2025-09-21 08:25:42 - Log of updates made.

*

## Decision

* Инициализация Memory Bank для проекта

## Rationale

* Необходимость поддержания контекста проекта для всех режимов работы

## Implementation Details

* Создание структуры файлов memory-bank/
* Заполнение начальным контекстом на основе доступной информации
## Decision

* Отключение аутентификации клиента в Keycloak

## Rationale

* Требование пользователя отключить Client authentication
* Публичный клиент не требует секрета для аутентификации
* Упрощение конфигурации для демонстрационных целей

## Implementation Details

* Удален параметр "secret" из конфигурации клиента model-registry-app
* Клиент остается публичным (publicClient: true)
* Аутентификация теперь полностью отключена для клиента

[2025-09-21 12:16:42] - Отключение client authentication в Keycloak
## Decision

* Reorganization of Kubernetes templates and namespace change

## Rationale

* User request to move templates to k8s folder and change namespace to infra
* Better organization and naming convention for infrastructure components

## Implementation Details

* Created k8s/ directory for all Kubernetes manifests
* Moved all YAML files (01-namespace.yaml, 02-secrets.yaml, 03-postgresql.yaml, 04-keycloak.yaml, 05-ingress.yaml) to k8s/
* Changed namespace from keycloak-namespace to infra in all YAML files
* Updated deploy.sh and check-deployment.sh scripts to reference new paths and namespace

[2025-09-21 10:27:00] - Reorganization of Kubernetes templates and namespace change to infra