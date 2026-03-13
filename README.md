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
*(Lägg in dina bilder här nedanför)*
