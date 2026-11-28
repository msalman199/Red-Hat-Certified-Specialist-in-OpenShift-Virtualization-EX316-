<div align="center">

# 📈 OpenShift Virtualization: VM Monitoring & Alerting

### User Workload Monitoring, KubeVirt Metrics & PrometheusRule Alerts

![OpenShift](https://img.shields.io/badge/OpenShift-EE0000?style=for-the-badge&logo=redhatopenshift&logoColor=white)
![KubeVirt](https://img.shields.io/badge/KubeVirt-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![Thanos](https://img.shields.io/badge/Thanos-6D41B0?style=for-the-badge&logo=prometheus&logoColor=white)
![Alertmanager](https://img.shields.io/badge/Alertmanager-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)

</div>

---

## 📑 Table of Contents

- [🎯 Overview](#-overview)
- [🏆 Key Accomplishments](#-key-accomplishments)
- [🧠 Key Concepts](#-key-concepts)
- [🌍 Real-World Applications](#-real-world-applications)
- [🚀 Next Steps](#-next-steps)
- [✅ Conclusion](#-conclusion)

---

## 🎯 Overview

This lab covers monitoring and alerting for virtual machines running under **OpenShift Virtualization**. You enabled user workload monitoring, deployed a VM, and confirmed that KubeVirt's built-in metrics pipeline exposes real CPU, memory, and identity metrics for that VM through Prometheus and the Thanos Querier API. You then authored a `PrometheusRule` that alerts on sustained high vCPU usage and verified it end to end.

---

## 🏆 Key Accomplishments

| # | 🏅 Skill | 📝 What You Achieved |
|---|----------|---------------------|
| 1 | ⚙️ **User Workload Monitoring** | Enabled OpenShift's user workload monitoring |
| 2 | 🖥️ **VM Deployment** | Deployed a virtual machine under OpenShift Virtualization |
| 3 | 📊 **Metrics Verification** | Confirmed KubeVirt's built-in metrics pipeline exposes real CPU, memory, and identity metrics for the VM through Prometheus and the Thanos Querier API |
| 4 | 🚨 **Alert Rule Authoring** | Authored and validated a `PrometheusRule` that alerts on sustained high vCPU usage |
| 5 | ✅ **End-to-End Validation** | Verified the rule was loaded and actively evaluated by the cluster's monitoring stack |

---

## 🧠 Key Concepts

| 🔑 Concept | 📖 Description |
|-----------|----------------|
| **User Workload Monitoring** | OpenShift's monitoring for user-deployed workloads, required to collect metrics from VMs |
| **KubeVirt Metrics Pipeline** | The built-in pipeline that exposes CPU, memory, and identity metrics for VMs |
| **Prometheus** | The metrics system that collects and evaluates VM metrics |
| **Thanos Querier API** | The query endpoint used to read VM metrics from the monitoring stack |
| **ServiceMonitor** | Resource that tells Prometheus which services to scrape for metrics |
| **PrometheusRule** | Resource that defines alerting rules, here for sustained high vCPU usage |
| **Alertmanager** | Component that routes fired alerts to notification channels |

---

## 🌍 Real-World Applications

These are the same mechanisms used to monitor production virtual machine workloads on OpenShift. The `ServiceMonitor`, `PrometheusRule`, and query patterns practiced here translate directly to building dashboards and alerting policies for real VM fleets.

---

## 🚀 Next Steps

- 🧮 Extend the alert rule set with memory and storage thresholds
- 📣 Wire Alertmanager routes to a real notification channel such as email or a chat webhook

---

## ✅ Conclusion

In this lab, you enabled user workload monitoring, confirmed that KubeVirt exposes real VM metrics through Prometheus and the Thanos Querier API, and built a validated `PrometheusRule` for sustained high vCPU usage. The rule was loaded and actively evaluated by the cluster's monitoring stack, giving you a working foundation for production VM monitoring and alerting.

---

<div align="center">

![Al Nafi](https://img.shields.io/badge/Al_Nafi-Cybersecurity_Education-0A66C2?style=for-the-badge)

**Happy Learning! 🚀**

</div>
