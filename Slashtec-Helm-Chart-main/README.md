# Slashtec-Helm-Chart
## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  ```helm repo add slashtec https://slashtec-code.github.io/Slashtec-Helm-Chart```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  

You can then run `helm search repo slashtec` to see the charts.

To install the <chart-name> chart:

    ```helm install my-<chart-name> <alias>/<chart-name>```
Ex:  ```helm install my-service slashtec/slashtec-helm-chart -f values.yaml```

To uninstall the chart:

    ```helm delete my-<chart-name>```

## Parameters

| Name | Description                                                                                | Value                                       |
| ---| ---------------------------------------------------------------------------------------------|---------------------------------------------|
| nameOverride: &nameOverride | Name of the service                                                         | `my-service`                               |
| fullnameOverride: &fullnameOverride | full name of service      | `my-service`                               |
| cluster: &cluster |  define cluster name                                                  | `dev`                     |
| environment: &environment | define environment                                                               | `dev`                                  |

### Deployment Paramaters

| Name                                             | Description                                           | Value                                                                                         |
|--------------------------------------------------|-------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| deployment.enabled                               | Enable deployment on helm chart deployments           | true                                                                                          |
| deployment.replicaCount                          | Replicas to be created                                | 1                                                                                             |
| deployment.revisionHistoryLimit                  | The number of old history to retain to allow rollback | 1                                                                                             |
| deployment.strategy.type                         | Strategy for updating deployments                     | RollingUpdate                                                                                 |
| deployment.strategy.rollingUpdate.maxUnavailable | maxUnavailable when updating deployments              | 0                                                                                             |
| deployment.strategy.rollingUpdate.maxSurge       | maxSurge when updating deployments                    | 2                                                                                             |
| deployment.terminationGracePeriodSeconds         | Graceful termination timeout                          | 5                                                                                             |
| deployment.service.port.containerPort            | Ports for primary container                           | 80                                                                                            |

#### Deployment Resources Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| deployment.resources | Application pod resource requests & limits                                                       | See below       |

##### Requests and Limits

```
  resources:
    requests:
      memory: 512Mi
      cpu: 200m
    limits:
      memory: 1024Mi
      cpu: 1
```

#### Deployment InitContainers Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| deployment.initContainers | Init containers which runs before the app container                                         | `{}`            |



#### Deployment Image Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| deployment.image.repository | Image repository for the application                                                      | `<acc-id>.dkr.ecr.<region>.amazonaws.com/<repo-name>`  |
| deployment.image.tag | Tag of the application image                                                                     | `null`          |
| deployment.image.pullPolicy | Pull policy for the application image                                                     | `IfNotPresent`  |

#### Deployment envFrom Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| deployment.envFrom | Environment variables to be picked from configmap or secret                                        | `"externalSecret"`            |

#### Deployment Probes Paramaters


##### Readiness Probe
Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails.

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| deployment.readinessProbe.enabled | Enabled readiness probe                                                                  | true       |
| deployment.readinessProbe.failureThreshold | When a probe fails, Kubernetes will try failureThreshold times before giving up.                                                                  | 3      |
| deployment.readinessProbe.periodSeconds | Perform probe  everytime after specified periodSeconds                                                                  | 10       |
| deployment.readinessProbe.successThreshold | Minimum consecutive successes for the probe to be considered successful after having failed.                                                                  | 1       |
| deployment.readinessProbe.timeoutSeconds | Number of seconds after which the probe times out.                                                                  | 1       |
| deployment.readinessProbe.initialDelaySeconds | Number of seconds after the container has started before liveness or readiness probes are initiated.                                                                  | 20       |
| deployment.readinessProbe.httpGet | Describes an action based on HTTP Get requests                                                                  |   path: '/path' port: 8080     |
| deployment.readinessProbe.exec | Kubelet executes the specified command to perform the probe                                                                  |   {}   |

##### Liveness Probe
Periodic probe of container liveness. Container will be restarted if the probe fails.

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| deployment.livenessProbe.enabled | Enabled livenessProbe probe                                                                  | true       |
| deployment.livenessProbe.failureThreshold | When a probe fails, Kubernetes will try failureThreshold times before giving up.                                                                  | 3      |
| deployment.livenessProbe.periodSeconds | Perform probe  everytime after specified periodSeconds                                                                  | 10       |
| deployment.livenessProbe.successThreshold | Minimum consecutive successes for the probe to be considered successful after having failed.                                                                  | 1       |
| deployment.livenessProbe.timeoutSeconds | Number of seconds after which the probe times out.                                                                  | 1       |
| deployment.livenessProbe.initialDelaySeconds | Number of seconds after the container has started before liveness or readiness probes are initiated.                                                                  | 20       |
| deployment.livenessProbe.httpGet | Describes an action based on HTTP Get requests                                                                  |   path: '/path' port: 8080     |
| deployment.livenessProbe.exec | Kubelet executes the specified command to perform the probe                                                                  | {}      |


