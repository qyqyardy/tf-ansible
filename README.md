# High-Availability MariaDB Cluster with Monitoring & Backup

Proyek ini menyediakan solusi Infrastructure as Code (IaC) untuk mengimplementasikan klaster MariaDB Galera dengan ketersediaan tinggi di Google Cloud Platform (GCP). Selain itu, proyek ini juga mengonfigurasi stack monitoring (Prometheus + Grafana) dan solusi backup otomatis.

Menggunakan kombinasi Terraform untuk provisioning infrastruktur dan Ansible untuk konfigurasi server, proyek ini memungkinkan deployment yang cepat dan konsisten.

## Fitur Utama

* **High-Availability MariaDB Galera Cluster**: Klaster 3-node yang direplikasi secara sinkron untuk ketersediaan dan ketahanan data yang tinggi.
* **Monitoring Stack**: Implementasi Prometheus dan Grafana untuk memantau performa dan kesehatan klaster MariaDB secara real-time.
* **Automated Backup**: Solusi backup harian otomatis menggunakan Percona XtraBackup dan cronjob.

<pre> ## Struktur Repositori ``` TF-ANSIBLE/ ├── ansible/ │ ├── inventory.ini │ ├── playbooks/ │ │ ├── main.yml │ │ ├── monitoring.yml │ │ └── roles/ │ │ ├── backup/ │ │ │ ├── tasks/ │ │ │ └── templates/ │ │ ├── mariadb_cluster/ │ │ │ ├── tasks/ │ │ │ └── templates/ │ │ └── monitoring/ │ │ ├── tasks/ │ │ └── templates/ ├── infra/ │ └── gcp/ │ └── main.tf ``` </pre>

## Prasyarat

* [**Terraform**](https://www.terraform.io/downloads.html) terinstal di mesin lokal Anda.
* [**Ansible**](https://docs.ansible.com/ansible/latest/installation_guide/index.html) terinstal.
* [**Google Cloud SDK (gcloud CLI)**](https://cloud.google.com/sdk/docs/install) terinstal dan terautentikasi dengan akun GCP Anda.
* Sebuah `Project ID` GCP.
* Kunci SSH lokal (`id_rsa.pub`) yang sudah terdaftar di metadata SSH GCP atau akan didaftarkan oleh Terraform.

## Cara Penggunaan

### Langkah 1: Provisioning Infrastruktur dengan Terraform

1.  Masuk ke direktori Terraform:
    ```bash
    cd infra/gcp
    ```

2.  Inisialisasi Terraform:
    ```bash
    terraform init
    ```

3.  Tinjau rencana Terraform dan terapkan untuk membuat 4 instance VM di GCP. Ganti `your-gcp-project-id` dan `your-ssh-username` di `main.tf` terlebih dahulu.
    ```bash
    terraform apply -auto-approve
    ```
    Setelah selesai, Terraform akan menampilkan IP publik dari server yang telah dibuat.

### Langkah 2: Konfigurasi Server dengan Ansible

1.  Kembali ke direktori utama:
    ```bash
    cd ../..
    ```

2.  Salin IP publik dari output Terraform dan perbarui file `ansible/inventory.ini`. Pastikan `ansible_user` dan `ansible_ssh_private_key_file` juga sesuai dengan konfigurasi SSH Anda.

3.  Jalankan playbook utama Ansible untuk mengonfigurasi semua server:
    ```bash
    ansible-playbook -i ansible/inventory.ini ansible/playbooks/main.yml
    ```

Setelah playbook selesai, klaster MariaDB Anda akan berjalan, server monitoring akan aktif, dan backup harian akan dijadwalkan.

## Kustomisasi

* **`infra/gcp/main.tf`**: Ubah `project`, `region`, `machine_type`, dan `ssh-keys` sesuai kebutuhan Anda.
* **`ansible/inventory.ini`**: Sesuaikan IP server, `ansible_user`, dan `ansible_ssh_private_key_file`.
* **`ansible/roles/backup/templates/backup_script.sh.j2`**: Ganti `my_db_password` dengan sandi database yang aman.
* **`ansible/playbooks/main.yml`**: Ubah `galera_cluster_name` atau variabel lain jika diperlukan.
