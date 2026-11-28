<div align="center">

# 🛡️ OpenShift Virtualization: SELinux & AppArmor VM Isolation

### Mandatory Access Controls, QEMU Contexts & Security Auditing

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![SELinux](https://img.shields.io/badge/SELinux-0A66C2?style=for-the-badge&logo=redhat&logoColor=white)
![AppArmor](https://img.shields.io/badge/AppArmor-F58220?style=for-the-badge&logo=linux&logoColor=white)
![QEMU](https://img.shields.io/badge/QEMU-FF6600?style=for-the-badge&logo=qemu&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)

</div>

---

## 📑 Table of Contents

- [🎯 Overview](#-overview)
- [🏆 Key Accomplishments](#-key-accomplishments)
- [🔐 Core Security Principle](#-core-security-principle)
- [🧠 Key Concepts](#-key-concepts)
- [✅ Conclusion](#-conclusion)

---

## 🎯 Overview

This lab focuses on **mandatory access controls (MAC) for virtualization platforms**. Students verified SELinux enforcement on OpenShift Virtualization nodes, interpreted the SELinux context of a live QEMU process, and attached a custom AppArmor profile to a KubeVirt virtual machine. They also built a repeatable audit script that reports on the security posture of the nodes and VMs.

---

## 🏆 Key Accomplishments

| # | 🏅 Skill | 📝 What You Achieved |
|---|----------|---------------------|
| 1 | 🔒 **SELinux Verification** | Verified SELinux enforcement on OpenShift Virtualization nodes |
| 2 | 🔍 **QEMU Context Analysis** | Inspected and correctly interpreted the SELinux context of a live QEMU process |
| 3 | 🧱 **Custom AppArmor Profile** | Built and loaded a custom AppArmor profile |
| 4 | 🏷️ **Profile Attachment** | Successfully attached the AppArmor profile to a KubeVirt virtual machine through pod annotations |
| 5 | 📋 **Security Audit Script** | Built a repeatable audit script that summarizes SELinux mode, loaded AppArmor profiles, and VM security labeling in a single report |
| 6 | 📈 **Monitoring Baseline** | Gained a practical baseline for ongoing security monitoring |

---

## 🔐 Core Security Principle

Mandatory access controls such as **SELinux** and **AppArmor** provide layered, kernel-enforced isolation between VM workloads. This complements Kubernetes-level access controls.

> ⚠️ Both layers must be **verified and audited** rather than assumed to be working correctly by default.

---

## 🧠 Key Concepts

| 🔑 Concept | 📖 Description |
|-----------|----------------|
| **Mandatory Access Control (MAC)** | Kernel-enforced access policy that applies regardless of user or process discretion |
| **SELinux Enforcement** | SELinux mode on the nodes, verified to confirm policy is actively enforced |
| **SELinux Context (QEMU Process)** | The security label on a live QEMU process, which determines how that VM process is confined |
| **AppArmor Profile** | A custom profile built and loaded to confine a VM workload |
| **Pod Annotations** | The mechanism used to attach the AppArmor profile to a KubeVirt VM |
| **VM Security Labeling** | The security labels applied to VMs, reported by the audit script |
| **Security Audit Script** | A repeatable script summarizing SELinux mode, loaded AppArmor profiles, and VM security labeling in a single report |
| **Layered Isolation** | Kernel-level MAC working alongside Kubernetes-level access controls |

---

## ✅ Conclusion

In this lab, students verified SELinux enforcement, interpreted a live QEMU process's SELinux context, and attached a custom AppArmor profile to a KubeVirt VM through pod annotations. The audit script they built gives them a practical baseline for ongoing security monitoring. Together, these exercises reinforce that kernel-enforced mandatory access controls complement Kubernetes-level access controls, and that both layers must be verified and audited rather than assumed.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

**Happy Learning! 🚀**

</div>
