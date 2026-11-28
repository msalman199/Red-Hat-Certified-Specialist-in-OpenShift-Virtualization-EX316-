<div align="center">

# 🤖 OpenShift Virtualization: VM Lifecycle Automation Scripts

### Create, Scale, Delete & Back Up VMs with the `oc` CLI

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![YAML](https://img.shields.io/badge/YAML-CB171E?style=for-the-badge&logo=yaml&logoColor=white)
![Cron](https://img.shields.io/badge/Cron-FCC624?style=for-the-badge&logo=linux&logoColor=black)

</div>

---

## 📑 Table of Contents

- [🎯 Overview](#-overview)
- [🏆 Key Accomplishments](#-key-accomplishments)
- [🧩 Automation Patterns Demonstrated](#-automation-patterns-demonstrated)
- [🧠 Key Concepts](#-key-concepts)
- [🌍 Real-World Applications](#-real-world-applications)
- [🚀 Next Steps](#-next-steps)
- [✅ Conclusion](#-conclusion)

---

## 🎯 Overview

In this lab, students built a complete set of **shell-based automation scripts for managing OpenShift Virtualization VMs**. The scripts cover creation, scaling, deletion, and configuration backup, and use only the `oc` CLI and the stable `kubevirt.io/v1` API.

---

## 🏆 Key Accomplishments

| # | 🏅 Skill | 📝 What You Achieved |
|---|----------|---------------------|
| 1 | 🆕 **VM Creation** | Built a shell script that creates OpenShift Virtualization VMs through the `oc` CLI |
| 2 | 📏 **VM Scaling** | Built a shell script that scales VMs |
| 3 | 🗑️ **VM Deletion** | Built a shell script that deletes VMs, with graceful shutdown before the destructive operation |
| 4 | 💾 **Configuration Backup** | Built a backup script that exports VM configuration as compressed YAML, rather than relying on optional snapshot controllers |
| 5 | 🔌 **Stable API Usage** | Performed all automation through the `oc` CLI and the stable `kubevirt.io/v1` API |

---

## 🧩 Automation Patterns Demonstrated

| 🔑 Pattern | 📖 What It Shows |
|-----------|------------------|
| ✔️ **Input Validation** | Scripts check their inputs before acting |
| ♻️ **Idempotency Checks** | Scripts can be safely re-run without unintended side effects |
| 📝 **Structured Logging** | Script actions are recorded in a consistent, structured format |
| 🛑 **Graceful Shutdown** | VMs are shut down gracefully before destructive operations |
| 📉 **Graceful Degradation** | Backups as compressed YAML exports work across differently configured clusters |

---

## 🧠 Key Concepts

| 🔑 Concept | 📖 Description |
|-----------|----------------|
| **`oc` CLI Automation** | Managing VM lifecycle operations entirely through shell scripts that call the `oc` CLI |
| **`kubevirt.io/v1` API** | The stable KubeVirt API used for all VM operations in the scripts |
| **Idempotency** | Designing scripts so repeated runs produce the same result |
| **Structured Logging** | Consistent log output from automation scripts |
| **Graceful Shutdown** | Cleanly stopping a VM before deleting it |
| **YAML Export Backup** | Compressed YAML exports of VM configuration, used instead of optional snapshot controllers |
| **Cron-Based Scheduling** | The schedule used to run the scripts in this lab |

---

## 🌍 Real-World Applications

The automation patterns in this lab (input validation, idempotency checks, structured logging, and graceful shutdown before destructive operations) are directly applicable to production VM fleet management. Building backups as compressed YAML exports also shows how to write automation that degrades gracefully across differently configured clusters.

---

## 🚀 Next Steps

- 💽 Integrate the scripts with a real snapshot or CSI-based backup solution where available
- 🔔 Add Slack or email alerting on script failure
- ☸️ Convert the cron-based schedule into a Kubernetes CronJob running inside the cluster for centralized management

---

## ✅ Conclusion

In this lab, students built shell-based scripts that create, scale, delete, and back up OpenShift Virtualization VMs entirely through the `oc` CLI and the stable `kubevirt.io/v1` API. The scripts apply input validation, idempotency checks, structured logging, and graceful shutdown, and the YAML-export backup approach shows how to build automation that works across differently configured clusters.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

**Happy Learning! 🚀**

</div>
