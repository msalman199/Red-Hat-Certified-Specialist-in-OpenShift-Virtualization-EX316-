<div align="center">

# 🩺 OpenShift Virtualization: VM Health Probes & Monitoring

### Readiness and Liveness Probes, Failure Recovery, and Custom Health Monitoring

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Health Probes](https://img.shields.io/badge/Health_Probes-2E7D32?style=for-the-badge&logo=kubernetes&logoColor=white)
![Monitoring](https://img.shields.io/badge/Monitoring-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Red Hat](https://img.shields.io/badge/Red_Hat-CC0000?style=for-the-badge&logo=redhat&logoColor=white)

</div>

---

## 📑 Table of Contents

- [📖 Overview](#-overview)
- [✅ What You Accomplished](#-what-you-accomplished)
- [💡 Key Takeaways](#-key-takeaways)
- [🔑 Key Concepts](#-key-concepts)
- [🧹 Cleanup Resources](#-cleanup-resources)
- [🚀 Next Steps](#-next-steps)
- [🏁 Conclusion](#-conclusion)

---

## 📖 Overview

This lab covers **health probes for virtual machines** in OpenShift Virtualization. You configured readiness and liveness probes over HTTP and TCP, simulated failures to verify automatic recovery, monitored VM health from the CLI and web console, and built custom monitoring with automated health checks.

> 🧪 **Lab Environment:** OpenShift cluster with OpenShift Virtualization installed. All lab resources live in the `vm-health-probes` project.

---

## ✅ What You Accomplished

In this lab, you successfully:

1. 🔹 **Configured Health Probes:** Set up both readiness and liveness probes for VMs using HTTP and TCP protocols
2. 🔹 **Tested Probe Functionality:** Simulated failures and verified automatic recovery mechanisms
3. 🔹 **Monitored VM Health:** Used both CLI and web console to monitor VM health status
4. 🔹 **Implemented Advanced Monitoring:** Created custom monitoring solutions with automated health checks

---

## 💡 Key Takeaways

- 🚦 Readiness probes determine when a VM is ready to receive traffic
- 🔁 Liveness probes automatically restart unhealthy VMs
- ⏱️ Probe configuration requires careful tuning of timeouts and thresholds
- 📊 Monitoring is essential for maintaining VM health in production environments

---

## 🔑 Key Concepts

| 🏷️ Term | 📘 Description |
|---|---|
| **Readiness Probe** | Determines when a VM is ready to receive traffic |
| **Liveness Probe** | Automatically restarts unhealthy VMs |
| **HTTP Probe** | Probe that checks VM health over HTTP |
| **TCP Probe** | Probe that checks VM health over a TCP connection |
| **Timeouts and Thresholds** | Settings that require careful tuning for reliable probe behavior |
| **Custom Health Monitoring** | Automated health checks built beyond the built-in probes |

---

## 🧹 Cleanup Resources

```bash
# 🗑️ Delete all VMs created in this lab
oc delete vm --all -n vm-health-probes

# 🗑️ Delete the monitoring resources
oc delete cronjob vm-health-checker -n vm-health-probes
oc delete pod health-monitor -n vm-health-probes
oc delete service vm-health-monitor -n vm-health-probes
oc delete configmap health-check-script -n vm-health-probes

# 🗑️ Delete the project
oc delete project vm-health-probes

# ✅ Verify cleanup
oc get projects | grep vm-health-probes
```

---

## 🚀 Next Steps

To further enhance your OpenShift Virtualization skills:

1. 🔬 Explore guest agent probes for more detailed VM monitoring
2. 📈 Integrate with Prometheus for advanced metrics collection
3. 🔔 Set up alerting based on VM health status
4. 🩺 Implement custom health endpoints in your applications
5. 🛡️ Study high availability configurations for critical VMs

---

## 🏁 Conclusion

This lab provided hands-on experience with VM health monitoring, a critical skill for managing production virtualized workloads in OpenShift environments.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

</div>
