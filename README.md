# Lab 1: Terraform + GCP

## Beskrivning
Detta projekt skapar en Linux VM i GCP med Terraform. Miljön är härdad enligt 90% CIS Benchmark och infrastrukturkoden skannas för sårbarheter i CI-pipelinen via Trivy. Pipelinen är konfigurerad att avbryta om kritiska sårbarheter upptäcks.

## Hur man kör koden
1. Konfigurera lokala variabler i `terraform.tfvars`.
2. Kör `terraform init` för att koppla upp mot Remote State (GCS).
3. Kör `terraform plan` för att granska ändringarna.
4. Kör `terraform apply` för att bygga infrastrukturen.

## Säkerhetsbeslut
- **UFW & Fail2ban:** Blockerar obehörig trafik.
- **CIS Benchmark Hardening:** Inaktiverar osäkra filsystem, säkrar sysctl-nätverksparametrar, hårdkonfigurerar SSH och aktiverar `auditd`.
- **Remote State:** State-filen sparas säkert i GCP Cloud Storage, ej lokalt.
- **Policy-as-Code:** Trivy skannar koden och blockerar vid CRITICAL/HIGH.

## Disaster Recovery (DR)
- **RPO (Recovery Point Objective):** 24 timmar. Backups körs via en snapshot-policy kl 03:00 varje natt.
- **RTO (Recovery Time Objective):** < 15 minuter. Servern återskapas via Terraform, varpå snapshot monteras.

## Screenshots
### 1. Pipeline
<img width="706" height="301" alt="image" src="https://github.com/user-attachments/assets/e70849f4-ea9c-4b1e-95a8-f8e9912f69ff" />
### 2. Virtuell Maskin (e2-micro)
<img width="1300" height="55" alt="image" src="https://github.com/user-attachments/assets/99d971c5-cadc-4b50-b066-5d2b840575fe" />
### 3. Backup Policy (Snapshot)
<img width="1255" height="195" alt="image" src="https://github.com/user-attachments/assets/4dc9a8c3-7ba0-4b4e-9b56-99ba5c9a0165" />




