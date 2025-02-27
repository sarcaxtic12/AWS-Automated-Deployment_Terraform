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

### Phase 2: Deploy VyOS Router on AWS EC2 ✅
This phase establishes a virtual router setup with VyOS to manage and route traffic between public and private subnets:
- VyOS Deployment:
  - VyOS is launched in a public subnet (10.0.1.0/24) with a public interface (eth0).
  - A second network interface (eth1) is attached in a private subnet (10.0.2.0/24) and configured with a static IP (10.0.2.1).
- NAT Configuration:
  - A Source NAT (masquerade) rule is configured on VyOS so that traffic from the private subnet (10.0.2.0/24) is translated as it exits via the public interface (eth0) to the internet.
- AWS Route Table Update:
  - The private subnet’s route table is updated (using a NAT instance approach) so that outbound traffic (0.0.0.0/0) is directed to VyOS (via its instance or network interface target).
- Private Instance Deployment:
  - A private instance is deployed using Amazon Linux 2 in the private subnet.
  - Security groups are configured to allow SSH and ICMP traffic between VyOS and the private instance.
- Connectivity Testing:
  - Basic connectivity is verified through ping tests from VyOS to the private instance and to external IPs (e.g., 8.8.8.8).
  - SSH connectivity from VyOS to the private instance is tested (via the default SSH port on the private instance).
Despite some intermittent connectivity issues during testing, the core components have been set up, including interface configuration, NAT, and routing, laying a robust foundation for advanced network automation.
#### Here is a proof of deployed VPC with VyOS (free-tier) routing for subnets. (eth0 represents the public subnet with internet access, eth1 represents the private subnet with restricted access)
![image](https://github.com/user-attachments/assets/c6589e78-3134-4e06-b817-f8ff556ea9e8)


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
