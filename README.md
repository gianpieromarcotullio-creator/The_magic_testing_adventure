# 🚀 Galactica LDAP Test Environment

![Docker](https://img.shields.io/badge/Docker-Available-blue?logo=docker)
![LDAP](https://img.shields.io/badge/OpenLDAP-Test_Env-orange)

This repository contains a Dockerized OpenLDAP environment pre-populated with users and groups for **testing purposes**.
It is designed to be "plug-and-play": spin it up, and you immediately have a functional LDAP server with a realistic organizational structure (Galactica context).

## 📋 Prerequisites

* **Docker** installed on your machine.
* **Docker Compose** (included in Docker Desktop).

---

## ⚡ Quick Start

1.  **Clone this repository:**
    ```bash
    git clone <your-repo-url>
    cd <your-repo-folder>
    ```

2.  **Start the environment:**
    ```bash
    docker compose up -d --build
    ```

3.  **Access the services:**
    * **LDAP Server:** `localhost:389`
    * **Admin UI (phpLDAPadmin):** [https://localhost:6443](https://localhost:6443)
        * *Note: Accept the self-signed certificate warning in your browser.*

---

## 🔑 Connection Details

Use these parameters to connect your applications (e.g., Dataiku, Jenkins, Grafana) to this LDAP server.

| Parameter | Value | Notes |
| :--- | :--- | :--- |
| **Host** | `localhost` | Use `ldap-server` if inside the same Docker network |
| **Port** | `389` | Standard LDAP port |
| **Base DN** | `dc=galactica,dc=local` | Root of the directory |
| **Bind DN (Admin)** | `cn=admin,dc=galactica,dc=local` | User used to query the directory |
| **Bind Password** | `admin` | Default admin password |
| **User Search Base** | `ou=users,dc=galactica,dc=local` | Where users are located |
| **Group Search Base** | `ou=groups,dc=galactica,dc=local` | Where groups are located |
| **User Filter** | `(&(objectClass=inetOrgPerson)(uid={USERNAME}))` | Filter by `uid` attribute |

---

## 👥 Test Users & Credentials (Cheat Sheet)

The database is pre-loaded with the following users.
**Password Pattern:** The password is always `{username}_SecretPass!`

| Name | Username (`uid`) | Primary Group | Password |
| :--- | :--- | :--- | :--- |
| **Starbuck Thrace** | `starbuck_pilots` | `Pilots` | `starbuck_pilots_SecretPass!` |
| **Galen Tyrol** | `tyrol_engineers` | `Engineers` | `tyrol_engineers_SecretPass!` |
| **Lee Adama** | `adama_engineers` | `Engineers`, `Pilots`* | `adama_engineers_SecretPass!` |
| **Dr. Cottle** | `cottle_medics` | `Medics` | `cottle_medics_SecretPass!` |

> **Note:** `adama_engineers` belongs to **two groups** (`Engineers` and `Pilots`). Use this user to test multi-group permissions.

---

## 🛠 Project Structure

* `Dockerfile`: Defines the custom image based on `osixia/openldap`.
* `bootstrap.ldif`: Contains the definition of all Users and Groups. Modify this file to add permanent test data.
* `docker-compose.yml`: Orchestrates the LDAP server and the Web UI.

## 🛑 How to Stop & Reset

**To stop the containers (keep data):**
```bash
docker compose stop
```
To reset everything (delete data and start fresh): Use this command if you want to wipe changes and reload the bootstrap.ldif file from scratch.
```bash
docker compose down
```