### Persistence Paramaters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| persistence.enabled | Enable persistence                                                                                                                                                                               | `false`                                                                                                                                               |
| deployment.volumeMounts.mountPath | If `persistence.enabled` is set, so where to mount the volume in the deployment                                                                                                                 | `/`                                                                                                                                                   |
| persistence.accessMode | Access mode for volume                                                                                                                                                                           | `ReadWriteOnce`                                                                                                                                       |
| persistence.storageClass | StorageClass of the volume                                                                                                                                                                       | `gp3`|
| persistence.size | Size of the persistent volume                                                                                                                                                                    | `10Gi`   
   

### Service Paramaters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| service.enabled | Enable service in helm chart                                                                                                                                                                    | `true`                                                                                                                                           |
| service.port | Ports for applications service                                                                                                                                                                   | - port: 8080<br>&nbsp;&nbsp;name: http<br>&nbsp;&nbsp;protocol: TCP<br>&nbsp;&nbsp;targetPort: 8080                                                   |
| service.type | Type of service                                                                                                                                                                          | `NodePort`                                                                                                                                                  |


### Ingress Paramaters

| Name | Description | Value |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| ingress.enabled | Enable ingress | `false` |
| ingress.hosts | Array of hosts to be served by this ingress. | `[]` |
| ingress.hosts[].host | Host to be served. | `[]` |
| ingress.hosts[].paths | Paths against the host. If not specified, default configuration is added | `[]` |
| ingress.annotations | Annotations for ingress | `{}` |
| ingress.tls.enabled | TLS block for ingress | `false` |
| ingress.className | Name of the ingress class | 'nginx' |



### ServiceMonitor Paramaters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| serviceMonitor.enabled | Enable serviceMonitor                                                                                                                                                                            | `false`                                                                                                                                               |
| serviceMonitor.additionalLabels | Labels for serviceMonitor                                                                                                                                                                        | `{}`                                                                                                                                                  |
| serviceMonitor.annotations | Annotations for serviceMonitor                                                                                                                                                                   | `{}`                                                                                                                                                  |
| serviceMonitor.jobLabel | Job Label used for application selector                                                                                                                                                          | `k8s-app`                                                                                                                                             |
| serviceMonitor.endpoints | Array of endpoints to be scraped by prometheus                                                                                                                                                   | - interval: 5s<br>&nbsp;&nbsp;path: /actuator/prometheus<br>&nbsp;&nbsp;port: http                                                                    |

### Autoscaling Paramaters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| autoscaling.enabled | Enable horizontal pod autoscaler                                                                                                                                                                 | `false`                                                                                                                                               |
| autoscaling.minReplicas | Sets minimum replica count when autoscaling is enabled                                                                                                                                           | `1`                                                                                                                                                   |
| autoscaling.maxReplicas | Sets maximum replica count when autoscaling is enabled                                                                                                                                           | `2`                                                                                                                                                  |
| autoscaling.targetCPUUtilizationPercentage    | percentage of targetCPUUtilization    | 85    |
| autoscaling.targetMemoryUtilizationPercentage | percentage of targetMemoryUtilization | 89    |


                            |

### ExternalSecret Paramaters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| externalSecret.enabled | Enables External Secret Custom Resource                                                                                                                                                          | `false`                                                                                                                                               |
| externalSecret.secretStore | Defines name of default SecretStore to use when fetching the secret data                                                                                                                         | `global-secret-store`                                                                                                                           |
| externalSecret.kind | Defines kind as SecretStore or ClusterSecretStore                                                                                                                                                | `ClusterSecretStore`                                                                                                                                         |
| externalSecret.secretPath | path to secret                                                                                                        | `/path/to/secret`                                                                                                                                                  |
| externalSecret.suffix | externalSecret suffix                                                                                                | `secret`                                                                                                                                                  |

### CronJob Parameters

| Name                     | Description                                                                                  | Value           |
| ------------------------ | -------------------------------------------------------------------------------------------- | --------------- |
| `cronJob.enabled`        | Enable cronjob in application chart                                                          | `""`            |
| `cronJob.jobs`           | cronjobs spec                                                                                | {}              |




## Configuring probes

To disable liveness or readiness probe, set value of `enabled` to `false`.

```
  livenessProbe:
    enabled: false
```

By default probe handler type is `httpGet`. You just need to override `port` and `path` as per your need.

```
  livenessProbe:
    enabled: true
    httpGet:
      path: '/path'
      port: 8080
```

In order to use `exec` handler, you can define field `livenessProbe.exec` in your values.yaml.

```
  livenessProbe:
    enabled: true
    exec:
      command:
        - cat
        - /tmp/healthy
```

