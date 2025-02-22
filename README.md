# AWS Network Automation with Terraform & VyOS  
This project is curated by me, Hyder Shahzaib Ahmed to showcase my cloud networking and automation skills. It simulates a multi-office enterprise network, deploying a virtual infrastructure between branch locations while integrating network automation for scalability. By leveraging Terraform and Ansible, this solution enables seamless deployment of scalable cloud networks within minutes, replacing manual configurations with efficient automation.

## Problem  
Traditional network infrastructure is slow to deploy, requires manual configurations, and lacks scalability. Enterprises need automated, cloud-based networking that is scalable, secure, and efficient for hybrid cloud environments.  

## Solution  
This project automates AWS network provisioning using Terraform & Ansible, enabling:  
- Fully automated VPC deployment with subnets, IGW, and route tables  
- BGP-based network routing using VyOS  
- Scalable network automation for cloud-to-on-prem connectivity  

## Future Plans (Phases 4-6)  
- Phase 4: CI/CD pipeline for network automation (GitHub Actions)  
- Phase 5: Multi-region networking simulation (Enterprise Office Environment)  
- Phase 6: AWS CloudWatch monitoring for network traffic & BGP health  

---

## Project Breakdown (Phases 1-3)  

### Phase 1: AWS Network Infrastructure Deployment ✅
Automated AWS networking using Terraform, provisioning:  
- VPC for isolated cloud networking  
- Public & Private Subnets for traffic segmentation  
- Internet Gateway (IGW) for external access  
- Route Tables to control network flow  
- Transit Gateway (TGW) for future multi-VPC connectivity

---

### Phase 2: Deploy VyOS Router on AWS EC2 **(In Works)**  
Deploying VyOS on AWS EC2 to simulate an enterprise router:  
- BGP Peering between VyOS and AWS Transit Gateway  
- Dynamic Routing for hybrid cloud networking  
- Ansible Automation for configuration management  

---

### Phase 3: Network Automation with Ansible **(In Works)**  
Automating VyOS configurations with Ansible Playbooks:  
- BGP route automation  
- Firewall & VLAN management  
- Scalable deployments for future integrations  

---

## Future Roadmap (Phases 4-6)  
### Phase 4: CI/CD for Network Automation  
- Implement GitHub Actions for automated Terraform & Ansible deployments  
- Enable Infrastructure as Code (IaC) pipeline for seamless updates  

### Phase 5: Multi-Site Office Simulation  
- Deploy multiple VyOS routers across AWS regions  
- Simulate a corporate office network with multiple branch sites  

### Phase 6: AWS Cloud Monitoring & Logging  
- Enable AWS CloudWatch for BGP traffic monitoring  
- Set up alerts for route failures, latency spikes, and security issues
