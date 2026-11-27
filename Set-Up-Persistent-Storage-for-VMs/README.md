<div align="center">

# 💾 Lab 8: Set Up Persistent Storage for VMs

### PVCs, Persistent Disks, Performance Testing, Resilience, and Snapshots in OpenShift Virtualization

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![PVC](https://img.shields.io/badge/PersistentVolumeClaims-2E7D32?style=for-the-badge&logo=kubernetes&logoColor=white)
![fio](https://img.shields.io/badge/dd_%2B_fio-FF6F00?style=for-the-badge&logo=linux&logoColor=white)
![Red Hat](https://img.shields.io/badge/Red_Hat-CC0000?style=for-the-badge&logo=redhat&logoColor=white)

</div>

---

## 📑 Table of Contents

- [📖 Overview](#-overview)
- [✅ Key Achievements](#-key-achievements)
- [💡 Why This Matters](#-why-this-matters)
- [🔑 Key Concepts](#-key-concepts)
- [🚀 Next Steps](#-next-steps)
- [🎓 Certification Relevance](#-certification-relevance)
- [🏁 Conclusion](#-conclusion)

---

## 📖 Overview

This lab covers **persistent storage for virtual machines** in OpenShift Virtualization. You created PersistentVolumeClaims with different access and volume modes, attached persistent storage to VMs as root and data disks, tested storage performance and resilience, and explored volume snapshots and multi-storage configurations.

> 🧪 **Lab Environment:** OpenShift cluster with OpenShift Virtualization installed. Work is done with the `oc` CLI and YAML manifests.

---

## ✅ Key Achievements

Congratulations! You have successfully completed **Lab 8: Set Up Persistent Storage for VMs**. In this comprehensive lab, you have accomplished the following:

1. 🔹 **Created Multiple Types of PVCs:** You learned to create PersistentVolumeClaims with different access modes (ReadWriteOnce, ReadWriteMany) and volume modes (Block, Filesystem) suitable for various VM storage requirements.
2. 🔹 **Attached Persistent Storage to VMs:** You successfully configured virtual machines to use persistent storage for both root disks and additional data disks, ensuring data persistence across VM lifecycle events.
3. 🔹 **Verified Storage Performance:** You performed storage performance tests using tools like `dd` and `fio` to understand the I/O capabilities of your persistent storage configuration.
4. 🔹 **Tested Storage Resilience:** You validated that data persists across VM reboots, restarts, and simulated failures, demonstrating the reliability of persistent storage in virtualized environments.
5. 🔹 **Implemented Advanced Storage Features:** You explored volume snapshots for backup and recovery, and configured VMs with multiple storage types for complex use cases.

---

## 💡 Why This Matters

Understanding persistent storage for VMs is crucial because:

| 🎯 Area | 📝 Benefit |
|---|---|
| 🛡️ **Data Durability** | Ensures critical data survives VM restarts and failures |
| ⚡ **Performance Optimization** | Proper storage configuration directly impacts application performance |
| 🔄 **Backup and Recovery** | Volume snapshots provide essential backup capabilities |
| 📦 **Resource Management** | Efficient storage allocation helps optimize cluster resources |
| 🏭 **Production Readiness** | These skills are essential for running production workloads in OpenShift Virtualization |

---

## 🔑 Key Concepts

| 🏷️ Term | 📘 Description |
|---|---|
| **PersistentVolumeClaim (PVC)** | Request for storage that backs VM root and data disks |
| **ReadWriteOnce (RWO)** | Access mode allowing the volume to be mounted read-write by a single node |
| **ReadWriteMany (RWX)** | Access mode allowing the volume to be mounted read-write by multiple nodes |
| **Block Volume Mode** | Volume exposed as a raw block device |
| **Filesystem Volume Mode** | Volume exposed with a filesystem |
| **Root Disk / Data Disk** | The VM's boot disk and any additional attached disks |
| **dd / fio** | Tools used to test the I/O capabilities of the storage configuration |
| **Volume Snapshot** | Point-in-time copy used for backup and recovery |

---

## 🚀 Next Steps

With this foundation in VM persistent storage, you can now:

- 🏗️ Design storage architectures for complex virtualized applications
- 💽 Implement backup and disaster recovery strategies
- 📈 Optimize storage performance for specific workload requirements
- 🛠️ Troubleshoot storage-related issues in production environments
- 🎯 Prepare for advanced OpenShift Virtualization certification scenarios

---

## 🎓 Certification Relevance

This lab has provided you with practical, hands-on experience that directly applies to real-world OpenShift Virtualization deployments and prepares you for the **Red Hat Certified Specialist in OpenShift Virtualization** certification.

---

## 🏁 Conclusion

Lab 8 gave you hands-on experience creating, attaching, testing, and protecting persistent storage for virtual machines in OpenShift Virtualization.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

</div>
