<div align="center">

# 🧩 OpenShift Virtualization: Parameterized VM Templates & Validation

### Repeatable VM Deployments with Templates and a Bash Pass/Fail Validation Harness

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Templates](https://img.shields.io/badge/VM_Templates-2E7D32?style=for-the-badge&logo=redhat&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Red Hat](https://img.shields.io/badge/Red_Hat-CC0000?style=for-the-badge&logo=redhat&logoColor=white)

</div>

---

## 📑 Table of Contents

- [📖 Overview](#-overview)
- [✅ Key Accomplishments](#-key-accomplishments)
- [🔑 Key Concepts](#-key-concepts)
- [🏢 Real-World Applications](#-real-world-applications)
- [🚀 Next Steps](#-next-steps)
- [🏁 Conclusion](#-conclusion)

---

## 📖 Overview

This lab covers building **parameterized OpenShift Virtualization templates** and using them to deploy VMs with consistent, repeatable configurations. You also completed scaffolded bash scripts that query VM state through `oc` and JSONPath, and built a pass/fail validation harness to confirm that deployed VMs and PVCs match their expected template and state.

> 🧪 **Lab Environment:** OpenShift cluster with OpenShift Virtualization installed. Work is done with the `oc` CLI and bash scripts.

---

## ✅ Key Accomplishments

In this comprehensive lab, you have successfully:

- 🔹 **Built three parameterized templates** covering basic, storage-backed, and database workloads
- 🔹 **Deployed and started five virtual machines** with consistent, repeatable configurations
- 🔹 **Authored bash-based verification tooling** by completing scaffolded scripts that queried VM specs, node placement, and resource usage through `oc` and JSONPath
- 🔹 **Built a full pass/fail validation harness** to confirm that every deployed VM and PVC matched its expected template and state
- 🔹 **Learned how template parameters drive consistency** in VM sizing and storage allocation
- 🔹 **Inspected VirtualMachine and VirtualMachineInstance objects** for troubleshooting
- 🔹 **Diagnosed common failures** in scheduling, storage binding, and networking

---

## 🔑 Key Concepts

| 🏷️ Term | 📘 Description |
|---|---|
| **OpenShift Template** | Parameterized resource definition used to deploy VMs with consistent configurations |
| **Template Parameters** | Values that drive consistent VM sizing and storage allocation |
| **VirtualMachine (VM)** | Object defining the desired state of a virtual machine |
| **VirtualMachineInstance (VMI)** | Object representing a running VM, inspected for troubleshooting |
| **PVC** | Persistent storage claim backing storage-backed and database VMs |
| **JSONPath** | Query syntax used with `oc` to extract VM specs, node placement, and resource usage |
| **Validation Harness** | Bash script that reports pass/fail for each VM and PVC against expected state |

---

## 🏢 Real-World Applications

- 📐 Standardizing VM sizing and storage across basic, storage-backed, and database workloads
- 🔁 Deploying repeatable VM configurations from a single template
- ✅ Automating verification of deployed VMs and PVCs against expected state
- 🛠️ Troubleshooting scheduling, storage binding, and networking failures

---

## 🚀 Next Steps

As a next step, consider:

- 🔄 Extending these templates with live migration policies
- 🔗 Integrating them with GitOps pipelines for automated template versioning
- 📈 Adding automated performance regression checks to the validation script you wrote in Task 3

---

## 🏁 Conclusion

In this lab, you used parameterized templates to deploy five VMs with consistent configurations and built validation tooling to confirm each one matched its expected state.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

</div>
