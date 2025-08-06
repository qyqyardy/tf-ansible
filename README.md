# High-Availability MariaDB Cluster with Monitoring & Backup

Proyek ini menyediakan solusi Infrastructure as Code (IaC) untuk mengimplementasikan klaster MariaDB Galera dengan ketersediaan tinggi di Google Cloud Platform (GCP). Selain itu, proyek ini juga mengonfigurasi stack monitoring (Prometheus + Grafana) dan solusi backup otomatis.

Menggunakan kombinasi Terraform untuk provisioning infrastruktur dan Ansible untuk konfigurasi server, proyek ini memungkinkan deployment yang cepat dan konsisten.

## Fitur Utama

* **High-Availability MariaDB Galera Cluster**: Klaster 3-node yang direplikasi secara sinkron untuk ketersediaan dan ketahanan data yang tinggi.
* **Monitoring Stack**: Implementasi Prometheus dan Grafana untuk memantau performa dan kesehatan klaster MariaDB secara real-time.
* **Automated Backup**: Solusi backup harian otomatis menggunakan Percona XtraBackup dan cronjob.

## Struktur Repositori
