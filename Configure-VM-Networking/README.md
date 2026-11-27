<div align="center">

# 🌐 OpenShift Virtualization: Static IPs & Network Policies

### Predictable VM Addressing and Micro-Segmentation with NADs, cloud-init, and Network Policies

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Network Policies](https://img.shields.io/badge/Network_Policies-2E7D32?style=for-the-badge&logo=cilium&logoColor=white)
![cloud-init](https://img.shields.io/badge/cloud--init-FF6F00?style=for-the-badge&logo=linux&logoColor=white)
![Red Hat](https://img.shields.io/badge/Red_Hat-CC0000?style=for-the-badge&logo=redhat&logoColor=white)

</div>

---

## 📑 Table of Contents

- [📖 Overview](#-overview)
- [✅ Key Accomplishments](#-key-accomplishments)
- [💡 Why This Matters](#-why-this-matters)
- [🔑 Key Concepts](#-key-concepts)
- [🏢 Real-World Applications](#-real-world-applications)
- [🎓 Certification Relevance](#-certification-relevance)
- [🏁 Conclusion](#-conclusion)

---

## 📖 Overview

This lab covers the networking and security side of running virtual machines on **OpenShift Virtualization**. You assigned **static IP addresses** to VMs using **Network Attachment Definitions (NADs)** and **cloud-init**, then used **Network Policies** to control traffic between VMs and external networks, and tested a range of communication scenarios along the way.

> 🧪 **Lab Environment:** OpenShift cluster with OpenShift Virtualization installed. Work is done with the `oc` CLI and YAML manifests.

---

## ✅ Key Accomplishments

In this comprehensive lab, you have successfully:

- 🔹 **Configured static IP addresses** for virtual machines using Network Attachment Definitions and cloud-init, providing predictable network addressing for VM workloads
- 🔹 **Implemented Network Policies** to control traffic flow between VMs and external networks, demonstrating micro-segmentation capabilities in OpenShift Virtualization
- 🔹 **Tested various network communication scenarios** including VM-to-VM, VM-to-external, and policy-restricted traffic flows
- 🔹 **Gained hands-on experience** with OpenShift's Software Defined Networking (SDN) for virtualization workloads

---

## 💡 Why This Matters

Network configuration and security are critical aspects of virtualization in production environments. The skills you've developed enable you to:

| 🎯 Capability | 📝 Description |
|---|---|
| 🧱 **Network Segmentation** | Design secure, isolated network segments for different application tiers |
| 🔐 **Zero-Trust Networking** | Implement zero-trust networking principles in virtualized environments |
| 🛠️ **Troubleshooting** | Troubleshoot complex networking issues in OpenShift Virtualization deployments |
| 📋 **Compliance** | Meet compliance requirements through network segmentation and access controls |

---

## 🔑 Key Concepts

| 🏷️ Term | 📘 Description |
|---|---|
| **Network Attachment Definition (NAD)** | Resource that defines an additional network a VM can attach to |
| **cloud-init** | Initialization mechanism used to configure a VM's network settings, including static IPs, at boot |
| **Static IP Addressing** | Fixed, predictable addresses assigned to VM workloads |
| **Network Policy** | Rules that control which traffic is allowed between VMs and external networks |
| **Micro-Segmentation** | Isolating workloads into small, controlled network segments |
| **Software Defined Networking (SDN)** | OpenShift's networking layer used for virtualization workloads |
| **Zero-Trust Networking** | Security model in which communication is restricted to what is explicitly allowed |

---

## 🏢 Real-World Applications

- 🏗️ Isolating application tiers in production virtualized environments
- 🔒 Enforcing controlled communication between workloads where security and isolation are paramount
- 📊 Supporting compliance requirements through segmentation and access controls
- 🌍 Giving VM workloads predictable network addressing in enterprise deployments

---

## 🎓 Certification Relevance

These networking capabilities are essential for the **Red Hat Certified Specialist in OpenShift Virtualization** certification and for real-world enterprise deployments where security, isolation, and controlled communication between workloads are paramount.

---

## 🏁 Conclusion

The combination of static IP assignment and Network Policies provides a robust foundation for building secure, scalable virtualized applications in OpenShift environments.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

</div>
