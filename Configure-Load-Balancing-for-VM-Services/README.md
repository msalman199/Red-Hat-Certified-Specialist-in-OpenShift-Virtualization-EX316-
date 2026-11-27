<div align="center">

# ⚖️ OpenShift Virtualization: Load Balancing for VM Services

### ClusterIP, NodePort, and LoadBalancer Services for VM-Based Applications

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Services](https://img.shields.io/badge/K8s_Services-2E7D32?style=for-the-badge&logo=kubernetes&logoColor=white)
![Load Balancing](https://img.shields.io/badge/Load_Balancing-6A1B9A?style=for-the-badge&logo=nginx&logoColor=white)
![Red Hat](https://img.shields.io/badge/Red_Hat-CC0000?style=for-the-badge&logo=redhat&logoColor=white)

</div>

---

## 📑 Table of Contents

- [📖 Overview](#-overview)
- [✅ Key Accomplishments](#-key-accomplishments)
- [💡 Why This Matters](#-why-this-matters)
- [🔑 Key Concepts](#-key-concepts)
- [🎓 Certification Relevance](#-certification-relevance)
- [🏁 Conclusion](#-conclusion)

---

## 📖 Overview

This lab covers **load balancing for VM-based applications** in OpenShift Virtualization. You created multiple VMs running web servers, exposed them through ClusterIP, NodePort, and LoadBalancer services, tested traffic distribution across the VM instances, and implemented session affinity and health checks.

> 🧪 **Lab Environment:** OpenShift cluster with OpenShift Virtualization installed. Work is done with the `oc` CLI and YAML manifests.

---

## ✅ Key Accomplishments

In this lab, you have successfully:

- 🔹 **Created multiple Virtual Machines** running web servers that can serve as backend services
- 🔹 **Configured three types of Kubernetes services** (ClusterIP, NodePort, and LoadBalancer) to provide load balancing for VM-based applications
- 🔹 **Tested load balancing functionality** by sending multiple requests and observing traffic distribution across VM instances
- 🔹 **Implemented advanced features** like session affinity and health checks for more sophisticated load balancing scenarios
- 🔹 **Monitored and troubleshot** load balancing services to ensure proper operation

---

## 💡 Why This Matters

Load balancing for VM services in OpenShift Virtualization is crucial for:

| 🎯 Area | 📝 Benefit |
|---|---|
| 🛡️ **High Availability** | Distributing traffic across multiple VM instances prevents single points of failure |
| 📈 **Scalability** | Enabling horizontal scaling of virtualized applications |
| ⚡ **Performance** | Optimizing resource utilization and response times |
| 🌉 **Migration Path** | Providing a bridge for traditional VM-based applications moving to container platforms |
| 🔀 **Hybrid Deployments** | Supporting mixed environments with both containerized and virtualized workloads |

---

## 🔑 Key Concepts

| 🏷️ Term | 📘 Description |
|---|---|
| **ClusterIP Service** | Service type providing internal load balancing for VM backends |
| **NodePort Service** | Service type exposing VM backends on a port of each node |
| **LoadBalancer Service** | Service type exposing VM backends through an external load balancer |
| **Session Affinity** | Directing repeat requests from a client to the same VM instance |
| **Health Check** | Verification that a backend VM is able to serve traffic |
| **Backend VM** | VM running a web server that serves as a backend service |

---

## 🎓 Certification Relevance

This knowledge is essential for the **Red Hat Certified Specialist in OpenShift Virtualization** certification and real-world enterprise deployments where traditional applications need to be modernized while maintaining familiar operational patterns.

---

## 🏁 Conclusion

The skills you've learned enable you to design resilient, scalable virtualized applications that leverage Kubernetes networking capabilities while maintaining the flexibility and familiarity of traditional VM-based architectures.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

</div>
